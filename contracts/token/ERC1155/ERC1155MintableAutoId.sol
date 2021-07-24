//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "./IERC1155MintableAutoId.sol";
import "./ERC1155FullAutoId.sol";
import "../../access/MinterAccessControl.sol";

contract ERC1155MintableAutoId is
    ERC1155FullAutoId,
    MinterAccessControl,
    IERC1155MintableAutoId
{
    constructor(
        string memory name,
        string memory symbol,
        string memory baseURI
    ) ERC1155FullAutoId(name, symbol, baseURI) {
        _setupRole(MINTER_ROLE, _msgSender());
    }

    /**
     * @dev Creates `amount` new tokens for `to`, of token type `id`.
     *
     * See {ERC1155-_mint}.
     *
     * Requirements:
     *
     * - the caller must have the `MINTER_ROLE`.
     */
    function mintTo(
        address to,
        uint256 amount,
        string memory _uri
    ) public virtual override isMinterOrOwner {
        _mint(to, amount, _uri);
    }

    /**
     * @dev Creates `amount` new tokens for `to`, of token type `id`.
     *
     * See {ERC1155-_mint}.
     *
     * Requirements:
     *
     * - the caller must have the `MINTER_ROLE`.
     */
    function mint(uint256 amount, string memory _uri)
        public
        virtual
        override
        isMinterOrOwner
    {
        _mint(_msgSender(), amount, _uri);
    }
}
