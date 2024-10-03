Form Smart Contract
This project includes a simple Ethereum smart contract that stores and retrieves personal details such as name, age, and post for different users. It also has a frontend to interact with the contract.

Overview
The contract allows users to:

Set their personal details (name, age, post).
Retrieve their personal details.
The contract owner can view any user's details by their address.
Smart Contract Details
Language: Solidity
Version: 0.8.24
License: MIT
Functions
setDetails(string memory _name, uint _age, string memory _post): Allows users to set their personal details.
getDetails(): Allows users to view their own personal details.
personDetails(address _address): Allows the contract owner to view any user's personal details.
Modifiers
onlyowner: Ensures that only the contract owner can call certain functions.
Frontend
I have also developed a frontend that interacts with this smart contract, allowing users to easily input and retrieve their data.

Setup
Prerequisites
Solidity installed or access to Remix IDE
A local Ethereum network or a test network like Ropsten or Rinkeby
A web3-enabled browser or MetaMask extension
Steps to Deploy
Open the contract in Remix IDE.
Compile the contract using Solidity version 0.8.24.
Deploy the contract to a local Ethereum network or any test network.
Use the frontend to interact with the contract.
Contact
Created by Prince Kumar
Email: kumarprincerajput124@gmail.com
