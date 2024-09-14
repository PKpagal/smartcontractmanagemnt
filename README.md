
# smartcontractmanagemnt
metacrafter assesment


Overview
The Assessment smart contract is a Solidity-based contract designed to manage funds, maintain a leaderboard of participants based on their winnings, and keep a history of user transactions. This contract is built using Solidity version ^0.8.9 and includes functionalities for fund deposits, withdrawals, and tracking of participants' performance.
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

//import "hardhat/console.sol";

contract Assessment {
    address payable public owner;
    uint256 public balance;

    event Deposit(uint256 amount);
    event Withdraw(uint256 amount);

    struct Player {
        address playerAddress;
        uint256 winning;
    }

    constructor(uint initBalance) payable {
        owner = payable(msg.sender);
        balance = initBalance;
    }

    function getBalance() public view returns(uint256){
        return balance;
    }

    function deposit(uint256 _amount) public payable {
        uint _previousBalance = balance;

        // make sure this is the owner
        require(msg.sender == owner, "You are not the owner of this account");

        // perform transaction
        balance += _amount;

        // assert transaction completed successfully
        assert(balance == _previousBalance + _amount);

        // emit the event
        emit Deposit(_amount);
    }

    // custom error
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function withdraw(uint256 _withdrawAmount) public {
        require(msg.sender == owner, "You are not the owner of this account");
        uint _previousBalance = balance;
        if (balance < _withdrawAmount) {
            revert InsufficientBalance({
                balance: balance,
                withdrawAmount: _withdrawAmount
            });
        }

        // withdraw the given amount
        balance -= _withdrawAmount;

        // assert the balance is correct
        assert(balance == (_previousBalance - _withdrawAmount));

        // emit the event
        emit Withdraw(_withdrawAmount);
    }

    // Leaderboard
    mapping (address => uint) moneyWon;
    Player[] public leaderboard;

    function addToLeaderBoard(address _address, uint amountWon) public {
        moneyWon[_address]+=amountWon;

        bool alreadyExist = false;
        for(uint i=0;i<leaderboard.length;i++){
            if(leaderboard[i].playerAddress==_address){
                leaderboard[i].winning = moneyWon[_address];
                alreadyExist = true;
                break;
            }
        }

        if(!alreadyExist) {
            leaderboard.push(Player(_address,moneyWon[_address]));
        }
    }
    function getLeaderboard() public view returns (Player[] memory) {
        return leaderboard;
    }

    // History
    struct Transaction {
        address user;
        string resultType;
        uint256 timestamp;
    }
    mapping(address => Transaction[]) public history;

     function addToHistory(address _user, string memory _type) public {
        history[_user].push(Transaction({
            user: _user,
            resultType:_type,
            timestamp: block.timestamp
        }));
        
    }

    function getHistory(address _user) public view returns (Transaction[] memory) {
        return history[_user];
    }
}
Features
Contract Owner: The contract is owned by a single address, which has exclusive rights to deposit and withdraw funds.
Fund Management:
Deposit Funds: Only the contract owner can deposit funds into the contract.
Withdraw Funds: Only the contract owner can withdraw funds from the contract.
Leaderboard:
Tracks participants' winnings.
Allows adding participants and updating their winnings.
Retrieves the leaderboard.
Transaction History:
Records user transactions with outcomes and timestamps.
Retrieves a user's transaction history.
Contract Details
State Variables
address payable public contractOwner: The address of the contract owner.
uint256 public contractBalance: The balance of the contract.
mapping(address => uint256) public winningsRecord: Tracks each participant's winnings.
Participant[] public leaderboard: List of participants and their total winnings.
mapping(address => UserTransaction[]) public transactionHistory: Stores transaction history for each user.
Structs
Participant: Contains an address and total winnings.
UserTransaction: Contains user address, transaction outcome, and timestamp.
Events
FundsDeposited(uint256 amount): Emitted when funds are deposited.
FundsWithdrawn(uint256 amount): Emitted when funds are withdrawn.
Functions
constructor(uint initialBalance): Initializes the contract with an initial balance and sets the owner.
getContractBalance(): Returns the current balance of the contract.
depositFunds(uint256 _amount): Allows the owner to deposit funds.
withdrawFunds(uint256 _withdrawAmount): Allows the owner to withdraw funds.
addToLeaderboard(address _address, uint256 amountWon): Adds or updates a participant in the leaderboard.
getLeaderboard(): Retrieves the current leaderboard.
addToTransactionHistory(address _user, string memory _outcome): Adds a transaction record for a user.
getTransactionHistory(address _user): Retrieves the transaction history for a user.
Error Handling
InsufficientFunds: Custom error for insufficient funds during withdrawal.
Usage
Deployment: Deploy the contract with an initial balance using the constructor.
Deposit Funds: The contract owner can deposit funds using the depositFunds function.
Withdraw Funds: The contract owner can withdraw funds using the withdrawFunds function.
Manage Leaderboard: Add participants and update their winnings using addToLeaderboard. Retrieve the leaderboard with getLeaderboard.
Track Transactions: Record transactions with addToTransactionHistory and view them with getTransactionHistory.
Contributing
Contributions are welcome! Please feel free to fork the repository and submit a pull request with improvements or bug fixes.

License
This project is licensed under the UNLICENSED License.

Contact
For any questions or further information, please contact [Name:Prince Kumar
Email:kumarprincerajput124@gmail.com.]
