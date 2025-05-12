// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {CommitReveal} from "../../src/Front-Running/CommitReveal.sol";

contract DeployCommitReveal is Script {
    CommitReveal commitReveal;
    uint256 commitPeriod = 1 days;
    uint256 revealPeriod = 1 days;

    function run() public returns (address) {
        vm.startBroadcast();
        commitReveal = new CommitReveal(commitPeriod, revealPeriod);
        vm.stopBroadcast();
        return address(commitReveal);
    }
}
