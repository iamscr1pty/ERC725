pragma solidity ^0.4.25;

import './ERC725.sol';
import './testCalling.sol';

contract KeyHolder is ERC725{

  uint256 executionNonce;

  struct Execution{
    address to;
    uint256 value;
    bytes data;
    bool approved;
    bool executed;
  }

  mapping(bytes32 => Key) keys;
  mapping(uint256 => bytes32[]) keysByPurpose;
  mapping(uint256 => Execution) executions;

  constructor() public{
    bytes32 _key=keccak256(msg.sender);
    keys[_key].key=_key;
    keys[_key].purpose=1;
    keys[_key].keyType=1;
    keysByPurpose[1].push(_key);
    emit KeyAdded(_key,keys[_key].purpose,keys[_key].keyType);
  }
  function getKey(bytes32 _key) public constant returns(uint256 purpose, uint256 keyType, bytes32 key){
    return (keys[_key].purpose,keys[_key].keyType,keys[_key].key);
  }
  function getKeyPurpose(bytes32 _key) public constant returns(uint256 purpose)
  {
    return keys[_key].purpose;
  }
  function getKeysByPurpose(uint256 _purpose) public constant returns(bytes32[] _keys){
    return keysByPurpose[_purpose];
  }
  function addKey(bytes32 _key, uint256 _purpose, uint256 _keyType) public returns (bool success){
          require(keys[_key].key!=_key,"key already exists!");

          if(msg.sender!=address(this)){
              require(keyHasPurpose(keccak256(msg.sender),uint256(1)),"Sender does not have Management keys!");
          }

          keys[_key].key=_key;
          keys[_key].purpose=_purpose;
          keys[_key].keyType=_keyType;
          keysByPurpose[_purpose].push(_key);
          emit KeyAdded(_key,keys[_key].purpose,keys[_key].keyType);
          return true;
  }
  function keyHasPurpose(bytes32 _key, uint256 _purpose)
      public
      view
      returns(bool result)
  {
      bool isThere;
      if (keys[_key].key == 0) return false;
      isThere = keys[_key].purpose <= _purpose;
      return isThere;
  }
  function approve(uint256 _id, bool _approve)
      public
      returns (bool success)
  {
          require(keyHasPurpose(keccak256(msg.sender),uint256(2)),"Sender does not have action key!");
          emit Approved(_id,_approve);

          if (_approve == true) {
              executions[_id].approved = true;
              //Example : contractAddress.call(bytes4(keccak256("foobar(uint256,uint256)")), val1, val2);
              //success = executions[_id].to.call.value(executions[_id].value)(executions[_id].data, 0);
              testCalling cont=testCalling(executions[_id].to);
              cont.toBeCalled();//delegatecall(bytes4(keccak256("toBeCalled()")));
              if (success) {
                  executions[_id].executed = true;
                  emit Executed(
                      _id,
                      executions[_id].to,
                      executions[_id].value,
                      executions[_id].data
                      );
                  return true;
              } else {
                  /*emit ExecutionFailed(
                      _id,
                      executions[_id].to,
                      executions[_id].value,
                      executions[_id].data
                  );*/
                  return false;
              }
          } else {
                  executions[_id].approved = false;
                  }
          return true;
  }

  function execute(address _to, uint256 _value, bytes _data)
      public
      payable
      returns (uint256 executionId)
  {
    require(!executions[executionNonce].executed, "Already executed");
    executions[executionNonce].to = _to;
    executions[executionNonce].value = _value;
    executions[executionNonce].data = _data;

    emit ExecutionRequested(executionNonce, _to, _value, _data);

    if (keyHasPurpose(keccak256(msg.sender),1) || keyHasPurpose(keccak256(msg.sender),2)) {
        approve(executionNonce, true);
    }

    executionNonce++;
    return executionNonce-1;
  }

  function removeKey(bytes32 _key)
      public
      returns (bool success)
  {
    require(keys[_key].key == _key, "No such key");
    emit KeyRemoved(keys[_key].key, keys[_key].purpose, keys[_key].keyType);

    delete keys[_key];

    return true;
  }
  function getKeyFromAddress(address _addr) public constant returns (uint256 purpose, uint256 keyType, bytes32 key){
    bytes32 key_h=keccak256(_addr);
    return (keys[key_h].purpose,keys[key_h].keyType,keys[key_h].key);
  }
  function getHashed(address _addr) public constant returns(bytes32 myval){
    return keccak256(_addr);
  }
}
