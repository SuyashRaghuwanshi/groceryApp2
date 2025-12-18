const blacklistedTokens = [];

function addToBlacklist(token) {
  blacklistedTokens.push(token);
}

function isBlacklisted(token) {
  return blacklistedTokens.includes(token);
}

module.exports = {
  addToBlacklist,
  isBlacklisted,
};
