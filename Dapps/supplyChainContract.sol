// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract Interface{
    enum State {created, inTransit, supplied}

    mapping (uint => Goods) GoodsList;
    uint goodsID = 0;

    struct Goods{
            string Name;
            uint numbers;
            address owner;
            uint weight;
            State state;
        }


    function addGoods(string memory _goodType, uint _qty, address _owner, uint _weight,State _currentState) public virtual;
    function findGoods(uint _ID) public view virtual returns(Goods memory) ;       
}

contract supplyChainContract is Interface{

        function addGoods(
            string memory _goodType,
            uint _qty,
            address _owner,
            uint _weight,
            State _currentState) public override {
                goodsID++;
                GoodsList[goodsID] = Goods({
                    Name : _goodType,
                    numbers : _qty,
                    owner : _owner,
                    weight : _weight,
                    state :  _currentState
                });

            }

         function changeTheState(State _state, uint _ID) public {
            require(_ID <= goodsID, "Incorrect ID");
            GoodsList[_ID].state = _state;
         }   


        function findGoods(uint _ID) public view override  returns(Goods memory)  {
            require(_ID <= goodsID, "ID is incorrect");
            return (GoodsList[_ID]);
        }

}