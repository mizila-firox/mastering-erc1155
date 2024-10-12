// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {NFT} from "../src/NFT.sol";
import {IERC1155Receiver} from "lib/openzeppelin-contracts/contracts/interfaces/IERC1155Receiver.sol";
import {ERC1155URIStorage} from "lib/openzeppelin-contracts/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";

contract NFTTest is Test, IERC1155Receiver {
    NFT nft;

    function setUp() external {
        nft = new NFT();
    }

    function testMint() external {
        (uint256 id, uint256 amount) = nft.mint(8, 10); // 8 -> golden Donkey Kong
        console.log(id);
        console.log(amount);

        console.log(nft.uri(8));
    }

    function testMintAndBurn() external {
        nft.mint(1, 10);
        nft.burn(1, 9);

        console.log(nft.balanceOf(address(this), 1));
    }

    function onERC1155Received(
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
    ) external returns (bytes4) {
        console.log("onERC1155Received");
        return this.onERC1155Received.selector;
    }

    function onERC1155BatchReceived(
        address operator,
        address from,
        uint256[] calldata ids,
        uint256[] calldata values,
        bytes calldata data
    ) external returns (bytes4) {
        console.log("onERC1155BatchReceived");
        return this.onERC1155BatchReceived.selector;
    }

    function supportsInterface(
        bytes4 interfaceId
    ) external view returns (bool) {
        return interfaceId == this.supportsInterface.selector;
    }
}
