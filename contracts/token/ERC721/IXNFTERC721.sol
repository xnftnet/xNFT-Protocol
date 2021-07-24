//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./IERC721Full.sol";

interface IXNFTERC721 is IERC721Full {
    function mint(string calldata _tokenURI) external;
}
