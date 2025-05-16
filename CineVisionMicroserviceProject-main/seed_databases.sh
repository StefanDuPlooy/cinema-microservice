#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Starting seeding script for Secure Cinema databases...${NC}"

# Check if docker is running
if ! docker ps > /dev/null 2>&1; then
    echo -e "${RED}Docker is not running. Please start Docker first.${NC}"
    exit 1
fi

# Start PostgreSQL and MongoDB if they're not already running
echo -e "${YELLOW}Ensuring databases are running...${NC}"
docker-compose up -d postgres mongodb

# Wait for databases to be ready
echo -e "${YELLOW}Waiting for databases to be ready...${NC}"
sleep 10

# Create PostgreSQL database if it doesn't exist
echo -e "${YELLOW}Creating PostgreSQL database if it doesn't exist...${NC}"
docker exec -i $(docker ps -q -f name=postgres) psql -U postgres -c "CREATE DATABASE cine_vision;" || echo "Database already exists, continuing..."

# Load SQL seed data directly
echo -e "${YELLOW}Loading SQL seed data directly...${NC}"
docker exec -i $(docker ps -q -f name=postgres) psql -U postgres -d cine_vision < movieService/src/main/resources/data.sql || {
    echo -e "${RED}Failed to load SQL data. Check the SQL script syntax.${NC}"
}

# Seed MongoDB using the JavaScript file
echo -e "${YELLOW}Creating MongoDB seed file...${NC}"
# Create a temporary copy of the seed file to inject the correct hostname
cat > /tmp/mongodb-seed.js << 'EOF'
// MongoDB Seed Script for User Service

// Clear existing collections to avoid duplicates
db.user.drop();
db.claim.drop();

// Create Claims Collection
const adminClaim = {
  "claimName": "ADMIN"
};

const userClaim = {
  "claimName": "USER"
};

// Insert Claims
db.claim.insertMany([adminClaim, userClaim]);

// Get the inserted Claims to reference their IDs
const adminClaimDoc = db.claim.findOne({ claimName: "ADMIN" });
const userClaimDoc = db.claim.findOne({ claimName: "USER" });

// Create Users Collection with references to Claims
const users = [
  {
    "email": "admin@securecinema.com",
    "password": "$2a$10$xn3LI/AjqicFYZFruSwve.681477XaVNaUQbr1gioaWPn4t1KsnmG", // bcrypt hash for 'adminpass'
    "fullName": "Admin User",
    "claim": adminClaimDoc
  },
  {
    "email": "john.smith@example.com",
    "password": "$2a$10$bSx3f0znM5BgvPwQT1W8UOKHRw.MwR76VtxlqHRjmI8xUowv4.1S2", // bcrypt hash for 'password123'
    "fullName": "John Smith",
    "claim": userClaimDoc
  },
  {
    "email": "sarah.johnson@example.com",
    "password": "$2a$10$bSx3f0znM5BgvPwQT1W8UOKHRw.MwR76VtxlqHRjmI8xUowv4.1S2", // bcrypt hash for 'password123'
    "fullName": "Sarah Johnson",
    "claim": userClaimDoc
  }
];

// Insert Users
db.user.insertMany(users);

// Print result
print("Database seeding completed!");
print("Added " + db.claim.count() + " claims");
print("Added " + db.user.count() + " users");
EOF

echo -e "${YELLOW}Seeding MongoDB database...${NC}"
docker cp /tmp/mongodb-seed.js mongodb:/tmp/mongodb-seed.js
docker exec -i mongodb mongosh "mongodb://rootuser:rootpass@127.0.0.1:27017/user?authSource=admin" --file /tmp/mongodb-seed.js || {
    echo -e "${RED}Failed to seed MongoDB. Check if the database is running and accessible.${NC}"
}

# Build and run the applications to apply the SQL script
echo -e "${YELLOW}Building and starting the Movie Service to apply database seed...${NC}"
cd movieService
mvn clean install -DskipTests
cd ..

echo -e "${YELLOW}Building and starting the User Service to apply database seed...${NC}"
cd userService
mvn clean install -DskipTests
cd ..

echo -e "${GREEN}Database seeding completed!${NC}"
echo -e "${GREEN}PostgreSQL seeded with sample movies, actors, etc.${NC}"
echo -e "${GREEN}MongoDB seeded with user accounts.${NC}"
echo -e "\n${YELLOW}Login credentials:${NC}"
echo -e "Admin: admin@securecinema.com / adminpass"
echo -e "Regular User: john.smith@example.com / password123"