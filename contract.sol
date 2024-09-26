// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract form {
    address owner;

    struct details{
        string name ;
        uint age ;
        string post ;
    }
    
    mapping (address=> details) person_details;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyowner {
        require(owner == msg.sender, "only can call this function");
        _;
    }

    function setDetails(string memory _name,uint _age,string memory _post) public {
        person_details[msg.sender].name = _name;
        person_details[msg.sender].age = _age;
        person_details[msg.sender].post = _post;
    }
    function getDetails() public view returns(string memory,uint,string memory){
        return (person_details[msg.sender].name,person_details[msg.sender].age,person_details[msg.sender].post);
    }

    function personDetails(address _address) public view onlyowner returns(string memory,uint,string memory){
        return (person_details[_address].name,person_details[_address].age,person_details[_address].post);
    }
}
