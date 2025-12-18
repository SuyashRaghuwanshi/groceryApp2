const BlacklistedToken = require('../models/blacklisttoken');

function logout(req, res) {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (!token) {
    return res.status(400).json({ message: 'Token missing' });
  }

  const blacklisted = new BlacklistedToken({ token });

  blacklisted.save((err) => {
    if (err) {
      console.error("❌ Error blacklisting token:", err);
      return res.status(500).json({ message: "Something went wrong" });
    }

    console.log("✅ Token blacklisted successfully");
    return res.status(200).json({ message: "Logged out successfully" });
  });
}

module.exports = { logout };
