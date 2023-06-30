const {ethers } = require("hardhat");
const nUSDContract = require('E:\stablecoin nUSD\contract.sol');
const { verify } = require("E:\stablecoin nUSD\utils\verify.js");

const provider = new ethers.providers.JsonRpcProvider('69c5e46f962741b552efe497d704f60232c849c2e2e12c7e6c65d15c132f0c2e');


const deployerPrivateKey = '69c5e46f962741b552efe497d704f60232c849c2e2e12c7e6c65d15c132f0c2e';
const deployerWallet = new ethers.Wallet(deployerPrivateKey, provider);

// Set up the contract deploy function
async function deployContract() {
  const contractFactory = new ethers.ContractFactory(
    nUSDContract.abi,
    nUSDContract.bytecode,
    deployerWallet
  );

  // Deploy the contract
  const deployedContract = await contractFactory.deploy();

  // Wait for the contract to be mined
  await deployedContract.deployed();

  console.log('nUSD contract deployed at address:', deployedContract.address);
}

deployContract().catch((error) => {
  console.error('Error deploying nUSD contract:', error);
});
