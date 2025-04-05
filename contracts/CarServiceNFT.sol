// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CarHistoryNFT is ERC721URIStorage, Ownable {
    // Структура записи об обслуживании
    struct ServiceRecord {
        uint256 timestamp;
        string description;
        string company;
        string signature;
    }

    // Маппинг для хранения записей обслуживания для каждого токена (NFT)
    mapping(uint256 => ServiceRecord[]) public serviceRecords;

    // Событие для добавления новой записи
    event ServiceAdded(uint256 indexed tokenId, uint256 timestamp, string description, string company, string signature);

    constructor(address initialOwner) ERC721("CarHistoryNFT", "CHNFT") Ownable(initialOwner) {}

    // Выпуск нового NFT
    function mintCar(address to, uint256 tokenId, string memory metadataURI) public onlyOwner {
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, metadataURI); // URI для базовой информации (если нужна)
    }

    // Добавление записи об обслуживании
    function addServiceRecord(
        uint256 tokenId,
        string memory description,
        string memory company,
        string memory signature
    ) public {
        require(ownerOf(tokenId) == msg.sender, "Only the owner can add a service record");

        // Добавляем запись в массив
        serviceRecords[tokenId].push(ServiceRecord({
            timestamp: block.timestamp,
            description: description,
            company: company,
            signature: signature
        }));

        emit ServiceAdded(tokenId, block.timestamp, description, company, signature);
    }

    // Получение всех записей об обслуживании
    function getServiceRecords(uint256 tokenId) public view returns (ServiceRecord[] memory) {
        return serviceRecords[tokenId];
    }
}


