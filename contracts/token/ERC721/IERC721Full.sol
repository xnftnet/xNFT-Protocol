//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "../../base/IProtocolBase.sol";

interface IERC721Full is IProtocolBase {
    function setBaseTokenURI(string calldata baseTokenURI) external;

    function setTokenURI(uint256 tokenId, string calldata _tokenURI) external;

    function exist(uint256 tokenId) external view returns (bool);
}
