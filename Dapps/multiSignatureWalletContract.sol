// SPDX-Licence-Indentifier : MIT
pragma solidity ^0.8.0;

contract MultipleSignature{

// address[] public owners; 

struct transaction{
    uint ID;
    address[] owners;
    address to;
    bytes data;
    bool status;
    uint confirmationsRequired;
    uint confirmationsGiven;
}
transaction[] public TransactionsList;

modifier isOwner(address owner, uint _txNum) {
 bool ownerFound = false;
 transaction memory currentTx = TransactionsList[_txNum];
 for (uint i=0; i<currentTx.owners.length; i++){
    if(currentTx.owners[i] == owner){
        ownerFound = true;
    }
    require(ownerFound, "Owner Not Found");
    _;
 }
}

modifier confirmedTransaction(uint n){
    bool confirmed = false;
    transaction memory currentTransaction = TransactionsList[n];
    currentTransaction.confirmationsRequired == currentTransaction.confirmationsGiven;
    confirmed = true;
    require(confirmed, "All Confirmations Not Given");
    _;
}

function addOwner(address _newOwner, uint txNum) public {
    transaction storage currentTx = TransactionsList[txNum];
    currentTx.owners.push(_newOwner);
}

function createTransaction(uint _ID, address _to, bytes memory _data, bool _status, uint _confirmationsRequired) public {
    address[] memory newOwner = new address[](1);
    newOwner[0] = msg.sender;
    transaction memory newTransaction = 
    transaction({
        ID : _ID,
        owners : newOwner,
        to : _to,
        data : _data,
        status : _status,
        confirmationsRequired : _confirmationsRequired,
        confirmationsGiven : 0
                });
    TransactionsList.push(newTransaction);        

}


function signing(uint _transactionID, address _owner, uint TxNum) public isOwner(_owner, TxNum) view {
    transaction memory currentTransaction = TransactionsList[_transactionID];
    currentTransaction.confirmationsGiven+=1;
    } 
    
function executeTransaction(uint txNum, address _to) external confirmedTransaction(txNum) payable {
    transaction memory currentTransaction = TransactionsList[txNum];
    address[] memory newOwner = new address[](1);
    newOwner[0] = _to;
    currentTransaction.owners = newOwner;

}

}





