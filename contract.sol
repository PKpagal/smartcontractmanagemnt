// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Assessment {
    address payable public contractOwner;
    uint256 public contractBalance;

    event FundsDeposited(uint256 amount);
    event FundsWithdrawn(uint256 amount);

    struct Participant {
        address participantAddress;
        uint256 totalWinnings;
    }

    constructor(uint initialBalance) payable {
        contractOwner = payable(msg.sender);
        contractBalance = initialBalance;
    }

    function getContractBalance() public view returns(uint256) {
        return contractBalance;
    }

    function depositFunds(uint256 _amount) public payable {
        uint256 previousBalance = contractBalance;

        // Ensure that only the owner can deposit funds
        require(msg.sender == contractOwner, "You are not the owner of this account");

        // Perform the deposit transaction
        contractBalance += _amount;

        // Ensure the transaction was successful
        assert(contractBalance == previousBalance + _amount);

        // Emit an event after deposit
        emit FundsDeposited(_amount);
    }

    // Custom error for insufficient balance
    error InsufficientFunds(uint256 balance, uint256 withdrawalAmount);

    function withdrawFunds(uint256 _withdrawAmount) public {
        require(msg.sender == contractOwner, "You are not the owner of this account");

        uint256 previousBalance = contractBalance;
        if (contractBalance < _withdrawAmount) {
            revert InsufficientFunds({
                balance: contractBalance,
                withdrawalAmount: _withdrawAmount
            });
        }

        // Perform the withdrawal transaction
        contractBalance -= _withdrawAmount;

        // Ensure the balance is correct after withdrawal
        assert(contractBalance == (previousBalance - _withdrawAmount));

        // Emit an event after withdrawal
        emit FundsWithdrawn(_withdrawAmount);
    }

    // Leaderboard
    mapping (address => uint256) public winningsRecord;
    Participant[] public leaderboard;

    function addToLeaderboard(address _address, uint256 amountWon) public {
        winningsRecord[_address] += amountWon;

        bool alreadyExists = false;
        for (uint256 i = 0; i < leaderboard.length; i++) {
            if (leaderboard[i].participantAddress == _address) {
                leaderboard[i].totalWinnings = winningsRecord[_address];
                alreadyExists = true;
                break;
            }
        }

        if (!alreadyExists) {
            leaderboard.push(Participant(_address, winningsRecord[_address]));
        }
    }

    function getLeaderboard() public view returns (Participant[] memory) {
        return leaderboard;
    }

    // History
    struct UserTransaction {
        address user;
        string outcome;
        uint256 timestamp;
    }

    mapping(address => UserTransaction[]) public transactionHistory;

    function addToTransactionHistory(address _user, string memory _outcome) public {
        transactionHistory[_user].push(UserTransaction({
            user: _user,
            outcome: _outcome,
            timestamp: block.timestamp
        }));
    }

    function getTransactionHistory(address _user) public view returns (UserTransaction[] memory) {
        return transactionHistory[_user];
    }
}
