//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./IERC1155Full.sol";

interface IXNFTERC1155 is IERC1155Full {
    function mint(uint256 amount, string memory _uri) external;

    function tokenURI(uint256 tokenId) external view returns (string memory);
}
