// // SPDX-License-Identifier: MIT
// // OpenZeppelin Contracts (last updated v5.0.0) (utils/structs/BitMaps.sol)
// pragma solidity ^0.8.20;

// import {BitMaps} from "../../Lib/BitMaps.sol";

// contract GasOptimizationBitMaps{
//     using BitMaps for BitMaps.BitMap;

//     BitMaps.BitMap public claim;

//     mapping(address user=> bool status) public hasClaimed;

//     function claimWithBitmaps(uint256[] calldata indices) public {
//         for(uint256 i=0;i<indices.length;i++){
//             uint256 index=indices[i];
//             require(!claim.get(index),"has claimed already");
//             claim.set(index);
//         }
//     }

//     function claimWithUsualMappings(address[] calldata users) public{
//         for(uint256 i=0;i<users.length;i++){
//             address user=users[i];
//             require(!hasClaimed[user],"already has claimed");
//             hasClaimed[user]=true;
//         }
//     }



// }