# ---nUSD--Stablecoin


 the nUSD contract is a basic ERC20 token with additional functionality for depositing ETH and redeeming nUSD for ETH.


 Key Features:

deposit(): Users can deposit ETH by calling this function and sending ETH to the contract. The function calculates the corresponding nUSD amount using the calculateNUSD() internal function. The deposited ETH is added to the user's redeemableETH balance, and the equivalent nUSD is minted and added to the user's balance and the total supply. The ETH amount is also added to the ethReserve.

redeem(): Users can redeem their nUSD by calling this function and providing the desired nUSD amount. The function checks if the user has sufficient nUSD balance and calculates the corresponding ETH amount using the calculateETH() internal function. The nUSD amount is subtracted from the user's balance and the total supply, and the ETH amount is subtracted from the user's redeemableETH balance and the ethReserve. The ETH is then transferred back to the user.

calculateNUSD(): This internal function calculates the nUSD amount based on the supplied ETH amount. It returns 50% (half) of the deposited ETH.

calculateETH(): This internal function calculates the ETH amount based on the supplied nUSD amount. It converts nUSD back to ETH at a 1:2 ratio.
