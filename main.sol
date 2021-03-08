// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Censorship {
    
    struct Heading {
        string Title;
        uint CensorshipValue;
        uint DisclosureValue;
    }

    struct Participant {
        uint Balance;
        mapping (address => uint) CensorshipBalances;
        mapping (address => uint) DisclosureBalances;
    }

    mapping (address => Heading )    public headings;
    mapping (address => Participant) public participants;
   

    constructor() {}

    function setHeading(string memory title) payable public{
        headings[msg.sender].DisclosureValue += msg.value;
        participants[msg.sender].Balance += msg.value;
        participants[msg.sender].DisclosureBalances[msg.sender] += msg.value;
        if (headings[msg.sender].DisclosureValue >= headings[msg.sender].CensorshipValue) {
            headings[msg.sender].Title = title;
        }
    }

    function setCenshorship(address toCensor) payable public{
        headings[toCensor].CensorshipValue += msg.value;
        participants[msg.sender].Balance += msg.value;
        participants[msg.sender].CensorshipBalances[toCensor] += msg.value;
        if (headings[toCensor].CensorshipValue > headings[toCensor].DisclosureValue ){
            headings[toCensor].Title = "";
        }
    }

    function withdrawCensorship(address fromHeading) public payable {
        uint value = participants[msg.sender].CensorshipBalances[fromHeading];
        require(value > 0);
        participants[msg.sender].CensorshipBalances[fromHeading] = 0;
        participants[msg.sender].Balance -= value;
        headings[fromHeading].CensorshipValue -= value;
        msg.sender.transfer(value);
    }

    function getHeading(address headingOwner) public view returns (string memory title) {
        title = headings[headingOwner].Title;
        return title;
    }

    function getMyHeading() public view returns (string memory title) {
        title = headings[msg.sender].Title;
        return title;
    }

    function getDisclosureValue(address headingOwner) public view returns (uint value) {
        value = headings[headingOwner].DisclosureValue;
        return value;
    }

    function getCensorshipValue(address headingOwner) public view returns (uint value) {
        value = headings[headingOwner].CensorshipValue;
        return value;
    }

    function getMyBalance() public view returns (uint balance) {
        balance = participants[msg.sender].Balance;
        return balance;
    }
}