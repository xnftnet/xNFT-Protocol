//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

interface IWithdrawERC20Base {
    event WithdrawERC20(
        address indexed operator,
        address indexed from,
        address indexed to,
        address erc20Address,
        uint256 value
    );

    function withdrawERC20(
        address erc20Address,
        address to,
        uint256 value
    ) external;
}
