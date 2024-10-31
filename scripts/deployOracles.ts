import { ethers, run } from "hardhat";

async function main() {

    const supraFeed = "0xbc0453F6FAC74FB46223EA5CC55Bd82852f0C670";
    const indexes = [
        89, //USDC_USD
        48, //USDT_USD
        18, //BTC_USD
        19, //ETH_USD
        94, //SYS_USDT
    ];
    const names = [
        "USDC_USD",
        "USDT_USD",
        "BTC_USD",
        "ETH_USD",
        "SYS_USDT"
    ]
    let oracles = [];


    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);
    const POAFactory = await ethers.getContractFactory("PegasysOracleAdapter");


    for (let i = 0; i < indexes.length; i++) {

        const POAContract = await POAFactory.deploy(
            supraFeed,
            indexes[i],
        );
        await POAContract.waitForDeployment()
        console.log(names[i], indexes[i], await POAContract.getAddress());
        oracles.push(POAContract);

    }

    for (let i = 0; i < oracles.length; i++) {
        await run("verify:verify", {
            address: await oracles[i].getAddress(),
            constructorArguments: [
                supraFeed,
                indexes[i],
            ],
        });
    }

}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
