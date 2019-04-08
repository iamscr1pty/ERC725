pragma solidity ^0.4.25;

contract testCalling{
  mapping(address=>bool) isVoted;
  function toBeCalled() public {
    require(isVoted[msg.sender]==false,"address already voted!");
    isVoted[msg.sender]=true;
  }
}
