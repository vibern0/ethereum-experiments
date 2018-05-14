pragma solidity ^0.4.17;

contract UserCar {
    struct LibraryCars {
        string[] car;
    }

    mapping(address => LibraryCars) private cars;

    constructor() public {
        
    }

    function addUserCar(string carName) public {
        cars[msg.sender].car.push(carName);
    }

    function getUserCar(address userAddress, uint index) public view returns(string carName) {
        return(cars[userAddress].car[index]);
    }
}