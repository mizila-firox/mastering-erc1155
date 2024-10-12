// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import {ERC1155} from "lib/openzeppelin-contracts/contracts/token/ERC1155/ERC1155.sol";
import {ERC1155URIStorage} from "lib/openzeppelin-contracts/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";
import {Strings} from "lib/openzeppelin-contracts/contracts/utils/Strings.sol";
import {OwnerIsCreator} from "lib/chainlink-local/lib/ccip/contracts/src/v0.8/shared/access/OwnerIsCreator.sol";

contract NFT is ERC1155, ERC1155URIStorage, OwnerIsCreator {
    uint256 currentId = 1;
    uint8 public constant MAX_SUPPLY = 8;

    constructor()
        ERC1155(
            "https://scarlet-scared-wildcat-411.mypinata.cloud/ipfs/QmXPdhZunk5psvpvWCHpg99G8TRSyPpzn46p5DjJbzrS4h/"
        )
    {}

    function mint(
        uint256 _id,
        uint256 _amount
    ) external onlyOwner returns (uint256, uint256) {
        require(_id > 0 && _id <= MAX_SUPPLY, "invalid id");
        _mint(msg.sender, 1, 10, "");

        return (_id, _amount);
    }

    function burn(uint256 _id, uint256 _amount) external onlyOwner {
        require(_id > 0 && _id <= MAX_SUPPLY, "invalid id");
        _burn(msg.sender, _id, _amount);
    }

    function uri(
        uint256 tokenId
    ) public view override(ERC1155, ERC1155URIStorage) returns (string memory) {
        require(tokenId > 0 && tokenId <= MAX_SUPPLY, "invalid id");

        return
            string(
                abi.encodePacked(
                    super.uri(tokenId),
                    Strings.toString(tokenId),
                    ".jpg"
                )
            );
    }
}
