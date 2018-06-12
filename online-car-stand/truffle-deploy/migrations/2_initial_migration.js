var CarFactory = artifacts.require("./CarFactory.sol");

module.exports = function(deployer) {
  deployer.deploy(CarFactory);
};
