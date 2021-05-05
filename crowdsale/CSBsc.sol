// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.4.0-solc-0.7/contracts/token/ERC20/ERC20.sol';

contract CrowdsaleBsc is ERC20 {
    
    using SafeMath for uint256;
    
    uint256 public constant BSC_MAX_SUPPLY = 33996;
    uint256 public constant BSC_MAX_SALE_SUPPLY= 10000;
    uint256 public constant TOKEN_TOBE_MINTED= 23996;
    uint256 public bsc_burn_supply;
    uint256 public totalsupply;
    uint256 public bsc_supply;
    uint256 public cycleTokenMint;
    
    address public owner ;
    uint public monthIndex=0;
    uint256 public tokenmint=TOKEN_TOBE_MINTED;
    uint256 public launchtime=block.timestamp; // change according to launching
    address[] public bsc_sale_contributors;
    mapping (address => uint256) bsc_sale_balance_mapping;
   

    constructor () ERC20("Binance", "BNBT") {
        _mint(msg.sender,BSC_MAX_SALE_SUPPLY);
    }
    
    
     modifier onlyOwner() {
        require(owner == msg.sender,"Not Owner");
        _;
    }

    function BatchTransfer(address[] memory _addr, uint256[] memory _amounts )public onlyOwner {
        require(_addr.length == _amounts.length);
        bsc_burn_supply=BSC_MAX_SALE_SUPPLY;
        for(uint256 index=0; index<_addr.length; index++){
            address payable toAddress = payable(_addr[index]);
            uint256 transferAmount = _amounts[index];
            totalsupply=totalsupply.add(transferAmount);
            require(totalsupply <=BSC_MAX_SALE_SUPPLY,"Maximum sale amount reached");
            bsc_supply=bsc_supply.add(transferAmount);
            bsc_sale_contributors.push(toAddress);
            bsc_sale_balance_mapping[toAddress] = bsc_sale_balance_mapping[toAddress].add(transferAmount);
            bsc_burn_supply = bsc_burn_supply.sub(transferAmount);
            
        }
    }
        
        function burn(address _to,uint256 _amount) public onlyOwner {
            _amount=bsc_burn_supply;
            _burn(_to,_amount);
          
            
        }
        
        function startCycleMintToken() public {
            
                if(CheckStatus()){
                tokenmint=tokenmint.div(2);
                _mint(msg.sender,tokenmint);
                cycleTokenMint=tokenmint;
                
                
            }
        }
        
        function CheckStatus() public returns (bool) {
        
        if((block.timestamp >= launchtime + (monthIndex * 60 days)) && (monthIndex >=0 && monthIndex <= 22))
        {   
            
         monthIndex=monthIndex+2;
         return true;
        }
        else{
            return false;
        }
    }
 
    
}