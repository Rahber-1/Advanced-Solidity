// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;



contract UnOptimizedNFT{
    //errors
    error UnOptimizedNFT__ZeroAddressNotAllowed();

    //events
    event Minted(address indexed to,uint256 tokenId);

    //state variables
    uint256 totalSupply;
    mapping(uint256 tokenId=>address owner) public ownerOf;
    
    //fn mints the NFTs
    function mint(address to) external {
        if(to ==address(0)){
            revert UnOptimizedNFT__ZeroAddressNotAllowed();
        }
        totalSupply +=1;
        uint256 tokenId=totalSupply;
        ownerOf[tokenId]=msg.sender;
        emit Minted(msg.sender,tokenId);
    }
}