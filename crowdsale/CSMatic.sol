pragma solidity ^0.6.0;

import "https://github.com/maticnetwork/pos-portal/blob/master/flat/ChildMintableERC20.sol";

contract CrowdsaleMatic is ChildMintableERC20 {
    
    
    uint256 public constant MATIC_MAX_SUPPLY = 33996;
    uint256 public constant MATIC_MAX_SALE_SUPPLY= 10000;
    uint256 public constant TOKEN_TOBE_MINTED= 23996;
    uint256 public matic_burn_supply;
    uint256 public totalsupply;
    uint256 public matic_supply;
    uint256 public cycleTokenMint;
    
    address public owner ;
    uint public monthIndex=0;
    uint256 public tokenmint=TOKEN_TOBE_MINTED;
    uint256 public launchtime=now; // change according to launching
    address[] public matic_sale_contributors;
    mapping (address => uint256) matic_sale_balance_mapping;
   

    constructor () public ChildMintableERC20("Matic", "MTC",18,0x2e5e27d50EFa501D90Ad3638ff8441a0C0C0d75e) {
        owner=msg.sender;
        mint(msg.sender, MATIC_MAX_SALE_SUPPLY);
        
        
    }
    
    modifier onlyOwner() {
        require(owner == msg.sender,"Not Owner");
        _;
    }

    function BatchTransfer(address[] memory _addr, uint256[] memory _amounts )public onlyOwner {
        require(_addr.length == _amounts.length);
        matic_burn_supply=MATIC_MAX_SALE_SUPPLY;
        for(uint256 index=0; index<_addr.length; index++){
            address payable toAddress = payable(_addr[index]);
            uint256 transferAmount = _amounts[index];
            totalsupply=totalsupply.add(transferAmount);
            require(totalsupply <=MATIC_MAX_SALE_SUPPLY,"Maximum sale amount reached");
            matic_supply=matic_supply.add(transferAmount);
            matic_sale_contributors.push(toAddress);
            matic_sale_balance_mapping[toAddress] = matic_sale_balance_mapping[toAddress].add(transferAmount);
            matic_burn_supply = matic_burn_supply.sub(transferAmount);
            
        }
    }
        
        function burn(address _to) public onlyOwner {
            
            _burn(_to,matic_burn_supply);
          
            
        }
        
        function startCycleMintToken() public {
            
                if(CheckStatus()){
                tokenmint=tokenmint.div(2);
                mint(msg.sender,tokenmint);
                cycleTokenMint=tokenmint;
                
                
            }
        }
        
        function CheckStatus() public returns (bool) {
        
        if((now >= launchtime + (monthIndex * 60 days)) && (monthIndex >=0 && monthIndex <= 22))
        {   
            
         monthIndex=monthIndex+2;
         return true;
        }
        else{
            return false;
        }
    }
 
}
