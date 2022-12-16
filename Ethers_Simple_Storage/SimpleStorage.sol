// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract SimpleStorage {
    //Data Types: Bool, uint, int, string, adress, bytes

    // public: visible externally and internally (creates a getter function for storage/state variables)
    // private: only visible in the current contract
    // external: only visible externally (only for functions)
    // internal: only visible internally

    bool FavNum = true; // true or false
    uint FavNum1 = 7; // Positive Whole Numbers, up to 256 bit.

    uint16 FavNum2 = 619; // Max 16 bit
    int FavNum3 = -9; // Positive or Negative whole nums
    string FavNuminText = "Seven"; //Text
    address myAddress = 0xf2AfA62533357e2a39864680A3dAcd1f49FA6bd5; // Wallet address

    uint favoriteNumber; // Initialized to zero and everyone can access

    function Store(uint _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    // view and pure functions doesn't spend gas fee
    function Retrieve() public view returns (uint) {
        return favoriteNumber;
    }

    mapping(string => uint) public nameToFavoriteNumber; // name to favnum mapping

    struct People {
        uint favoriteNumber;
        string name;
    }

    People[] public people; // Create Array

    function addPerson(string memory _name, uint _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name));

        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
