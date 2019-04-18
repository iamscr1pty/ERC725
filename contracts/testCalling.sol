pragma solidity ^0.4.25;

contract testCalling{
  mapping(address=>bool) isVoted;
  uint256 public a;
  function toBeCalled(uint256 k) public {
    require(isVoted[msg.sender]==false,"address already voted!");
    isVoted[msg.sender]=true;
    a=a+k;
  }
}
