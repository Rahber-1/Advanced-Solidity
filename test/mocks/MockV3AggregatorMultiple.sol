// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract MockV3AggregatorMultiple {
    mapping(string => AggregatorV3Interface) public priceFeeds;

    function setPriceFeed(string calldata symbol, address feed) external {
        priceFeeds[symbol] = AggregatorV3Interface(feed);
    }

    function getLatestPrice(string calldata symbol) external view returns (int256) {
        (
            , int256 price, , , 
        ) = priceFeeds[symbol].latestRoundData();
        return price;
    }
}
