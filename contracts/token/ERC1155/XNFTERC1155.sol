//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./ERC1155FullAutoId.sol";
import "./IXNFTERC1155.sol";

contract XNFTERC1155 is ERC1155FullAutoId, IXNFTERC1155 {
    constructor(string memory name, string memory symbol)
        ERC1155FullAutoId(name, symbol, "ipfs://")
    {}

    function mint(uint256 amount, string memory _uri) public override {
        _mint(_msgSender(), amount, _uri);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        return super.uri(tokenId);
    }
}
