//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "./IWithdrawERC1155Base.sol";

abstract contract WithdrawERC1155Base is IWithdrawERC1155Base, ERC165,
    IERC1155Receiver {
    function withdrawERC1155(
        address erc1155Address,
        address to,
        uint256 id,
        uint256 amount
    ) public virtual override {
        require(
            erc1155Address != address(0),
            "WithdrawERC1155Base: erc1155 address cannot be zero address"
        );
        require(
            to != address(0),
            "WithdrawERC1155Base: to address cannot be zero address"
        );
        IERC1155 _erc1155 = IERC1155(erc1155Address);
        address _this = address(this);
        require(
            _erc1155.balanceOf(_this, id) >= amount,
            "WithdrawERC1155Base: erc1155 balance is insufficient"
        );
        _erc1155.safeTransferFrom(_this, to, id, amount, "");

        emit WithdrawERC1155(msg.sender, _this, to, erc1155Address, id, amount);
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC165, IERC165)
        returns (bool)
    {
        return
            interfaceId == type(IERC1155Receiver).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    function onERC1155Received(
        address,
        address,
        uint256,
        uint256,
        bytes memory
    ) public view override returns (bytes4) {
        return IERC1155Receiver(this).onERC1155Received.selector;
    }

    function onERC1155BatchReceived(
        address,
        address,
        uint256[] memory,
        uint256[] memory,
        bytes memory
    ) public view override returns (bytes4) {
        return IERC1155Receiver(this).onERC1155BatchReceived.selector;
    }
}
