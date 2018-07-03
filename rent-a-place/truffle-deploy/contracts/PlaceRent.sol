pragma solidity ^0.4.23;

contract PlaceRent {

    struct Rent {
        bool isValid;
        uint init;
        uint end;
    }

    Rent[] public rents;
    mapping (uint => uint) private rentToPlace;
    mapping (uint => uint) private rentPlaceCounter;
    mapping (uint => address) private rentToPerson;

    constructor() public {
    }

    function rentPlace(uint _placeId, uint _init, uint _end) public {
        uint rentId = rents.push(Rent(true, _init, _end));
        rentToPlace[rentId] = _placeId;
        rentPlaceCounter[_placeId]++;
        rentToPerson[rentId] = msg.sender;
    }

    function getRent(uint _rentId) public view returns(uint, uint) {
        return(rents[_rentId].init, rents[_rentId].end);
    }

    function cancelRent(uint _rentId) public {
        rents[_rentId].isValid = false;
    }

    function isValidRent(uint _rentId) public view returns(bool) {
        return(rents[_rentId].isValid);
    }

    function getRentByPlace(uint _placeId) external view returns(uint[]) {
        uint[] memory result = new uint[](rentPlaceCounter[_placeId]);
        
        uint counter = 0;
        for(uint i = 0; i < rents.length; i++) {
            if(rentToPlace[i] == _placeId) {
                result[counter] = i;
                counter ++;
            }
        }

        return result;
    }
}
