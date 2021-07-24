//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

interface IWithdrawERC1155Base {
    event WithdrawERC1155(
        address indexed operator,
        address indexed from,
        address indexed to,
        address erc1155Address,
        uint256 id,
        uint256 value
    );

    function withdrawERC1155(
        address erc1155Address,
        address to,
        uint256 id,
        uint256 amount
    ) external;
}
