// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Proxy {
    //errors
    error Proxy__AddressZeroNotAllowed();

    //state variables
    // bool myName;
    uint256 value;//at storage slot0
    address implementation; //at storage slot1
    address admin; //at storage slot2
    // uint256 value;

    constructor(address _implementation) {
        implementation = _implementation;
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        admin = msg.sender;
        _;
    }

    function upgradeTo(address newImplementation) external onlyAdmin {
        if (newImplementation == address(0)) {
            revert Proxy__AddressZeroNotAllowed();
        }
        implementation = newImplementation;
    }

    fallback() external payable {
        address impl = implementation;
        if (impl == address(0)) {
            revert Proxy__AddressZeroNotAllowed();
        }
        assembly {
            calldatacopy(0, 0, calldatasize())

            let result := delegatecall(gas(), impl, 0, calldatasize(), 0, 0)

            returndatacopy(0, 0, returndatasize())

            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }

    function getNewImplementation() public view returns(address){
        return implementation;
    }
    function getValue() public view returns(uint256){
        return value;
    }
}
