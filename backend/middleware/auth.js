const jwt = require('jsonwebtoken');

const TOKEN_KEY = "RANDOM_KEY";
const BlacklistedToken = require('../models/blacklisttoken');
function authenticateToken(req, res, next) {
    console.log("\n========== AUTH DEBUG ==========");
    console.log("Raw headers:", req.headers);

    const authHeader = req.headers['authorization'];
    console.log("➡️ Authorization header RECEIVED:", JSON.stringify(authHeader));

    console.log("🔍 RAW AUTH HEADER YOU SENT:", authHeader);

    if (!authHeader) {
        console.log("❌ No Authorization header found.");
        return res.status(401).send({ message: "Unauthorized!" });
    }

    const raw = authHeader;
    const parts = authHeader.split(" ");

    console.log("➡️ Parts:", parts);

    if (parts.length < 2) {
        console.log("❌ Invalid Authorization format.");
        return res.status(401).send({ message: "Unauthorized!" });
    }

    const scheme = parts[0];
    const token = parts[1];

    console.log("➡️ Scheme:", scheme);
    console.log("➡️ Token extracted:", JSON.stringify(token));

    if (scheme !== "Bearer") {
        console.log("❌ WRONG SCHEME. Expected 'Bearer'");
        return res.status(401).send({ message: "Unauthorized!" });
    }

    jwt.verify(token, TOKEN_KEY, (err, decoded) => {
        if (err) {
            console.log("❌ JWT ERROR:", err.message);
            return res.status(401).send({ message: "Unauthorized!" });
        }

        console.log("✅ Token decoded:", decoded);

        const userData = decoded.data || decoded;

        req.user = userData;
        req.userId = userData.userId || userData._id;

        console.log("➡️ Final userId assigned:", req.userId);
        console.log("========== AUTH END ==========\n");

        next();
    });
}

function generateAccessToken(userModel) {
    return jwt.sign(
        { data: { userId: userModel._id.toString() } },
        TOKEN_KEY,
        { expiresIn: "1h" }
    );
}


module.exports = {
    authenticateToken,
    generateAccessToken
}
