const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Temple721", function () {
  it("Should return the new greeting once it's changed", async function () {
    const Temple721 = await ethers.getContractFactory("Temple721");
    const temple721 = await Temple721.deploy(
      "Temple(Anton Belinsky)",
      "Temple721"
    );
    await temple721.deployed();

    expect(
      await temple721.balanceOf("0x5FbDB2315678afecb367f032d93F642f64180aa3")
    ).to.equal(0);

    expect(
      await temple721.display("0x5FbDB2315678afecb367f032d93F642f64180aa3")
    ).to.equal("0x5FbDB2315678afecb367f032d93F642f64180aa3");
    // const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // // wait until the transaction is mined
    // await setGreetingTx.wait();

    // expect(await temple721.greet()).to.equal("Hola, mundo!");
  });
});
