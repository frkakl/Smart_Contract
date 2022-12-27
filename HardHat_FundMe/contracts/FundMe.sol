// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "./PriceConverter.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe{

    using PriceConverter for uint;

    uint public constant minimumUsd = 50 * 1e18;
    
    address[] public funders;
    mapping(address => uint) public addressToAmountFunded;

    address public immutable owner; 
    
    AggregatorV3Interface public priceFeed;

    constructor(address priceFeedAddress){
        owner = msg.sender;
        priceFeed = AggregatorV3Interface(priceFeedAddress);
    }

    function fund() public payable {
        require(msg.value.getConversionRate(priceFeed) >= minimumUsd, "Not Enough ETH");
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }
   
    function withdraw() public onlyOwner {

        for(uint funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);

        // transfer 
        //payable(msg.sender).transfer(address(this).balance);
        
        // send
        //bool sendSucces = payable(msg.sender).send(address(this).balance);
        //require(sendSucces, "Send Failed.");
        
        //call
        (bool callSucces, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSucces, "Call Failed.");

    }

    modifier onlyOwner(){
        require(msg.sender == owner, "You are not owner");
        _;

    }

    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }

}