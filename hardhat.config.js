require("@nomicfoundation/hardhat-toolbox");

const ETHER_SCAN_API = "KRGTDX1UW9ZSMSX3D1P7J7ES71IQAG8NBG";

const INFURA_API_KEY = "b6dec85a9d8d4c0f9e1372f623b025bd";

// Replace this private key with your Sepolia account private key
// To export your private key from Coinbase Wallet, go to
// Settings > Developer Settings > Show private key
// To export your private key from Metamask, open Metamask and
// go to Account Details > Export Private Key
// Beware: NEVER put real Ether into testing accounts
const SEPOLIA_PRIVATE_KEY = "58f3f23ef2ccfbbd4b68e3e0efbe33cb60cd66103a081d1edc17777c63b8584d";

module.exports = {
  solidity: "0.8.19",
  settings: {
    optimizer: {
      enabled: true,
      runs: 1000,
    },
  },
  etherscan: {
    apiKey: `${ETHER_SCAN_API}`,
  },
  networks: {
    sepolia: {
      url: `https://sepolia.infura.io/v3/${INFURA_API_KEY}`,
      accounts: [SEPOLIA_PRIVATE_KEY],
    },
    goerli: {
      url: `https://goerli.infura.io/v3/${INFURA_API_KEY}`,
      accounts: [SEPOLIA_PRIVATE_KEY],
    },
  },
};