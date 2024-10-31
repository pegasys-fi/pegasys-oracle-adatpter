import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-verify";

require("dotenv").config();
const {
  PRIVATE_KEY,
} = process.env;


const config: HardhatUserConfig = {
  solidity: "0.8.24",

  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      forking: {
        url: "https://rpc.rollux.com/",
      },
    },
    rollux: {
      url: "https://rpc.rollux.com/",
      accounts: [`0x${PRIVATE_KEY}`],
    },
  },
  etherscan: {
    apiKey: "abc",
    customChains: [
      {
        network: "rollux",
        chainId: 570,
        urls: {
          apiURL: "https://explorer1.rollux.com/api",
          browserURL: "https://explorer1.rollux.com"
        }
      }
    ]
  }

};

export default config;
