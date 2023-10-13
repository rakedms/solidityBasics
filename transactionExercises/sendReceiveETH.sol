// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract sendReceiveETH{
    function withdraw() public returns(bool) {
        address payable user=payable (msg.sender);
        bool sent=user.send(address(this).balance);
        return sent;
    } 

    receive() external payable {

     }
    fallback() external payable {

     }
}