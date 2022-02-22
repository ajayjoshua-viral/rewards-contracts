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
    address[] public users = [0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db,0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB,0x617F2E2fD72FD9D5503197092aC168c91465E7f2,0x17F6AD8Ef982297579C203069C1DbfFE4348c372];
    struct Userinfo{
        address payable userwallet;
        uint256 userimpression;
    }
    mapping(address => Userinfo) userinfo1;
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
    function calculateimpressionpercent(uint256 impressionoftheuser, uint256 totalimpression)public onlyOwner{    //write
       impression = ((impressionoftheuser*100) / totalimpression);
    }
    function sendreward(address payable user) public onlyOwner payable{         //write
        rewardfortheuser = (rewardamount * impression)/100 ;
        user.transfer(rewardfortheuser);
    }
    function finalimpression() external view onlyOwner returns(uint256){         //read
        return impression;
    }
    function finalrewardforuser() external view onlyOwner returns(uint256){      //read
        return rewardfortheuser;
    }

    function intialize() public view onlyOwner {
        for(uint256 i = 0 ; i < users.length ; i++){
           Userinfo memory userinfo = userinfo1[users[i]];
           userinfo.userwallet = payable(users[i]);
           userinfo.userimpression = 10;
        }
    }

}
