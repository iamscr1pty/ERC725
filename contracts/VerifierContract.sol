/* pragma solidity ^0.4.25;

import './ClaimHolder.sol';

contract VerifierContract{
  event ClaimValid(ClaimHolder _identity, uint256 claimType);
  event ClaimInvalid(ClaimHolder _identity, uint256 claimType);

  ClaimHolder public trustedClaimHolder;
  address public trust;

   constructor(address _trustedClaimHolder) public {
     trust=_trustedClaimHolder;
    trustedClaimHolder = ClaimHolder(_trustedClaimHolder);
  }


  function claimIsValid(address _identity, uint256 claimType)
    public
    constant
    returns (bool claimValid)
  {
    address issuer;
    bytes32 r;
    bytes32 s;
    uint8 v;
    bytes32  data;
    ClaimHolder  iden=ClaimHolder(_identity);
    // Construct claimId (identifier + claim type)
    bytes32 claimId = keccak256(trustedClaimHolder, claimType);

    // Fetch claim from user
    ( issuer, r,s,v, data) = iden.getClaim(claimId);

    bytes32 dataHash = keccak256(_identity, claimType, data);
    bytes32 prefixedHash = keccak256("\x19Ethereum Signed Message:\n32", dataHash);

    // Recover address of data signer
    address recovered = getRecoveredAddress(r,s,v, data);

    // Take hash of recovered address
    bytes32 hashedAddr = keccak256(recovered);

    // Does the trusted identifier have they key which signed the user's claim?
    return trustedClaimHolder.keyHasPurpose(hashedAddr, 3);
  }

  function getRecoveredAddress(bytes32 r,bytes32 s,uint8 v, bytes32 dataHash)
      public
      view
      returns (address addr)
  {
      bytes32 Hash = keccak256("\x19Ethereum Signed Message:\n32", dataHash);
      address recoveredAddress = ecrecover(Hash, v, r, s);

      return (recoveredAddress);
  }
} */
