const hre = require("hardhat");

async function main() {

  const ZombieFactory = await hre.ethers.getContractFactory("ZombieFactory");
  const zombieFactory = await ZombieFactory.deploy();

  await zombieFactory.deployed();

  console.log("ZombieFactory deployed to:", zombieFactory.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
