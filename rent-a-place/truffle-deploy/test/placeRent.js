var PlaceRent = artifacts.require("PlaceRent");

contract('PlaceRent', function (accounts) {
    it("should rent a place", function () {
        return PlaceRent.deployed().then(function (instance) {
            return instance.rentPlace(0, 55, 66, {from: accounts[0]});
        }).then(function (published) {
            console.log(published);
        });
    });
    
    it("should get a rent from id", function () {
        return PlaceRent.deployed().then(function (instance) {
            return instance.getRent(0);
        }).then(function (rentResult) {
            var dataResult = rentResult;
            console.log("init: " + dataResult[0] + " / end: " + dataResult[1]);
        });
    });
    
    it("should publish one rent and get all user rents", function () {
        return PlaceRent.deployed().then(function (instance) {
            rent = instance;
            rent.rentPlace(0, 77, 88, {from: accounts[0]});
        }).then(function () {
            return rent.getRentByPlace(accounts[0]);
        }).then(function (rents) {
            var values = [55, 77];
            rents.forEach(function(value){
                rent.getRent(value.toNumber()).then(function(rentInfo) {
                    assert.equal(rentInfo[0].toNumber(), values[value.toNumber()]);
                });
            });
        });
    });
});