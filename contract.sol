//contract is a basic ERC20 token with additional functionality for depositing ETH and redeeming nUSD for ETH.



// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract nUSD {
    string public name = "nUSD";
    string public symbol = "nUSD";
    uint8 public decimals = 18;

    mapping(address => uint256) public balances;
    mapping(address => uint256) public redeemableETH;
    uint256 public totalSupply;
    uint256 private ethReserve; // Total ETH held as reserves

    event Deposit(address indexed account, uint256 ethAmount, uint256 nusdAmount);
    event Redeem(address indexed account, uint256 nusdAmount, uint256 ethAmount);

    receive() external payable {
        deposit();
    }

    function deposit() public payable {
        require(msg.value > 0, "ETH amount must be greater than 0");

        uint256 ethAmount = msg.value;
        uint256 nusdAmount = calculateNUSD(ethAmount);

        balances[msg.sender] += nusdAmount;
        redeemableETH[msg.sender] += ethAmount;
        totalSupply += nusdAmount;
        ethReserve += ethAmount;

        emit Deposit(msg.sender, ethAmount, nusdAmount);
    }

    function redeem(uint256 nusdAmount) public {
        require(nusdAmount > 0, "nUSD amount must be greater than 0");
        require(balances[msg.sender] >= nusdAmount, "Insufficient nUSD balance");

        uint256 ethAmount = calculateETH(nusdAmount);

        balances[msg.sender] -= nusdAmount;
        redeemableETH[msg.sender] -= ethAmount;
        totalSupply -= nusdAmount;
        ethReserve -= ethAmount;
        payable(msg.sender).transfer(ethAmount);

        emit Redeem(msg.sender, nusdAmount, ethAmount);
    }

    function calculateNUSD(uint256 ethAmount) internal pure returns (uint256) {
        return (ethAmount * 50) / 100; // 50% of the deposited ETH
    }

    function calculateETH(uint256 nusdAmount) internal pure returns (uint256) {
        return (nusdAmount * 200) / 100; // Convert nUSD back to ETH at a 1:2 ratio
    }
}
