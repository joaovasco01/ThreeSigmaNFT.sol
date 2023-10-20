# ThreeSigmaNFT.sol
# Adversities Faced During Smart Contract Development

## Introduction
During the development of our smart contract project, we encountered various challenges and changes that are worth noting. This document aims to provide insights into the adversities faced and the solutions employed during the project.

## Changes in Remappings
One of the initial challenges we encountered was related to remappings in the project. In previous versions of Foundry, remappings were typically configured in the foundry.toml file (such as we learnt on C2 in the [video] (https://www.youtube.com/watch?v=fNMfMxGxeag&feature=youtu.be) as you can remember. However, we found that this process has changed. To adapt to the new approach:

1. Create or update a file named `remappings.txt` in your project root.
2. Add the following line to `remappings.txt`:

@openzeppelin/contracts/=lib/openzeppelin-contracts/contracts/


## Deprecated Imports
Another challenge was the deprecation of certain imports from the OpenZeppelin library. In particular, the import of `Counters.sol` had been deprecated [(Deprecation Motivation)](https://github.com/OpenZeppelin/openzeppelin-contracts/issues/4233). While a draft version was available, we chose not to use it to maintain the reliability of our code.

You can find the draft version here for reference: [Draft Counter.sol](https://github.com/utgarda/openzeppelin-solidity/blob/master/contracts/drafts/Counter.sol).

## Handling Token URIs
In the course of our development, we discovered that the `_setTokenURI` function, which used to be part of the standard ERC721 import, had been separated. To include this essential functionality for associating metadata with tokens, we needed to import `ERC721URIStorage` instead.

It's important to note that `ERC721URIStorage.sol` is an extension of `ERC721`, which means you don't need both imports to create a ThreeSigmaNFT.

## Questions for Students

**Q1:** Do we need to keep both imports `ERC721URIStorage.sol` and `ERC721` to create the ThreeSigmaNFT?
**A1:** No, it's not necessary to keep both imports. `ERC721URIStorage.sol` is an extension of `ERC721` and includes the required functionality.

**Q2:** What are the potential problems associated with using `ERC721URIStorage.sol`?
**A2:** `ERC721URIStorage.sol` contains additional functions for handling token URIs, which can result in higher gas costs during deployment and interaction with contracts. Understanding these trade-offs is crucial for efficient smart contract development.

## Conclusion
In summary, our smart contract development journey involved adapting to changes in remappings, addressing deprecated imports, and understanding the separation of token URI functionality in newer versions of the ERC721 standard. These challenges, while initially daunting, provided valuable learning experiences and insights into the evolving landscape of smart contract development.

