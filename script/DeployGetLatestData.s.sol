// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {GetLatestData} from "../src/GetLatestData.sol";

contract Deploy is Script {
    function run() external {
        vm.startBroadcast();
        new GetLatestData();
        vm.stopBroadcast();
    }
}
