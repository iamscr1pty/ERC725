const claimHolder = artifacts.require("./ClaimHolder.sol");
const claimVerifier = artifacts.require("./ClaimVerifier.sol");
const testCalling = artifacts.require("./testCalling.sol");

module.exports = function(deployer) {
  deployer.deploy(claimHolder,{from: web3.eth.accounts[0]}).then(function(){
        return deployer.deploy(claimVerifier,claimHolder.address,{from: web3.eth.accounts[1]})
      }).then(function(){
          //console.log("address of first claimholder: "+claimHolder.address);
          //console.log("\naddress of claimVerifier: "+claimVerifier.address);
        });

  deployer.deploy(claimHolder,{from: web3.eth.accounts[2]}).then(function(){
      console.log("\naddress of 2nd claimholder: "+claimHolder.address);
  });
  deployer.deploy(testCalling,{from: web3.eth.accounts[3]}).then(function(){
      //console.log("\naddress of testCalling: "+testCalling.address);

  });
};
