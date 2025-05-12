// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.13;

// import {Test, console} from "forge-std/Test.sol";
// import {DeployCommitReveal} from "../../script/Front-Running/DeployCommitReveal.s.sol";
// import {CommitReveal} from "../../src/Front-Running/CommitReveal.sol";

// contract testCommitReveal is Test {
//     DeployCommitReveal deployCommitReveal;
//     CommitReveal commitReveal;
//     address constant USER = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
//     uint256 amount = 1 ether;
//     bytes salt = "hello";

//     function setUp() public {
//         deployCommitReveal = new DeployCommitReveal();

//         address deployedAddr = deployCommitReveal.run();
//         commitReveal = CommitReveal(deployedAddr);
//     }

//     function testUserCanCommitBid() public {
//         bytes32 commitHash = 0xad51852edcfd8d52a745fa7d9d536b86466713da5b5154be4b6f863bd45b7834;
//         vm.warp(block.timestamp + 1 days);
//         vm.prank(USER);
//         commitReveal.commitBid(commitHash, amount);
//         (bytes32 _commitHash, uint256 _amount, bool _status) = commitReveal.bids(USER);

//         console.log("commit Hash:");
//         console.logBytes32(_commitHash);

//         console.log("bid amount:");
//         console.logUint(_amount);
//     }

//     function testUserCanRevealHash() public {
//         bytes32 commitHash = keccak256(abi.encodePacked(USER, amount, salt));
//         vm.warp(block.timestamp + 1 days);
//         vm.prank(USER);
//         commitReveal.commitBid(commitHash, amount);
//         (bytes32 expectedHash, uint256 _amountBefore, bool _statusBefore) = commitReveal.bids(USER);
//         console.log("expectedHash: ");
//         console.logBytes32(expectedHash);

//         vm.warp(block.timestamp + 1 days);
//         vm.prank(USER);
//         commitReveal.revealCommitHash(amount, "hello");
//         (bytes32 actualHash, uint256 _amountAfter, bool _statusAfter) = commitReveal.bids(USER);
//         console.log("actualHash: ");
//         console.logBytes32(actualHash);
//         assertEq(expectedHash, actualHash);
//     }
// }
