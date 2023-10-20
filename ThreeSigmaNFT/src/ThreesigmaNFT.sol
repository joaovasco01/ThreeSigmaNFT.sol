// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Imports
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

// Contract Declaration
contract GameItem is ERC721URIStorage {
    // State Variables
    uint256 private _tokenIds;
    mapping(uint256 => bool) public forSale;
    uint256 public number;

    // Constructor
    constructor() ERC721("GameItem", "ITM") {}

    // awardItem Function
    function awardItem(address player, string memory tokenURI) public returns (uint256) {
        // This function allows the contract owner to mint a new token and assign it to an address (player).
        // It takes a tokenURI string as an argument, which typically points to the metadata of the NFT (Non-Fungible Token).

        // Increment _tokenIds to create a new unique token ID
        _tokenIds++;
        uint256 newItemId = _tokenIds;
        
        // Mint a new token and assign it to the player
        _mint(player, newItemId);
        
        // Set the token's metadata URI
        _setTokenURI(newItemId, tokenURI);
        
        // Return the new token ID
        return newItemId;
    }

    // putForSale Function
    function putForSale(uint256 tokenId) public {
        // This function allows the owner of a token to list it for sale.
        // It takes a tokenId as an argument, and if the sender (caller) is the owner of that token,
        // it sets the forSale mapping value to true, indicating that the token is available for purchase.

        require(ownerOf(tokenId) == msg.sender, "Only the owner can sell the token");
        forSale[tokenId] = true;
    }

    // buyToken Function
    function buyToken(uint256 tokenId) public payable {
        // This function enables the purchase of a token that is listed for sale.
        // It takes a tokenId as input and requires that the token must be listed for sale (forSale[tokenId] must be true).
        // The sender must also send the exact amount (1 ether) as the price to buy the token.

        require(forSale[tokenId], "Token is not for sale");
        uint256 price = 1 ether; // 1 ethereum for NFT
        require(msg.value == price, "Incorrect Ether sent");

        // Get the address of the seller
        address payable seller = payable(ownerOf(tokenId));
        
        // Transfer ownership of the token from the seller to the buyer
        _transfer(seller, msg.sender, tokenId);
        
        // Transfer the payment (Ether) from the buyer to the seller
        seller.transfer(msg.value);
        
        // Set the forSale status of the token to false
        forSale[tokenId] = false;
    }
}
