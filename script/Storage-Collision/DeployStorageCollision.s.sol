// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {V1Implementation} from "../../src/Storage-Collision/V1Implementation.sol";
import {Proxy} from "../../src/Storage-Collision/Proxy.sol";

contract DeployStorageCollision is Script {
    V1Implementation V1;
    Proxy proxy;

    function run() public returns (address, address) {
        vm.startBroadcast();
        V1 = new V1Implementation();
        proxy = new Proxy(address(V1));
        vm.stopBroadcast();
        return (address(V1), address(proxy));
    }
}
