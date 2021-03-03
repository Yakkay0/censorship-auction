// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Censorship {
    
    struct Heading {
        string Title;
        //uint CensorshipValue;
        //uint DiscloseValue;
    }

    mapping (address => Heading ) public headings;

    constructor() {}

    function setHeading(string memory title) public{
        headings[msg.sender] = Heading(
            {
                Title: title
                //CensorshipValue: censorshipValue,
                //DiscloseValue: discloseValue
            });
    }

    function getHeading()public view returns (string memory title) {
        title = headings[msg.sender].Title;
        return title;
    }
}