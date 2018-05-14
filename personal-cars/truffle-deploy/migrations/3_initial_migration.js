var UserCar = artifacts.require("./UserCar.sol");

module.exports = function(deployer) {
  deployer.deploy(UserCar);
};
