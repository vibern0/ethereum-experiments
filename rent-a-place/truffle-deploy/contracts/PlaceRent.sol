pragma solidity ^0.4.23;

contract PlaceRent {

    struct Rent {
        uint init;
        uint end;
    }

    Rent[] public rent;
    mapping (uint => uint) private rentToPlace;
    mapping (uint => uint) private rentPlaceCounter;
    mapping (uint => address) private rentToPerson;

    constructor() public {
    }

    function rentPlace(uint8 _placeId, uint _init, uint _end) public {
        uint rentId = rent.push(Rent(_init, _end));
        rentToPlace[rentId] = _placeId;
        rentPlaceCounter[_placeId]++;
        rentToPerson[rentId] = msg.sender;
    }

    function getRent(uint8 _rentId) public view returns(uint, uint) {
        return(rent[_rentId].init, rent[_rentId].end);
    }

    function getRentByPlace(uint _placeId) external view returns(uint[]) {
        uint[] memory result = new uint[](rentPlaceCounter[_placeId]);
        
        uint counter = 0;
        for(uint i = 0; i < rent.length; i++) {
            if(rentToPlace[i] == _placeId) {
                result[counter] = i;
                counter ++;
            }
        }

        return result;
    }
}
