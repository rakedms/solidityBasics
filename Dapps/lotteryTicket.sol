// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract lotteryTicket{
    uint lotteryID = 0;
    uint [] IDs;
    mapping (uint => string) TicketOwnership;

    function addOwner(string memory _ownerName) public {
        IDs.push(lotteryID);
        TicketOwnership[lotteryID] = _ownerName;
        lotteryID++;
    }

    function smallestID() public view returns(uint) {
        uint smallID = 1;
        for(uint i=0; i<IDs.length; i++){
            if(smallID>IDs[i]){
                smallID = IDs[i];
            }
        }
        return smallID;
    }

    function largetID() public view returns(uint) {
        uint largeID = 0;
        for(uint i=0; i<IDs.length; i++){
            if(largeID<IDs[i]){
                largeID = IDs[i];
            }    
        }
        return largeID;
    }

    function luckyDraw() public view returns(uint, string memory){
        uint randomNo = uint (keccak256(abi.encode(blockhash(block.number +3), block.timestamp)));
        uint a = smallestID();
        uint b = largetID();

        uint luckyNumber = (randomNo % ((b+1) - a)) + a;
        string memory winner = TicketOwnership[luckyNumber];
        return (luckyNumber, winner);

    }
}