var RoomFactory = artifacts.require("RoomFactory");

contract('RoomFactory', function (accounts) {
    it("should publish two rooms", function () {
        return RoomFactory.deployed().then(async function (instance) {
            await instance.publishRoom(8, "quarto pequeno", true, true, {from: accounts[0]});
            await instance.publishRoom(6, "quarto simples", true, false, {from: accounts[0]});
            await instance.publishNewPlace(9, "casa grande", {from: accounts[0]});
            await instance.publishRoom(7, "quarto uni", false, false, {from: accounts[0]});
            await instance.publishNewPlace(12, "casa big", {from: accounts[0]});
        });
    });
    
    it("should get a published room from id 0", function () {
        return RoomFactory.deployed().then(function (instance) {
            return instance.getRoom(0);
        }).then(function (placeResult) {
            var dataResult = placeResult;
            var title = web3.toAscii(dataResult[1]);
            assert.equal(8, dataResult[0]);
            assert.equal("quarto pequeno", title);
            assert.equal(true, dataResult[2]);
            assert.equal(true, dataResult[3]);
        });
    });
    
    it("should get a published room from id 1", function () {
        return RoomFactory.deployed().then(function (instance) {
            return instance.getRoom(1);
        }).then(function (placeResult) {
            var dataResult = placeResult;
            var title = web3.toAscii(dataResult[1]);
            assert.equal(6, dataResult[0]);
            assert.equal("quarto simples", title);
            assert.equal(true, dataResult[2]);
            assert.equal(false, dataResult[3]);
        });
    });
    
    it("should get rooms by owner", function () {
        return RoomFactory.deployed().then(function (instance) {
            roomFactoryInstance = instance;
            return instance.getRoomsByOwner(accounts[0]);
        }).then(function (roomResult) {
            assert.equal(3, roomResult.length);
            let secondRoom = parseInt(roomResult[1].toString(10));
            roomFactoryInstance.getRoom(secondRoom).then(function (placeResult) {
                assert.equal(6, placeResult[0]);
                assert.equal(false, placeResult[3]);
            });
        });
    });
    
});