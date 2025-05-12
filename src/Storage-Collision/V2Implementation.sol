// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract V2Implementation {
    //as per proxy storage layout we have uint256(value) at slot0
    //and address(of implementation) at slot1 and address(of admin) at slot2
    //but in our V2Implementation we are going to corrupt this
    //thus exp storage-collision
    //so at slot0 we gonna put address and see what happens
    uint256 newValue;
    address admin;
    uint256 value;

    function setAdmin() public {
        admin=msg.sender;
    }

    function setValue() public {
        newValue=1234;
    }
    
}