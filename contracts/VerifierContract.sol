pragma solidity ^0.4.25;

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

  /* function checkClaim(ClaimHolder _identity, uint256 claimType)
    public
    returns (bool claimValid)
  {
    if (claimIsValid(_identity, claimType)) {
      emit ClaimValid(_identity, claimType);
      return true;
    } else {
      emit ClaimInvalid(_identity, claimType);
      return false;
    }
  } */

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

    /* bytes32 dataHash = keccak256(_identity, claimType, data);
    bytes32 prefixedHash = keccak256("\x19Ethereum Signed Message:\n32", dataHash); */

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
      /* bytes32 ra;
      bytes32 sa;
      uint8 va;

      // Check the signature length
      if (sig.length != 65) {
        return (0);
      }

      // Divide the signature in r, s and v variables
      assembly {
        ra := mload(add(sig, 32))
        sa := mload(add(sig, 64))
        va := byte(0, mload(add(sig, 96)))
      }

      if (va < 27) {
        va += 27;
      } */
      bytes32 Hash = keccak256("\x19Ethereum Signed Message:\n32", dataHash);
      address recoveredAddress = ecrecover(Hash, v, r, s);

      return (recoveredAddress);
  }
}
