// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Censorship {
    
    struct Heading {
        string Title;
        uint CensorshipValue;
        uint DisclosureValue;
    }

    mapping (address => Heading ) public headings;

    constructor() {}

    function setHeading(string memory title) payable public{
        headings[msg.sender].DisclosureValue += msg.value;
        if (headings[msg.sender].DisclosureValue >= headings[msg.sender].CensorshipValue) {
            headings[msg.sender].Title = title;
        }
    }

    function setCenshorship(address toCensor) payable public{
        headings[toCensor].CensorshipValue += msg.value;
        if (headings[toCensor].CensorshipValue > headings[toCensor].DisclosureValue ){
            headings[toCensor].Title = "";
        }
    }

    function getHeading(address headingOwner) public view returns (string memory title) {
        title = headings[headingOwner].Title;
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
}