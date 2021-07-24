//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "../../base/IProtocolBase.sol";

interface IERC1155Mintable is IProtocolBase {
    function mintTo(
        address to,
        uint256 id,
        uint256 amount,
        string calldata _uri
    ) external;

    function mint(
        uint256 id,
        uint256 amount,
        string calldata _uri
    ) external;
}
