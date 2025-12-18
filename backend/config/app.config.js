const MONGO_DB_CONFIG = {
    DB: process.env.MONGO_URI || "mongodb://localhost/groceryApp",
    // "mongodb://localhost/groceryApp"
    PAGE_SIZE: 10,
};
const STRIPE_CONFIG = {
    STRIPE_KEY: process.env.STRIPE_SECRET_KEY,
    CURRENCY: "inr",
}

module.exports = {
    MONGO_DB_CONFIG,
    STRIPE_CONFIG
};