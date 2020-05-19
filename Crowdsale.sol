pragma solidity ^0.5.0;

import "./OmimarCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";

// @TODO: Inherit the crowdsale contracts
contract OmimarCoinSale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale {
    using SafeMath for uint;
    
    constructor(
        // @TODO: Fill in the constructor parameters!
        uint rate,             // rate, in TKNbits
        address payable wallet,  // wallet to send Ether
        OmimarCoin token,       // the token
        uint goal,          // total cap, in wei
        uint openingTime,  // opening time in unix epoch seconds
        uint closingTime  // closing time in unix epoch seconds
    )
        // @TODO: Pass the constructor parameters to the crowdsale contracts.
    Crowdsale(rate, wallet, token)
    MintedCrowdsale()
    CappedCrowdsale(goal)
    TimedCrowdsale(openingTime, closingTime)
    PostDeliveryCrowdsale()
    RefundableCrowdsale(goal)
    public
    {
         //  this crowdsale will, if it doesn't hit `goal`, allow everyone to get their money back
        // by calling claimRefund(...)
    }
}