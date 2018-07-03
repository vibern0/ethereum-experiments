var PlaceFactory = artifacts.require("PlaceFactory");

contract('PlaceFactory', function (accounts) {
    it("should publish a place", function () {
        return PlaceFactory.deployed().then(function (instance) {
            return instance.publishNewPlace(8, "casa pequena", {from: accounts[0]});
        }).then(function (published) {
            console.log(published);
        });
    });
    
    it("should get a published place from id", function () {
        return PlaceFactory.deployed().then(function (instance) {
            return instance.getPlace(0);
        }).then(function (placeResult) {
            var dataResult = placeResult;
            var title = web3.toAscii(dataResult[1]);
            console.log("price: " + dataResult[0] + " / title: " + title);
        });
    });
    
    it("should publish one places and get all user places", function () {
        return PlaceFactory.deployed().then(function (instance) {
            place = instance;
            place.publishNewPlace(14, web3.fromAscii("casa pequena"), {from: accounts[0]});
        }).then(function () {
            return place.getPlacesByOwner(accounts[0]);
        }).then(function (places) {
            var values = [8, 14];
            places.forEach(function(value){
                place.getPlace(value.toNumber()).then(function(placeInfo) {
                    assert.equal(placeInfo[0].toNumber(), values[value.toNumber()]);
                });
            });
        });
    });
});