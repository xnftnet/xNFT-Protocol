//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "./IERC1155Full.sol";
import "../../base/ProtocolBase.sol";

contract ERC1155FullAutoId is ProtocolBase, ERC1155, Ownable, IERC1155Full {
    using Counters for Counters.Counter;
    Counters.Counter private _idTracker;

    mapping(uint256 => address) _operators;

    constructor(
        string memory name,
        string memory symbol,
        string memory baseURI
    ) ERC1155(name, symbol, baseURI) {}

    /**
     * @dev Creates `amount` new tokens for `to`, of token type `id`.
     *
     * See {ERC1155-_mint}.
     *
     * Requirements:
     *
     * - the caller must have the `MINTER_ROLE`.
     */
    function _mint(
        address to,
        uint256 amount,
        string memory _uri
    ) internal virtual {
        _idTracker.increment();
        uint256 _id = _idTracker.current();
        _mint(to, _id, amount, "");
        _setURI(_id, _uri);
        _operators[_id] = to;
    }

    function setBaseURI(string calldata baseURI) public override onlyOwner {
        _setBaseURI(baseURI);
    }

    function setURI(uint256 id, string memory _uri) public override onlyOwner {
        _setURI(id, _uri);
    }

    function uri(uint256 id)
        public
        view
        override(ERC1155)
        returns (string memory)
    {
        return super.uri(id);
    }

    function exist(uint256 id) public view override returns (bool) {
        return _operators[id] != address(0);
    }
}
