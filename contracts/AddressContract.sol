pragma solidity ^0.4.25;
import './ClaimHolder.sol';
contract AddressContract{
  ClaimHolder public issuerContract;
  ClaimHolder public customerContract;
  constructor(address _issuerContract) public{
      issuerContract=ClaimHolder(_issuerContract);
  }
  function setCustomerIdentity(address _customerContract) public {
    customerContract=ClaimHolder(_customerContract);
  }
}
