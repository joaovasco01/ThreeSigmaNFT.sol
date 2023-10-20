// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../src/ThreesigmaNFT.sol"; // Adjust the path to your GameItem contract if needed
import "forge-std/Test.sol";

contract GameItemTest {
    GameItem gameItem;

    function setUp() public {
    gameItem = new GameItem();
    }

    function testMinting() public {

        uint256 tokenId = gameItem.awardItem(address(this), "https://example.com/token/1");
       // require(0 != 0, "bug");

        assert(gameItem.ownerOf(tokenId) == address(this));
    }
    
    function testTokenURI() public {
        uint256 tokenId = gameItem.awardItem(address(this), "https://example.com/token/1");
        assert(keccak256(bytes(gameItem.tokenURI(tokenId))) == keccak256(bytes("https://example.com/token/1")));
    }

    function testForSale() public {
        uint256 tokenId = gameItem.awardItem(address(this), "https://example.com/token/1");
        gameItem.putForSale(tokenId);
        assert(gameItem.forSale(tokenId) == true);
    }

    // Additional tests can be added as needed
}
