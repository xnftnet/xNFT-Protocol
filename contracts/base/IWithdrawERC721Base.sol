//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

interface IWithdrawERC721Base {
    event WithdrawERC721(
        address indexed operator,
        address indexed from,
        address indexed to,
        address erc721Address,
        uint256 id
    );

    function withdrawERC721(
        address erc721Address,
        address to,
        uint256 tokenId
    ) external;
}
