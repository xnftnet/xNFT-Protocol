//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "./IWithdrawERC20Base.sol";

abstract contract WithdrawERC20Base is IWithdrawERC20Base {
    using SafeERC20 for IERC20;

    function withdrawERC20(
        address erc20Address,
        address to,
        uint256 value
    ) public virtual override {
        require(
            erc20Address != address(0),
            "WithdrawERC20Base: erc20 address cannot be zero address"
        );
        require(
            to != address(0),
            "WithdrawERC20Base: to address cannot be zero address"
        );
        IERC20 _erc20 = IERC20(erc20Address);
        address _this = address(this);
        require(
            _erc20.balanceOf(_this) >= value,
            "WithdrawERC20Base: erc20 balance is insufficient"
        );
        _erc20.safeTransfer(to, value);

        emit WithdrawERC20(msg.sender, _this, to, erc20Address, value);
    }
}
