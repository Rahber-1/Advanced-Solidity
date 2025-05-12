
//How would you fetch off-chain data (e.g., ETH/USD price) in a secure and decentralized way using Chainlink,
// and how would you validate its freshness and correctness?

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract GetLatestData {
    //errors
    error GetLatestData__AlreadySet();
    error GetLatestData__ZeroAddressNotAllowed();

    AggregatorV3Interface public priceFeed;
    address owner;

    mapping(string => address) internal assets;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        owner = msg.sender;
        _;
    }

    function addAsset(string memory _asset, address _address) external onlyOwner {
        if (assets[_asset] != address(0)) {
            revert GetLatestData__AlreadySet();
        }
        if (_address == address(0)) {
            revert GetLatestData__ZeroAddressNotAllowed();
        }
        assets[_asset] = _address;
    }

    function getLatestPrice(string memory _asset) public returns (int256) {
        address assetToFetchPrice = assets[_asset];
        priceFeed = AggregatorV3Interface(assetToFetchPrice);
        (, int256 price,,,) = priceFeed.latestRoundData();
        return price;
    }

    function getLatesPriceAndTimeStamp(string memory _asset) public returns (int256, uint256) {
        address assetToFetchPrice = assets[_asset];
        priceFeed = AggregatorV3Interface(assetToFetchPrice);
        (, int256 price,, uint256 updatedAt,) = priceFeed.latestRoundData();
        return (price, updatedAt);
    }

    function getDataFreshness(string memory _asset) public returns (string memory) {
        (int256 latestPrice, uint256 updatedAt) = getLatesPriceAndTimeStamp(_asset);
        if (block.timestamp - updatedAt < 3600) {
            return "data was updated at less than one hour";
        }
        return "data is more than one hour old";
    }

    function getAddedAssets(string memory _assetName) public view returns(address){
        return assets[_assetName];
    }
}
