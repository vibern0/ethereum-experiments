var PlaceFactory = artifacts.require("./PlaceFactory.sol");

module.exports = function(deployer) {
  deployer.deploy(PlaceFactory);
};
