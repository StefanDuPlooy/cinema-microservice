// MongoDB Seed Script for User Service
// Run this script using: mongo mongodb://rootuser:rootpass@localhost:27017/user_service mongodb-seed.js

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

const customerClaim = {
  "claimName": "CUSTOMER" 
};

// Insert Claims
db.claim.insertMany([adminClaim, userClaim, customerClaim]);

// Get the inserted Claims to reference their IDs
const adminClaimDoc = db.claim.findOne({ claimName: "ADMIN" });
const userClaimDoc = db.claim.findOne({ claimName: "USER" });
const customerClaimDoc = db.claim.findOne({ claimName: "CUSTOMER" });

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
  },
  {
    "email": "michael.brown@example.com",
    "password": "$2a$10$bSx3f0znM5BgvPwQT1W8UOKHRw.MwR76VtxlqHRjmI8xUowv4.1S2", // bcrypt hash for 'password123'
    "fullName": "Michael Brown",
    "claim": userClaimDoc
  },
  {
    "email": "emma.davis@example.com",
    "password": "$2a$10$bSx3f0znM5BgvPwQT1W8UOKHRw.MwR76VtxlqHRjmI8xUowv4.1S2", // bcrypt hash for 'password123'
    "fullName": "Emma Davis",
    "claim": userClaimDoc
  },
  {
    "email": "david.wilson@example.com",
    "password": "$2a$10$bSx3f0znM5BgvPwQT1W8UOKHRw.MwR76VtxlqHRjmI8xUowv4.1S2", // bcrypt hash for 'password123'
    "fullName": "David Wilson",
    "claim": userClaimDoc
  },
  {
    "email": "jennifer.moore@example.com",
    "password": "$2a$10$bSx3f0znM5BgvPwQT1W8UOKHRw.MwR76VtxlqHRjmI8xUowv4.1S2", // bcrypt hash for 'password123'
    "fullName": "Jennifer Moore",
    "claim": userClaimDoc
  },
  {
    "email": "robert.taylor@example.com",
    "password": "$2a$10$bSx3f0znM5BgvPwQT1W8UOKHRw.MwR76VtxlqHRjmI8xUowv4.1S2", // bcrypt hash for 'password123'
    "fullName": "Robert Taylor",
    "claim": userClaimDoc
  },
  {
    "email": "amanda.martinez@example.com",
    "password": "$2a$10$bSx3f0znM5BgvPwQT1W8UOKHRw.MwR76VtxlqHRjmI8xUowv4.1S2", // bcrypt hash for 'password123'
    "fullName": "Amanda Martinez",
    "claim": userClaimDoc
  },
  {
    "email": "customer@securecinema.com",
    "password": "$2a$10$bSx3f0znM5BgvPwQT1W8UOKHRw.MwR76VtxlqHRjmI8xUowv4.1S2", // bcrypt hash for 'password123'
    "fullName": "Customer User",
    "claim": customerClaimDoc
  }
];

// Insert Users
db.user.insertMany(users);

// Print result
print("Database seeding completed!");
print("Added " + db.claim.count() + " claims");
print("Added " + db.user.count() + " users");