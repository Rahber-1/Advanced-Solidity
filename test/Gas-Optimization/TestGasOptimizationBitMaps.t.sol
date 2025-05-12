// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (utils/structs/BitMaps.sol)
pragma solidity ^0.8.20;

import {Test,console} from "forge-std/Test.sol";
import {GasOptimizationBitMaps} from "../../src/Gas-Optimization/GasOptimizationBitMaps.sol";


contract TestGasOptimizationBitMaps is Test {
    GasOptimizationBitMaps gasBitMaps;

    function setUp() public{
        gasBitMaps=new GasOptimizationBitMaps();

    }

    function testGasOptimizationWithBitMaps() public{
        
    }
}