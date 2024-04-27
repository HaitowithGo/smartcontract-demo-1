// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherWallet {
    address payable public owner;
    mapping(address => uint) public balances;

    event Deposit(address indexed sender, uint amount);
    event Withdrawal(address indexed recipient, uint amount);

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        owner.transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

    function getBalance(address account) external view returns (uint) {
        return balances[account];
    }
}
