pragma solidity ^0.4.17;

contract MetaCoin {
    uint balance;

    constructor(uint _balance) public {
        balance = _balance;
    }
}