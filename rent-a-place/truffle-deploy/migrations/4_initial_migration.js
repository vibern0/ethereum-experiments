var RoomFactory = artifacts.require("./RoomFactory.sol");

module.exports = function(deployer) {
  deployer.deploy(RoomFactory);
};
