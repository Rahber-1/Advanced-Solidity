// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test,console} from "forge-std/Test.sol";
import {GetLatestData} from "../src/GetLatestData.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {MockV3Aggregator} from "./mocks/MockV3Aggregator.sol";
import {MockV3AggregatorMultiple} from "./mocks/MockV3AggregatorMultiple.sol";


contract TestGetLatestData is Test {
    GetLatestData getLatestData;
    address OWNER=makeaddr("OWNER");

    uint256 constant DECIMALS=8;
    uint256 constant INITIAL_ANS_BTC=97000e8;
    uint256 constant INITIAL_ANS_ETH=1800e8;
    uint256 constant INITIAL_ANS_LINK=15e8;

    MockV3Aggregator btcFeed;
    MockV3Aggregator ethFeed;
    MockV3Aggregator linkFeed;
    

    function setUp() public {
        btcFeed=new MockV3Aggregator(DECIMALS,INITIAL_ANS_BTC);
        ethFeed=new MockV3Aggregator(DECIMALS,INITIAL_ANS_ETH);
        linkFeed=new MockV3Aggregator(DECIMALS,INITIAL_ANS_LINK);
        getLatestData=new GetLatestData();
    }

    function test_Can_Add_Assets() public {
        string memory symbol="BTC/USD";
        address expectedFeedAddress=btcFeed;

        address actualFeedAddress=getLatestData.getAddedAssets(symbol);

        assertEq(expectedFeedAddress,actualFeedAddress);


    }
}