const Migrations = artifacts.require("Biodata");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
