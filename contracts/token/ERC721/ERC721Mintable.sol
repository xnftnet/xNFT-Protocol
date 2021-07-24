//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./ERC721Full.sol";
import "./IERC721Mintable.sol";
import "../../access/MinterAccessControl.sol";

contract ERC721Mintable is ERC721Full, MinterAccessControl, IERC721Mintable {
    constructor(
        string memory name,
        string memory symbol,
        string memory baseTokenURI
    ) ERC721Full(name, symbol, baseTokenURI) {
        _setupRole(MINTER_ROLE, _msgSender());
    }

    function mintTo(
        address to,
        uint256 tokenId,
        string memory _tokenURI
    ) public override isMinterOrOwner {
        _mint(to, tokenId, _tokenURI);
    }

    function mint(uint256 tokenId, string memory _tokenURI)
        public
        override
        isMinterOrOwner
    {
        _mint(_msgSender(), tokenId, _tokenURI);
    }
}
