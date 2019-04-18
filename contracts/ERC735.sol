pragma solidity ^0.4.25;

contract ERC735 {

    event ClaimRequested(uint256 indexed claimRequestId, uint256 indexed claimType, uint256 scheme, address indexed issuer, bytes32 r,bytes32 s,uint8 v, bytes32 data, string uri);
    event ClaimAdded(bytes32 indexed claimId, uint256 indexed claimType, uint256 scheme, address indexed issuer,  bytes32 data, string uri);
    event ClaimRemoved(bytes32 indexed claimId, uint256 indexed claimType, uint256 scheme, address indexed issuer, bytes32 data, string uri);
    event ClaimChanged(bytes32 indexed claimId, uint256 indexed claimType, uint256 scheme, address indexed issuer, bytes32 data, string uri);

    struct Claim {
        uint256 claimType;
        uint256 scheme;
        address issuer; // msg.sender
        bytes32 r; // this.address + claimType + data
        bytes32 s;  // r,s,v are parts of the eth signature
        uint8 v;
        bytes32 data;
        string uri;
    }

    function getClaim(bytes32 _claimId)
    public constant returns( address issuer, bytes32 r,bytes32 s,uint8 v, bytes32 data);
    function getClaimIdsByType(uint256 _claimType) public constant returns(bytes32[] claimIds);
    function addClaim(uint256 _claimType, uint256 _scheme, address issuer, bytes32 r,bytes32 s,uint8 v, bytes32 _data, string _uri) public returns (bytes32 claimRequestId);
    function removeClaim(bytes32 _claimId) public returns (bool success);
}
