pragma solidity ^0.4.23;

import "./PlaceFactory.sol";
contract RoomFactory is PlaceFactory {

    struct RoomPlaceFactory {
        bool lock;
        bool table;
    }

    RoomPlaceFactory[] public rooms;
    mapping (uint => uint) private roomToPlace;
    mapping (uint => uint) private placeToRoom;
    mapping (address => uint) private ownerRoomsCounter;

    constructor() public {
    }

    function publishRoom(uint8 _price, bytes _title, bool _lock, bool _table) public {
        uint placeId = publishNewPlace(_price, _title);
        uint roomId = rooms.push(RoomPlaceFactory(_lock, _table));
        roomToPlace[roomId] = placeId;
        placeToRoom[placeId] = roomId;
        ownerRoomsCounter[msg.sender]++;
    }

    function getRoom(uint _roomId) public view returns(uint, bytes, bool, bool) {
        uint _price;
        bytes memory _title;
        (_price, _title) = getPlace(roomToPlace[_roomId]);
        return(_price, _title, rooms[_roomId].lock, rooms[_roomId].table);
    }

    function getRoomsByOwner(address _owner) public view returns(uint[]) {
        uint[] memory placesByOwner = getPlacesByOwner(_owner);
        uint ownerRooms = ownerRoomsCounter[_owner];
        uint[] memory result = new uint[](ownerRooms);
        
        uint counter = 0;
        uint i;
        uint p;
        for(i = 0; i < ownerRooms; i++) {
            for(p = 0; p < placesByOwner.length; p++) {
                if(placeToRoom[i] == placesByOwner[p]) {
                    result[counter] = i;
                    counter ++;
                    break;
                }
            }
        }
        return result;
    }
}
