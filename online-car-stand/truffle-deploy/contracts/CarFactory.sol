pragma solidity ^0.4.23;

import "./Ownable.sol";

contract CarFactory is Ownable {

    event NewCar(string brand, string model, uint64 price);
    event CarBought(uint carId);
    struct Car {
        string brand;
        string model;
        uint64 price;
    }

    Car[] public cars;
    mapping (uint => address) public carToOwner;
    mapping (address => uint) ownerCarCount;

    function publishNewCar(string _brand, string _model, uint64 _price) public {
        require(ownerCarCount[msg.sender] == 0);
        uint id = cars.push(Car(_brand, _model, _price)) - 1;
        carToOwner[id] = msg.sender;
        ownerCarCount[msg.sender]++;
        emit NewCar(_brand, _model, _price);
    }

    function buyCar(uint carId) public {
        require(ownerCarCount[msg.sender] == 0);
        ownerCarCount[carToOwner[carId]]--;
        ownerCarCount[msg.sender]++;
        carToOwner[carId] = msg.sender;
        emit CarBought(carId);
    }

}
