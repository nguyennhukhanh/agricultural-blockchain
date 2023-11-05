import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox-viem";

const config: HardhatUserConfig = {
  solidity: "0.8.19",
};

export default config;

// import { HardhatUserConfig } from "hardhat/config";
// import "@nomicfoundation/hardhat-toolbox-viem";
// import dotenv from "dotenv";

// dotenv.config();

// const GOERLI_RPC_URL = process.env.GOERLI_RPC_URL as string;
// const PRIVATE_KEY = process.env.PRIVATE_KEY as string;

// const config: HardhatUserConfig = {
//   solidity: "0.8.19",
//   networks: {
//     goerli: {
//       url: GOERLI_RPC_URL,
//       accounts: [PRIVATE_KEY],
//     },
//   },
// };

// export default config;
