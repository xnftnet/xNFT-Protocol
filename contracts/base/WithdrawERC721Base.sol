//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "./IWithdrawERC721Base.sol";

abstract contract WithdrawERC721Base is IWithdrawERC721Base {
    function withdrawERC721(
        address erc721Address,
        address to,
        uint256 tokenId
    ) public virtual override {
        require(
            erc721Address != address(0),
            "WithdrawERC721Base: erc721 address cannot be zero address"
        );
        require(
            to != address(0),
            "WithdrawERC721Base: to address cannot be zero address"
        );
        IERC721 _erc721 = IERC721(erc721Address);
        address _this = address(this);
        require(
            _erc721.ownerOf(tokenId) == _this,
            "WithdrawERC721Base: _this address is the owner of tokenId"
        );
        _erc721.transferFrom(_this, to, tokenId);

        emit WithdrawERC721(msg.sender, _this, to, erc721Address, tokenId);
    }
}
