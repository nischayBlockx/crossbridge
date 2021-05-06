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

**Referances**

https://www.binance.org/en/blog/open-source-ethereum-and-binance-smart-chain-bi-directional-bridge-solution/

https://github.com/jklepatch/eattheblocks/tree/master/screencast/314-eth-bsc-bridge/contracts

https://docs.matic.network/docs/develop/ethereum-matic/pos/getting-started

https://github.com/maticnetwork/pos-portal/tree/master/contracts

https://www.youtube.com/watch?v=LFoTlG-4TmU&ab_channel=EatTheBlocks

https://www.xdaichain.com/for-users/bridges/omnibridge

https://github.com/terra-project/shuttle/tree/main/contracts/contracts

https://github.com/binance-chain/eth-bsc-swap-contracts/tree/master/contracts

https://github.com/JustLiquidity/tokenbridge-erc20-bep20/tree/master/contracts

https://www.xdaichain.com/for-users/bridges/xdai-matic-connext-bridge

https://github.com/QuickSwap/quickswap-core
