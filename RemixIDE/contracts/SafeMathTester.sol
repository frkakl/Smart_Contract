// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract SafeMathTester{
    uint8 public bigNumber = 255;

    function add() public{
        bigNumber = bigNumber + 1;
    }
}