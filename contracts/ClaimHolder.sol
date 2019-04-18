pragma solidity ^0.4.25;

import './ERC735.sol';
import './KeyHolder.sol';

contract ClaimHolder is ERC735,KeyHolder{

  mapping(bytes32 => Claim) claims;
  mapping(uint256 => bytes32[]) claimsByType;

  function getClaim(bytes32 _claimId)
  public constant returns( address issuer, bytes32 r,bytes32 s,uint8 v, bytes32 data){
      return (claims[_claimId].issuer,
      claims[_claimId].r,claims[_claimId].s,claims[_claimId].v,claims[_claimId].data);
  }

  function getClaimIdsByType(uint256 _claimType) public constant returns(bytes32[] claimIds){
      return claimsByType[_claimType];
  }


  function addClaim(uint256 _claimType, uint256 _scheme, address _issuer, bytes32 r,bytes32 s,uint8 v, bytes32 _data, string _uri)
  public returns (bytes32 claimRequestId){
      bytes32 _claimId=keccak256(_issuer,_claimType);
      if(msg.sender!=address(this)){
        require(keyHasPurpose(keccak256(msg.sender),3),"Sender does not have the claim keys!");
      }
      if(claims[_claimId].issuer!=_issuer){
        claimsByType[_claimType].push(_claimId);
      }
      claims[_claimId].claimType = _claimType;
      claims[_claimId].scheme = _scheme;
      claims[_claimId].issuer = _issuer;
      claims[_claimId].r=r;
      claims[_claimId].s=s;
      claims[_claimId].v=v;
      claims[_claimId].data = _data;
      claims[_claimId].uri = _uri;

      emit ClaimAdded(
          _claimId,
          _claimType,
          _scheme,
          _issuer,
          _data,
          _uri
      );

      return _claimId;

  }


  function removeClaim(bytes32 _claimId) public returns (bool success){
    if (msg.sender != address(this)) {
      require(keyHasPurpose(keccak256(msg.sender), 1), "Sender does not have management key");
    }


    emit ClaimRemoved(
        _claimId,
        claims[_claimId].claimType,
        claims[_claimId].scheme,
        claims[_claimId].issuer,
        claims[_claimId].data,
        claims[_claimId].uri
    );

    delete claims[_claimId];
    return true;
  }

}
