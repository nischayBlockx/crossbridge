# crossbridge
Cross Token Bridge


**Deployment**

1. First we have to Deploy MaticToken.sol to Matic Network.
2. Deploy BEP20 to Binance Network.
3. Deploy SwapM2B on Matic Network.
4. Deploy SwapB2M on Binance Network.

**After Deployment**

_**For Matic to BSC**_
1. Admin set "Swapfee" from both SwapM2B and SwapB2M.
2. User call "RegisterSwapPairToken" from SwapM2B.
3. User can Check their token is it registered or not by calling "RegisteredMaticTokens"
4. After Registering Token User call "swapMatic2Bsc" for swapping
5. Admin call "fillB2MSwap" to mint BEp20 tokens.

_**For Bsc to Matic**_

same as for Matic to BSC, while transferring Matic to Bsc we dont need to register pair. User only need to  call "SwapBSCtoMatic" fro swapping


**Explaination** 

In this Contract we just locking the Matic tokens by transferrig Tokens to Admin address to User Address and minting BEP20 tokens to users address during MATIC TO BSC.
while in BSC TO MATIC , we just burning the the BEP20 Tokens from Users address and unlock the Matic Tokens.

