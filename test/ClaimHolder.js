/*var claimHolder = artifacts.require("./ClaimHolder.sol");
var testCalling=artifacts.require("./testCalling.sol");
contract('claimHolder',function(accounts){
    var tokenInstance;
    var testInstance;
    it('initializes the ClaimHolder(Identity) contract with correct values',function(){
        return claimHolder.deployed().then(function(instance) {
        tokenInstance = instance;
        return tokenInstance.address;
      }).then(function(_address){
        assert.notEqual(_address,0x0,'has an address');
        return tokenInstance.getKeyFromAddress(accounts[0]);
      }).then(function(value){
         //console.log(value[0]+" "+value[1]+" "+value[2]);
          assert.equal(value[0],1,"key has management purposes!");
          assert.equal(value[1],1,"key type is ECSDA!");
         //return tokenInstance.keyHasPurpose(keccak256(accounts[0]),1);
      // }).then(function(_result){
      //   assert.equal(_result==true,'key has purpose');
      });
    });

    it('verifies the add key function for the Keyholder',function(){
        return claimHolder.deployed().then(function(instance) {
        tokenInstance = instance;
        return tokenInstance.getHashed(accounts[1]);
      }).then(function(_newkey){
        return tokenInstance.addKey(_newkey,3,1);
      }).then(function(){
        return tokenInstance.getKeyFromAddress(accounts[1]);
      }).then(function(value){
         //console.log(value[0]+" "+value[1]+" "+value[2]);
          assert.equal(value[0],3,"key has action purposes!");
          assert.equal(value[1],1,"key type is ECSDA!");
      });
    });


    // it('verifies the execute function for the Keyholder',function(){
    //     return claimHolder.deployed().then(function(instance) {
    //     tokenInstance = instance;
    //     return testCalling.deployed();
    //   }).then(function(inst){
    //       testInstance=inst;
    //       console.log(testInstance.address);
    //       return tokenInstance.execute(testInstance.address,1,"hi");
    //   // }).then(function(){
    //   //     return tokenInstance.execute(testInstance.address,1,"hi");
    //   });
    // });

    it('verifies the add claim feature of ClaimHolder',function(){
        return claimHolder.deployed().then(function(instance) {
        tokenInstance = instance;
        return tokenInstance.addClaim.call(1,1,tokenInstance.address,"sig","data","uri");
      }).then(function(_claimId){
        console.log(_claimId);
        return tokenInstance.getClaim(_claimId);
       }).then(function(value){
         console.log(value[0]);
         console.log(value[1]);
         console.log(value[2]);
         console.log(value[3]);
         console.log(value[4]);
         console.log(value[5]);
      });
    });

});
*/
