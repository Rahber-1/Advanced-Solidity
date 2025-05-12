// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract V1Implementation {
    uint256 value; //should be at slot0

    function setValue(uint256 _value) public {
        value = _value;
    }
}
