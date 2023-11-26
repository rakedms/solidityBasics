// SPDX-License-Identifier : MIT
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract Interface{
    function SendFromTo(address _from, address _to, uint _amount) public payable virtual;

}
contract simpleWallet is Interface {
    mapping (address => uint) balancesRecord;

    event transferred(address _from,address _to, uint amount);
    function SendFromTo(address _from, address _to, uint _amount) public payable  override  {
        require(_from.balance >= _amount, "Insufficient Balance");
        payable(_to).transfer(_amount);
        emit transferred(_from, _to, _amount);
    }

    function withdraw(uint _amount, address _to ) public payable  {
        require(address(this).balance >= _amount, "Insufficient balance");
        payable (_to).transfer(_amount);
    }

    function balance (address Address) public view returns(uint){
        return (Address.balance);
    }


}
