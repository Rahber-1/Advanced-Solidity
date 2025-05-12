// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract OptimizedNFT{
    //events
    event MintedBatch(address[] recipients,uint256 startingId);
    uint256 totalSupply;
    mapping(uint256 tokenId=>address owner) public ownerOf;

    function mint(address[] calldata recipients) public {
        uint256 id=totalSupply;
        uint256 len=recipients.length;
        for(uint256 i=0;i<len;){
            ownerOf[id + 1]=recipients[i];
            unchecked{
                ++i;
                ++id;
            }
        }
        totalSupply =id;
        emit MintedBatch(recipients,id-len+1);
    }
}