require("@nomiclabs/hardhat-ethers");
require('dotenv').config()

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.27",
  networks: {
    polygon: {
      url: [`0x${process.env.URL}`],
      accounts: [`0x${process.env.PRIVATE_KEY}`]
    }
  }
};
