pragma solidity ^0.4.23;

contract CarFactory {

    struct Car {
        uint8 brand;
        uint64 price;
    }

    Car[] public cars;
    mapping (uint => address) private carToOwner;

    constructor() public {
    }

    function publishNewCar(uint8 _brand, uint64 _price) public {
        uint id = cars.push(Car(_brand, _price));
        carToOwner[id] = msg.sender;
    }

    function buyCar(uint _carId) public {
        carToOwner[_carId] = msg.sender;
    }

    function getCar(uint _carId) public view returns(uint8, uint64) {
        return (cars[_carId].brand, cars[_carId].price);
    }

    function getTotalCars() public view returns(uint) {
        return(cars.length);
    }

}
