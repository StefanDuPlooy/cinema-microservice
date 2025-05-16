#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Starting database seeding for Secure Cinema in Docker...${NC}"

# Wait for PostgreSQL to be ready
echo -e "${YELLOW}Waiting for PostgreSQL to be ready...${NC}"
until PGPASSWORD=12345 psql -h postgres -U postgres -c '\q'; do
  echo "PostgreSQL is unavailable - sleeping"
  sleep 1
done

# Create database 
echo -e "${YELLOW}Creating PostgreSQL database...${NC}"
PGPASSWORD=12345 psql -h postgres -U postgres -c "CREATE DATABASE cine_vision;"

# Wait for MongoDB to be ready
echo -e "${YELLOW}Waiting for MongoDB to be ready...${NC}"
until mongosh --host mongodb --port 27017 -u rootuser -p rootpass --authenticationDatabase admin --eval "db.adminCommand('ping')"; do
  echo "MongoDB is unavailable - sleeping"
  sleep 1
done

# Seed MongoDB
echo -e "${YELLOW}Seeding MongoDB...${NC}"
mongosh mongodb://rootuser:rootpass@mongodb:27017/user_service --file /userService/src/main/resources/mongodb-seed.js

echo -e "${GREEN}Databases initialized and seeded successfully!${NC}"