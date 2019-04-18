pragma solidity ^0.4.25;

import './ClaimHolder.sol';

contract Election {

	  event ClaimValid(ClaimHolder _identity, uint256 claimType);
  event ClaimInvalid(ClaimHolder _identity, uint256 claimType);

  ClaimHolder public trustedClaimHolder;
  address public trust;
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Store accounts that have voted
    mapping(address => bool) public voters;
    // Store Candidates
    // Fetch Candidate
    mapping(uint => Candidate) public candidates;
    // Store Candidates Count
    uint public candidatesCount;

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );

    constructor (address _trustedClaimHolder) public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
        trust=_trustedClaimHolder;
    	trustedClaimHolder = ClaimHolder(_trustedClaimHolder);
    }

		function getVoteCount(uint256 _id) public view returns(uint256 noOfVotes){
			return candidates[_id].voteCount;
		}

    function addCandidate (string _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint256 _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);
				require(claimIsValid(msg.sender,7));
        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
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


}
