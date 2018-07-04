pragma solidity ^0.4.23;

contract PlaceFactory {

    struct Place {
        bool isAvailable;
        bool isRent;
        uint8 price;
        bytes title;
    }

    Place[] public places;
    mapping (uint => address) private placeToOwner;
    mapping (address => uint) private ownerPlacesCounter;

    constructor() public {
    }

    function publishNewPlace(uint8 _price, bytes _title) public {
        uint id = places.push(Place(true, false, _price, _title));
        placeToOwner[id] = msg.sender;
        ownerPlacesCounter[msg.sender]++;
    }

    function getPlace(uint _placeId) public view returns(uint, bytes) {
        return(places[_placeId].price, places[_placeId].title);
    }
    
    function cancelPlace(uint _placeId) public {
        places[_placeId].isAvailable = false;
    }
    
    function restorePlace(uint _placeId) public {
        places[_placeId].isAvailable = true;
    }

    function isPlaceAvailable(uint _placeId) public view returns(bool) {
        return(places[_placeId].isAvailable);
    }

    function getPlacesByOwner(address _owner) external view returns(uint[]) {
        uint[] memory result = new uint[](ownerPlacesCounter[_owner]);
        
        uint counter = 0;
        for(uint i = 0; i < places.length; i++) {
            if(placeToOwner[i] == _owner) {
                result[counter] = i;
                counter ++;
            }
        }

        return result;
    }
}
