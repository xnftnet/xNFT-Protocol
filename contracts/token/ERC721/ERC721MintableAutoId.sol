//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./ERC721FullAutoId.sol";
import "./IERC721MintableAutoId.sol";
import "../../access/MinterAccessControl.sol";

contract ERC721MintableAutoId is
    ERC721FullAutoId,
    MinterAccessControl,
    IERC721MintableAutoId
{
    constructor(
        string memory name,
        string memory symbol,
        string memory baseTokenURI
    ) ERC721FullAutoId(name, symbol, baseTokenURI) {
        _setupRole(MINTER_ROLE, _msgSender());
    }

    function mintTo(address to, string memory _tokenURI)
        public
        override
        isMinterOrOwner
    {
        _mint(to, _tokenURI);
    }

    function mint(string memory _tokenURI) public override isMinterOrOwner {
        _mint(_msgSender(), _tokenURI);
    }
}
