const ethers = require("ethers");
const fs = require("fs-extra");
require("dotenv").config();

async function main() {
  //HTTP://172.17.240.1:7545

  const provider = new ethers.providers.JsonRpcProvider(process.env.RPC_URL);
  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);
  const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf-8");
  const binary = fs.readFileSync(
    "./SimpleStorage_sol_SimpleStorage.bin",
    "utf-8"
  );
  const contractFactory = new ethers.ContractFactory(abi, binary, wallet);
  console.log("Deploying contract...");

  const contract = await contractFactory.deploy(); //Stop here wait for the contract to be deployed
  await contract.deployTransaction.wait(1);
  console.log("Contract deployed to address:", contract.address);

  const currentFavNumber = await contract.Retrieve();
  console.log(`Current favorite number: ${currentFavNumber.toString()} `);
  const transactionResponse = await contract.Store("7");
  const transactionReceipt = await transactionResponse.wait(1);
  const newFavNumber = await contract.Retrieve();
  console.log(`New favorite number: ${newFavNumber}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
