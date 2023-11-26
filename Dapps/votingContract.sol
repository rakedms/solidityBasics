// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

abstract contract Interface  {
    modifier checkVoter(string memory _voter) virtual ;
    modifier checkCandidate(string memory _candidate) virtual;
    
    function addVoter(string memory _newVoter) public virtual;
    function addCandidate(string memory _newCandidate) public virtual;
    function addVoting(string memory _candidateName, string memory _voterName) public virtual;
    function findTheWinner() public virtual returns(string memory);

    event voterAdded(string _newvoter);
    event candidateAdded(string _newCandidate);
    event votingCompleted(string _candidateName, string);
}

contract votingCounter is Interface{
    mapping (string => uint) votingCount;
    string [] voters;
    string [] candidates;
    
    modifier checkVoter(string memory _voter) override {
        bool isVoter=false;
        for(uint i=0; i<voters.length; i++){
            string memory compareVoter = voters[i];
            if (keccak256(bytes(compareVoter)) == keccak256(bytes(_voter))){
            isVoter = true;
            }
        }    
        require(isVoter, "Voter Not Found");   
        _;
    }

    modifier checkCandidate(string memory _candidate) override {
        bool isACandidate = false;
        for(uint i=0; i<candidates.length; i++){
            if(keccak256(bytes(candidates[i])) == keccak256(bytes(_candidate))){
                isACandidate = true;
            }   
        }
        require(isACandidate, "No Candidate");
        _;
    }

    function addVoter(string memory _newVoter) public override {
        voters.push(_newVoter); 
        emit voterAdded(_newVoter);       
    }

    function addCandidate(string memory _newCandidate) public override {
        votingCount[_newCandidate] = 0;
        candidates.push(_newCandidate);
        emit candidateAdded(_newCandidate);
    }

    function addVoting(string memory _candidateName, string memory _voterName) public checkVoter(_voterName) checkCandidate(_candidateName) override {
        votingCount[_candidateName] +=1;
        emit votingCompleted(_candidateName, "voting completed");
    }

    function findTheWinner() public view override returns(string memory) {
        uint highestCount = 0;
        string memory winner;
        for(uint i=0; i<candidates.length; i++){
            string memory currentCandidate = candidates[i];

            if(highestCount <= votingCount[currentCandidate]){
                highestCount = votingCount[currentCandidate];
                winner = currentCandidate;
            }           
        }
        return winner;
    }
}
    

