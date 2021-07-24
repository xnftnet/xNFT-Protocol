//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "./IERC721Full.sol";
import "../../base/ProtocolBase.sol";
import "../../access/MinterAccessControl.sol";

contract ERC721Full is
    ProtocolBase,
    ERC721Enumerable,
    ERC721URIStorage,
    Ownable,
    IERC721Full
{
    string private _baseTokenURI;

    constructor(
        string memory name,
        string memory symbol,
        string memory baseTokenURI
    ) ERC721(name, symbol) {
        _baseTokenURI = baseTokenURI;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function _mint(
        address to,
        uint256 tokenId,
        string memory _tokenURI
    ) internal {
        _mint(to, tokenId);

        if (bytes(_tokenURI).length > 0) {
            _setTokenURI(tokenId, _tokenURI);
        }
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function setBaseTokenURI(string memory baseTokenURI)
        public
        override
        onlyOwner
    {
        _baseTokenURI = baseTokenURI;
    }

    function setTokenURI(uint256 tokenId, string memory _tokenURI)
        public
        override
        onlyOwner
    {
        _setTokenURI(tokenId, _tokenURI);
    }

    function exist(uint256 tokenId) public view override returns (bool) {
        return _exists(tokenId);
    }
}
