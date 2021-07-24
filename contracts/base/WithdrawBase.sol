//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./IWithdrawBase.sol";

abstract contract WithdrawBase is IWithdrawBase {
    function withdraw(address to, uint256 value) public virtual override {
        require(
            to != address(0),
            "WithdrawERC20Base: to address cannot be zero address"
        );
        address _this = address(this);
        require(
            _this.balance >= value,
            "WithdrawBase: balance is insufficient"
        );
        payable(to).transfer(value);

        emit Withdraw(msg.sender, _this, to, value);
    }
}
