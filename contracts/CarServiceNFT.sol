// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CarHistoryNFT is ERC721URIStorage, Ownable {
    struct ServiceRecord {
        uint256 timestamp;
        string description;
        string company;
        string signature;
    }

    mapping(uint256 => ServiceRecord[]) public serviceRecords;

    event ServiceAdded(uint256 indexed tokenId, uint256 timestamp, string description, string company, string signature);

    constructor(address initialOwner) ERC721("CarHistoryNFT", "CHNFT") Ownable(initialOwner) {}

    function mintCar(address to, uint256 tokenId, string memory metadataURI) public onlyOwner {
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, metadataURI);
    }

    function addServiceRecord(
        uint256 tokenId,
        string memory description,
        string memory company,
        string memory signature
    ) public {
        require(ownerOf(tokenId) == msg.sender, "Only the owner can add a service record");

        serviceRecords[tokenId].push(ServiceRecord({
            timestamp: block.timestamp,
            description: description,
            company: company,
            signature: signature
        }));

        emit ServiceAdded(tokenId, block.timestamp, description, company, signature);
    }

    function getServiceRecords(uint256 tokenId) public view returns (ServiceRecord[] memory) {
        return serviceRecords[tokenId];
    }
}


