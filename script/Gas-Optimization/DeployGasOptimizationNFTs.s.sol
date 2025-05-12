// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {OptimizedNFT} from "../../src/Gas-Optimization/OptimizedNFT.sol";
import {UnOptimizedNFT} from "../../src/Gas-Optimization/UnOptimizedNFT.sol";


contract DeployGasOptimizationNFTs is Script{
    OptimizedNFT oNfts;
    UnOptimizedNFT unNfts;

    function run() public returns(address,address){
        vm.startBroadcast();
        oNfts=new OptimizedNFT();
        unNfts=new UnOptimizedNFT();
        vm.stopBroadcast();
    }
}