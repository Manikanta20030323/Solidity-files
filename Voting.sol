// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Voting{
    struct Candidate{
        string name;
        string partyname;
        uint voteCount;
        bool deleteCandidate;
    }

    Candidate[] public candidates;
    address votingCommision;
    mapping(address=>bool) public voters;
    uint public votingStart;
    uint public votingEnd;

    constructor()
    {
        votingCommision=msg.sender;
        votingStart=block.timestamp;
        votingEnd=block.timestamp + (90  * 1 minutes);

    }

    modifier onlyVotingCommision{
        require(msg.sender==votingCommision);
        _;
    }
    function addCandidate(string memory _name,string memory _partyName) public onlyVotingCommision{
        candidates.push(Candidate(_name,_partyName,0,false));
    }

    function vote(uint _candidateIndex) public {
        require(!voters[msg.sender],"You have already voted");
        candidates[_candidateIndex].voteCount++;
        voters[msg.sender]=true;

    }

    function getAllVotesOfCandiates() public view onlyVotingCommision returns(Candidate[] memory) {
        return candidates;
    }

    function getVotingStatus() public view  returns(bool){
        return (block.timestamp >=votingStart && block.timestamp< votingEnd);
    }

    function getRemainingTime() public view returns(uint){
        require(block.timestamp >=votingStart,"Voting has not started yet.");

        if(block.timestamp>= votingEnd)
        {
            return 0;
        }
        return votingEnd-block.timestamp;
    }

    function removeCand(uint _candidateIndex) public onlyVotingCommision{
        candidates[_candidateIndex].deleteCandidate=true;
    }

    
}