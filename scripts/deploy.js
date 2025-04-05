const hre = require("hardhat");

async function main() {
    const [deployer] = await hre.ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    // Получаем баланс
    const balance = await deployer.getBalance();
    console.log("Balance of deployer:", hre.ethers.utils.formatEther(balance));

    if (balance.lt(hre.ethers.utils.parseEther("0.1"))) {  // Пример проверки: достаточно ли средств
        console.log("Not enough funds for deployment");
        return;
    }

    // Получаем фабрику контракта
    const CarHistoryNFT = await hre.ethers.getContractFactory("CarHistoryNFT");

    // Развертывание контракта с передачей адреса владельца и настройками газа
    const carHistoryNFT = await CarHistoryNFT.deploy(deployer.address, {
        maxFeePerGas: hre.ethers.utils.parseUnits('25', 'gwei'),  // Используем данные из сети (например, 25 gwei)
        maxPriorityFeePerGas: hre.ethers.utils.parseUnits('25', 'gwei')  // Тоже используем из сети
    });

    await carHistoryNFT.deployed();
    console.log("CarServiceNFT deployed to:", carHistoryNFT.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
