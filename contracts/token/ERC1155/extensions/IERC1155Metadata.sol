// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @title ERC-1155 Non-Fungible Token Standard, optional metadata extension
 */
interface IERC1155Metadata {
    /**
     * @dev Returns the token collection name.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the token collection symbol.
     */
    function symbol() external view returns (string memory);
}
