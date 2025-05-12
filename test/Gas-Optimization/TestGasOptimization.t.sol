// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test,console} from "forge-std/Test.sol";
import {OptimizedNFT} from "../../src/Gas-Optimization/OptimizedNFT.sol";
import {UnOptimizedNFT} from "../../src/Gas-Optimization/UnOptimizedNFT.sol";

contract TestGasOptimization is Test {
    OptimizedNFT oNfts;
    UnOptimizedNFT unNfts;
     uint256 optimizedGas;
     uint256 unOptimizedGas;

    address USER1=makeAddr("USER1");
    address USER2=makeAddr("USER2");
    address USER3=makeAddr("USER3");
    address USER4=makeAddr("USER4");
    address USER5=makeAddr("USER5");
     address USER6=makeAddr("USER6");
    address USER7=makeAddr("USER7");
    address USER8=makeAddr("USER8");
    address USER9=makeAddr("USER9");
    address USER10=makeAddr("USER10");

    function setUp() public {
        oNfts=new OptimizedNFT();
        unNfts=new UnOptimizedNFT();
    }

    function testUnOptimizedNftsGasCost() public {
        uint256 startingGas=gasleft();
        vm.prank(USER1);
        unNfts.mint(USER1);

        vm.prank(USER2);
        unNfts.mint(USER2);

        vm.prank(USER3);
        unNfts.mint(USER3);

        vm.prank(USER4);
        unNfts.mint(USER4);

        vm.prank(USER5);
        unNfts.mint(USER5);

         vm.prank(USER6);
        unNfts.mint(USER6);

        vm.prank(USER7);
        unNfts.mint(USER7);

        vm.prank(USER8);
        unNfts.mint(USER8);

        vm.prank(USER9);
        unNfts.mint(USER9);

        vm.prank(USER10);
        unNfts.mint(USER10);

        uint256 endingGas=gasleft();
        uint256 spentGas=startingGas-endingGas;
        unOptimizedGas=spentGas;

        // console.log("gas spent for minting 5 nfts: ",spentGas);


    }
    function testoptimizedNftsGasCost() public {
        address[] memory recipients=new address[](10);
        recipients[0]=USER1;
        recipients[1]=USER2;
        recipients[2]=USER3;
        recipients[3]=USER4;
        recipients[4]=USER5;
        recipients[5]=USER6;
        recipients[6]=USER7;
        recipients[7]=USER8;
        recipients[8]=USER9;
        recipients[9]=USER10;
        uint256 startingGas=gasleft();
        oNfts.mint(recipients);
        uint256 endingGas=gasleft();
        uint256 spentGas=startingGas-endingGas;
        optimizedGas=spentGas;
        // console.log("gas for OptimizedNFT: ",spentGas);


    }
    function testWhereGasCostMore() public {
        testUnOptimizedNftsGasCost();
        console.log("UnOptimizedNFT gas: ",unOptimizedGas);
        testoptimizedNftsGasCost();
        console.log("OptimizedNFT gas: ",optimizedGas);
        console.log(unOptimizedGas-optimizedGas);
        assertLt(optimizedGas,unOptimizedGas);

    }
}