const { ethers, run, network } = require("hardhat");

async function main() {
  // We get the contract to deploy
  const SimpleStorage = await ethers.getContractFactory("SimpleStorage");
  console.log("Deploying Contract...");

  const simpleStorage = await SimpleStorage.deploy();
  await simpleStorage.deployed();
  console.log("Contract deployed to:", simpleStorage.address);
  //console.log("Network Configuration: ", network.config);

  // == is check equality
  // === is check equality and type in JS
  if (network.config.chainID === 5) {
    // Is contract deployed to Goerli?
    console.log("Waiting for 2 confirmation...");
    await simpleStorage.deployTransaction.wait(2); // Wait for 2 confirmation
    await verify(simpleStorage.address, []); // Verify contract on Etherscan
  } else console.log("Contract will not be verified");

  // Retrive Current Value of Favorite Number
  const currentValue = await simpleStorage.Retrieve();
  console.log(`Favorite Number: ${currentValue}`);

  // Store New Value of Favorite Number and Retrieve New Value
  const transactionResponse = await simpleStorage.Store(7);
  await transactionResponse.wait(1);
  const newValue = await simpleStorage.Retrieve();
  console.log(`New Favorite Number: ${newValue}`);
}

async function verify(contractAddress, args) {
  console.log("Verifying contract at address: ", contractAddress);
  try {
    await run("verify:verify", {
      address: contractAddress,
      constructorArguments: args,
    });
  } catch (error) {
    if (error.message.includes("Contract source code already verified")) {
      console.log("Contract source code already verified");
    } else {
      console.log("Error verifying contract: ", error);
    }
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
