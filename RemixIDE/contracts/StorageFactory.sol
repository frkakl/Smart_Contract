// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./SimpleStorage.sol";

contract StorageFactory{
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sfStore(uint _simpleStorageIndex, uint _simpleStorageNumber) public{
        simpleStorageArray[_simpleStorageIndex].Store(_simpleStorageNumber);
    }

    function sfGet(uint _simpleStorageIndex) public view returns(uint){
        return simpleStorageArray[_simpleStorageIndex].Retrieve();
    }
}