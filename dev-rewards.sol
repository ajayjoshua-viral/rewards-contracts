// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.5.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.5.0/token/ERC20/extensions/ERC20Snapshot.sol";
import "@openzeppelin/contracts@4.5.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.5.0/security/Pausable.sol";

contract DevReward is  Ownable, Pausable {
   
    uint256 public rewardamount;
    uint256 public rewardforthedev;
    uint256 public likes = 0.0;
    uint256 public totallikes = 0;


    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }
    
    function recivereward() public onlyOwner payable{                        //money send 
      rewardamount = address(this).balance;
    }
    
    function totalrewardamount() external view onlyOwner returns(uint256){     // read 
         return rewardamount;
    }

    function finalimpression() external view onlyOwner returns(uint256){         //read
        return likes;
    }
    function finalrewardforuser() external view onlyOwner returns(uint256){      //read
        return rewardforthedev;
    }

    function totalimpressionoftheday(uint256 totalLikesOfTheDay) public onlyOwner{  //write
          totallikes = totalLikesOfTheDay;
    }
    
    function claim(uint256 likesofthedev) public {                         //claim function
        require(totallikes != 0,"you cant claim your rewards yet");
        require(rewardamount != 0,"you cant claim your rewards yet");
        likes = ((likesofthedev*100) / totallikes);
        rewardforthedev = (rewardamount * likes)/100 ;
        payable(msg.sender).transfer(rewardforthedev);
    }

}
