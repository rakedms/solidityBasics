// SPDX-Licence-Identifier: MIT

pragma solidity ^0.8.0;

abstract contract TaskManagementInterface{
    event taskCreated(uint taskID, string TaskDescription);
    event taskDescription(string description);
    event taskDeleted(uint taskID, string TaskDescription);
    function createTask(string memory _description) public virtual ;
}

contract TaskManagement is TaskManagementInterface{
    struct Task{
        string TaskDescription;
        bool status;
    }

    uint taskCounter;
    
    mapping (uint => Task) public TaskList;

    // event taskCreated(uint taskID, string _TaskDescription);
    // event taskDescription(uint taskID);
    // event taskDeleted(uint taskID, string taskDeleted);

    function createTask(string memory _description) public override {
        taskCounter++;
        TaskList[taskCounter] = Task(_description,false);
        emit taskCreated(taskCounter, _description);
    }  

    function retreiveTask(uint _taskID) public {
        emit taskDescription(TaskList[_taskID].TaskDescription);
    }

    function deleteTask(uint _removeTaskID) public{
        TaskList[_removeTaskID] = Task("",false);
        emit taskDeleted(_removeTaskID, "Task Deleted");
    }  

}