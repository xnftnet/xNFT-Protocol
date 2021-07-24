//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./IERC721Full.sol";

interface IERC721MintableAutoId is IERC721Full {
    function mintTo(address to, string memory _tokenURI) external;

    function mint(string memory _tokenURI) external;
}
