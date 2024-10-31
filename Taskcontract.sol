// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
import "hardhat/console.sol";
contract Taskcontract {
    constructor() {
        
    }

    event AddTask(address recipient,uint taskId);
    event DeleteTask(uint taskId,bool isDeleted);

    struct Task{
        uint id;
        string taskText;
        bool isDeleted;
    }

    Task[] private tasks;

    mapping (uint => address) taskOwner;

    function addTask(string memory taskText,bool isDeleted) external{
        uint taskId=tasks.length;
        tasks.push(Task(taskId,taskText,isDeleted));
        taskOwner[taskId]=msg.sender;
        //console.log("task are text: %s", tasks[taskId].taskText);
        emit AddTask(msg.sender,taskId);
    }

    function getMyTasks() external view returns(Task[] memory){
        Task[] memory temperary=new Task[](tasks.length);
        uint counter=0;
        for(uint i=0;i<tasks.length;i++)
        {
            if(taskOwner[i]==msg.sender && tasks[i].isDeleted==false)
            {
                temperary[counter]=tasks[i];
                counter++;
            }
        }
        Task[] memory result=new Task[](counter);
        for(uint i=0;i<counter;i++)
        {
            result[i]=temperary[i];
        }
        return result;
    }

    function deleteTask(uint taskId,bool isDeleted) external {
        if(taskOwner[taskId]==msg.sender)
        {
            tasks[taskId].isDeleted=isDeleted;
            emit DeleteTask(taskId,isDeleted);
        }
    }


}
