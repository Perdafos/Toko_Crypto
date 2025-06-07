import hre from "hardhat";

async function main() {
  const MyContractsFactory = await hre.ethers.getContractFactory("MyContracts");
  const mycontracts = await MyContractsFactory.deploy();
  await mycontracts.waitForDeployment();
  console.log("Deployed to:", mycontracts.target);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
