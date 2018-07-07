pragma solidity ^0.4.23;

import "./PlaceFactory.sol";
contract RoomFactory is PlaceFactory {

    struct RoomPlaceFactory {
        bool lock;
        bool table;
    }

    RoomPlaceFactory[] public rooms;
    mapping (uint => uint) private roomToPlace;
    mapping (uint => uint) private placeToRoom; //pay attetion to this variable values!

    constructor() public {
    }

    function publishRoom(uint8 _price, bytes _title, bool _lock, bool _table) public {
        uint placeId = publishNewPlace(_price, _title);
        uint roomId = rooms.push(RoomPlaceFactory(_lock, _table))-1;
        roomToPlace[roomId] = placeId;
        placeToRoom[placeId] = roomId+1;
    }

    function getRoom(uint _roomId) public view returns(uint, bytes, bool, bool) {
        uint _price;
        bytes memory _title;
        (_price, _title) = getPlace(roomToPlace[_roomId]);
        return(_price, _title, rooms[_roomId].lock, rooms[_roomId].table);
    }

    function getRoomsByOwner(address _owner) public view returns(uint[]) {
        uint[] memory placesByOwner = getPlacesByOwner(_owner);
        uint[] memory tmpResult = new uint[](placesByOwner.length);
        uint counter = 0;
        uint i;
        for(i = 0; i < placesByOwner.length; i++) {
            if(placeToRoom[placesByOwner[i]] > 0) {
                tmpResult[counter] = placesByOwner[i];
                counter ++;
            }
        }
        uint[] memory result = new uint[](counter);
        for(i = 0; i < counter; i++) {
            result[i] = tmpResult[i];
        }
        return result;
    }
}
