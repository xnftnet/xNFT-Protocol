//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "../../base/IProtocolBase.sol";

interface IERC1155Full is IProtocolBase {
    function setBaseURI(string calldata baseURI) external;

    function setURI(uint256 id, string memory _uri) external;

    function exist(uint256 id) external view returns (bool);
}
