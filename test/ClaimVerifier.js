/*var ClaimVerifier=artifacts.require("./ClaimVerifier.sol");
var ClaimHolder=artifacts.require("./ClaimHolder.sol");
contract(ClaimVerifier,function(accounts){
    var tokenInstance;
    var claimInstance;
    it('checks if the initialization is done correctly',function(){
        return ClaimVerifier.deployed().then(function(instance){
            tokenInstance=instance;
            return tokenInstance.address;
        }).then(function(_address){
            assert.notEqual(_address,0x0,'claimverifier has an address');
            return tokenInstance.trust();
        }).then(function(_claimAddress){
          console.log(_claimAddress);
            assert.notEqual(_claimAddress,0x0,'claimholder has an address');
        });
    });

    // it('checks if checkClaim is working properly',function(){
    //     return ClaimVerifier.deployed().then(function(instance){
    //         tokenInstance=instance;
    //         return ClaimHolder.deployed();
    //     }).then(function(inst){
    //         claimInstance=inst;
    //         return claimInstance.getHashed(accounts[1]);
    //     }).then(function(bytes32 _key){
    //         return claimInstance.addKey(_key,3,1);
    //     }).then(function(){
    //         var hexData=web3.utils.asciiToHex("this is a test!");
    //         var hashedDataToSign=web3.utils.soliditySha3()
    //     })
    // });
});
*/
