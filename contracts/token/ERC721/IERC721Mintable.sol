//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./IERC721Full.sol";

interface IERC721Mintable is IERC721Full {
    function mintTo(
        address to,
        uint256 tokenId,
        string memory _tokenURI
    ) external;

    function mint(uint256 tokenId, string memory _tokenURI) external;
}
