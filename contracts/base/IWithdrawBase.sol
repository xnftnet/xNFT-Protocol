//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

interface IWithdrawBase {
    event Withdraw(
        address indexed operator,
        address indexed from,
        address indexed to,
        uint256 value
    );

    function withdraw(address to, uint256 value) external;
}
