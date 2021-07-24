//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./ERC721FullAutoId.sol";
import "./IXNFTERC721.sol";

contract XNFTERC721 is ERC721FullAutoId, IXNFTERC721 {
    constructor(string memory name, string memory symbol)
        ERC721FullAutoId(name, symbol, "ipfs://")
    {}

    function mint(string memory _tokenURI) public override {
        _mint(_msgSender(), _tokenURI);
    }
}
