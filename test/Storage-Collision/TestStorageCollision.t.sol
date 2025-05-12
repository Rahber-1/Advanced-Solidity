// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
 
import {Test,console} from "forge-std/Test.sol";
import {V1Implementation} from "../../src/Storage-Collision/V1Implementation.sol";
import {V2Implementation} from "../../src/Storage-Collision/V2Implementation.sol";
import {Proxy} from "../../src/Storage-Collision/Proxy.sol";
import {DeployStorageCollision} from "../../script/Storage-Collision/DeployStorageCollision.s.sol";


contract TestStorageCollision is Test{
   
    V1Implementation v1;
    V2Implementation v2;
   
    Proxy proxy;

    address ADMIN=makeAddr("ADMIN");

    

    function setUp() public {
        vm.prank(ADMIN);
        v1=new V1Implementation();
        proxy=new Proxy(address(v1));
        address impl=proxy.getNewImplementation();
        console.log("oldImpl: ",impl);

        //lets call function setValue on v1
        (bool success,)=address(proxy).call(abi.encodeWithSignature("setValue(uint256)",555555));
        require(success,"call failed");



    }
    function testStorageCollision() public {
        v2=new V2Implementation();
        vm.prank(ADMIN);
        proxy.upgradeTo(address(v2));
        address newImpl=proxy.getNewImplementation();
        console.log("newImpl: ",newImpl);

        (bool s,)=address(proxy).call(abi.encodeWithSignature("setValue()"));
        require(s,"call has failed");
        uint256 value=proxy.getValue();
        console.log("value: ",value);

    }
}