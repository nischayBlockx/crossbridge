// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.4.0-solc-0.7/contracts/token/ERC20/ERC20.sol";

contract CrowdsaleEth is ERC20 {
    
    
    using SafeMath for uint256;
    
    uint256 public constant ETH_MAX_SUPPLY = 33996;
    uint256 public constant ETH_MAX_SALE_SUPPLY= 10000;
    uint256 public constant TOKEN_TOBE_MINTED= 23996;
    uint256 public eth_burn_supply;
    uint256 public totalsupply;
    uint256 public eth_supply;
    uint256 public cycleTokenMint;
    
    address public owner ;
    uint public monthIndex=0;
    uint256 public tokenmint=TOKEN_TOBE_MINTED;
    uint256 public launchtime=block.timestamp; // change according to launching
    address[] public eth_sale_contributors;
    mapping (address => uint256) eth_sale_balance_mapping;
   

    constructor () ERC20("Ethereum", "ERC20") {
        _mint(msg.sender,ETH_MAX_SALE_SUPPLY);
        
    }
    
    
      modifier onlyOwner() {
        require(owner == msg.sender,"Not Owner");
        _;
    }

    function BatchTransfer(address[] memory _addr, uint256[] memory _amounts )public onlyOwner {
        require(_addr.length == _amounts.length);
        eth_burn_supply=ETH_MAX_SALE_SUPPLY;
        for(uint256 index=0; index<_addr.length; index++){
            address payable toAddress = payable(_addr[index]);
            uint256 transferAmount = _amounts[index];
            totalsupply=totalsupply.add(transferAmount);
            require(totalsupply <=ETH_MAX_SALE_SUPPLY,"Maximum sale amount reached");
            eth_supply=eth_supply.add(transferAmount);
            eth_sale_contributors.push(toAddress);
            eth_sale_balance_mapping[toAddress] = eth_sale_balance_mapping[toAddress].add(transferAmount);
            eth_burn_supply = eth_burn_supply.sub(transferAmount);
            
        }
    }
        
        function burn(address _to,uint256 _amount) public onlyOwner {
            _amount=eth_burn_supply;
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