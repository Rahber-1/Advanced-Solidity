// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

/**
 * title:Commit-Reveal
 * author:Rahbar Ahmed
 * This contract basically is the solution to the problem of front-running
 * specially in 1) DEX 2)Auctions 3) NFT minting 4)Flash loan Arbitrage
 * WHAT IS FRONT-RUNNING ? ANS:As we know all transactions go through mempool where they are then included in the block
 * this is where they are prone to front-running attack in which malicious actor could send thier txn and get it mined before a user's txn
 * this is called front-running,As a result a user gets bad deal.
 * In COMMIT-REVEAL method users sends hash of the bid + salt
 * Commit phase: User submits a hash of their bid or action.
 * Reveal phase: After a timeout, user reveals the original value + secret.
 * Contract validates hash and executes logic.
 * COMMIT-HASH MUST BE CALCULATED OFF-CHAIN here COMMIT-HASH=keccak256(msg.sender+amount+salt)
 */
contract CommitReveal {
    //errors
    error CommitReveal__CommitPhaseIsOver();
    error CommitReveal__UserISNotBidder();
    error CommitReveal__UserHasAlreadyCommitted();
    error CommitReveal__EitherBidHasBeenRevealedOrCommitHashMismatch();
    //struct to record the commit hash,amount and whether bid has been revealed

    struct Bid {
        bytes32 commitHash;
        uint256 amount;
        bool revealed;
    }

    uint256 public commitDeadline;
    uint256 public revealDeadline;
    mapping(address bidder => Bid bid) public bids;
    uint256 private highestBid;
    address private highestBidder;
    address public owner;

    constructor(uint256 _commitPeriod, uint256 _revealPeriod) {
        commitDeadline = block.timestamp + _commitPeriod;
        revealDeadline = commitDeadline + _revealPeriod;
        owner = msg.sender;
    }

    //Modifier
    modifier onlyOwner() {
        owner = msg.sender;
        _;
    }

    //this fn accepts the commit hash the bidders send thier bids
    function commitBid(bytes32 _commitHash, uint256 _amount) external payable {
        if (block.timestamp > commitDeadline) {
            revert CommitReveal__CommitPhaseIsOver();
        }
        if (bids[msg.sender].commitHash != bytes32(0)) {
            revert CommitReveal__UserHasAlreadyCommitted();
        }
        bids[msg.sender] = Bid({commitHash: _commitHash, amount: _amount, revealed: false});
    }

    //this fn reveals the commit hash
    function revealCommitHash(uint256 _amount, bytes memory _salt) external {
        if (bids[msg.sender].commitHash == bytes32(0)) {
            revert CommitReveal__UserISNotBidder();
        }
        Bid storage bid = bids[msg.sender];
        if (keccak256(abi.encodePacked(msg.sender, _amount, _salt)) != bid.commitHash || bid.revealed == true) {
            revert CommitReveal__EitherBidHasBeenRevealedOrCommitHashMismatch();
        }
        bid.revealed = true;

        if (_amount > highestBid) {
            highestBid = _amount;
            highestBidder = msg.sender;
        }
    }

    //fetches winner
    function getWinner() external onlyOwner returns (address, uint256) {
        require(block.timestamp > revealDeadline, "reveal deadline has not passed");
        return (highestBidder, highestBid);
    }
}
