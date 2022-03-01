// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.5.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.5.0/token/ERC20/extensions/ERC20Snapshot.sol";
import "@openzeppelin/contracts@4.5.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.5.0/security/Pausable.sol";

contract Globalcontract is  Ownable, Pausable {
   
    uint256 public rewardamount;
    uint256 public finalrewardamount;
    uint256 public devlopersmartcontractreward;
    uint256 public usersmartcontractreward;
    address payable userreward =  payable(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);
    address payable devloperreward = payable(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db);

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }
    
    function recivereward() public onlyOwner payable{                        //money send 
      rewardamount = address(this).balance;
    }
    
    function freezereward() public onlyOwner {
        finalrewardamount = rewardamount;
    }
    function totalrewardamount() external view onlyOwner returns(uint256){     // read 
         return finalrewardamount;
    }
    
    function distribute() public onlyOwner {                   // send money to smart contract 
        require(finalrewardamount != 0);
        devlopersmartcontractreward = (finalrewardamount*10)/100;
        usersmartcontractreward = (finalrewardamount*30)/100;
        userreward.transfer(usersmartcontractreward);
        devloperreward.transfer(devlopersmartcontractreward);
    }

}

