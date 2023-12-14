// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FunNFT{
    uint256 maximumTokens;

    mapping (address => uint256) BalancesOf;
    mapping (uint256 => address) Owners;
    mapping (uint256 => address) Approvals;
    mapping (address => mapping(address => bool)) ApproveForAll; 

    event Minted(string x,uint indexed TokensCount);


    function mint(uint256 _totalSupply, address initialOwner) public returns (uint256){
        maximumTokens = _totalSupply;
        emit Minted("Total Supply is:", maximumTokens);
        BalancesOf[initialOwner] = maximumTokens;

        for(uint8 i=1; i<=maximumTokens; i++ ){
            Owners[i] = initialOwner;
        }

        return (maximumTokens);
    }

    function balanceOf(address _BalanceIn) public view returns(uint256){
        return (BalancesOf[_BalanceIn]);
    }

    function ownerOf(uint256 _tokenID) public view returns(address){
        return (Owners[_tokenID]);
    }

    function getApproved(uint _tokenID) public view returns (address){
        return (Approvals[_tokenID]);
    }

    function setApprovedForAll(uint _tokenID, address owner, address Rep) external{
        require(msg.sender == Owners[_tokenID] || 
                msg.sender == Approvals[_tokenID],
                "The requestor is not a owner and don't have the approval");
        ApproveForAll[owner][Rep] = true;

    }

    function _transferFrom(uint256 _tokenID, address _owner, address _to) external{
        require(msg.sender == Owners[_tokenID] || 
                 msg.sender == Approvals[_tokenID] ||
                 ApproveForAll[_owner][msg.sender],
                 "The requestor is not a owner and don't have the approval");

        Owners[_tokenID] = _to;
        Approvals[_tokenID] = _to;
        ApproveForAll[_owner][msg.sender] = false;     

        BalancesOf[_owner] -=1;

    }

}