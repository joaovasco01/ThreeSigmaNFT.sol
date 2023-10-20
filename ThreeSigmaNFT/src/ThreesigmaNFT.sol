// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract GameItem is ERC721URIStorage {
    uint256 private _tokenIds;
    mapping(uint256 => bool) public forSale;
    uint256 public number;

    constructor() ERC721("GameItem", "ITM") {}
    

    function awardItem(address player, string memory tokenURI) public returns (uint256) {


        _tokenIds++;
        uint256 newItemId = _tokenIds;
        _mint(player, newItemId);
        _setTokenURI(newItemId, tokenURI);
        return newItemId;
    }

    function putForSale(uint256 tokenId) public {
        require(ownerOf(tokenId) == msg.sender, "Only the owner can sell the token");
        forSale[tokenId] = true;
    }

    function buyToken(uint256 tokenId) public payable {
        require(forSale[tokenId], "Token is not for sale");
        uint256 price = 1 ether; // 1 ethereum for NFT
        require(msg.value == price, "Incorrect Ether sent");

        address payable seller = payable(ownerOf(tokenId));
        _transfer(seller, msg.sender, tokenId);
        seller.transfer(msg.value);
        forSale[tokenId] = false;
    }
}
