// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.5.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.5.0/token/ERC20/extensions/ERC20Snapshot.sol";
import "@openzeppelin/contracts@4.5.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.5.0/security/Pausable.sol";

contract Reward is ERC20, ERC20Snapshot, Ownable, Pausable {
   
    uint256 public rewardamount;
    uint256 public rewardfortheuser;
    uint256 public impression = 0.0;
    uint256 public totalimp = 0;

    constructor() ERC20("reward", "RWD") {}

    function snapshot() public onlyOwner {
        _snapshot();
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override(ERC20, ERC20Snapshot)
    {
        super._beforeTokenTransfer(from, to, amount);
    }
    function recivereward() public onlyOwner payable{                        //money send 
      rewardamount = address(this).balance;
    }
    
    function totalrewardamount() external view onlyOwner returns(uint256){     // read 
         return rewardamount;
    }

    function finalimpression() external view onlyOwner returns(uint256){         //read
        return impression;
    }
    function finalrewardforuser() external view onlyOwner returns(uint256){      //read
        return rewardfortheuser;
    }

    function totalimpressionoftheday(uint256 totalImpressionOfTheDay) public onlyOwner{  //write
          totalimp = totalImpressionOfTheDay;
    }
    
    function claim(uint256 impressionoftheuser) public {                         //claim function
        require(totalimp != 0,"you cant claim your rewards yet");
        impression = ((impressionoftheuser*100) / totalimp);
        rewardfortheuser = (rewardamount * impression)/100 ;
        payable(msg.sender).transfer(rewardfortheuser);
    }

}
