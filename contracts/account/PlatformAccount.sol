//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "../base/WithdrawBase.sol";
import "../base/WithdrawERC20Base.sol";
import "../base/WithdrawERC721Base.sol";
import "../base/WithdrawERC1155Base.sol";

contract PlatformAccount is
    Ownable,
    WithdrawBase,
    WithdrawERC20Base,
    WithdrawERC721Base,
    WithdrawERC1155Base
{
    // fallback
    fallback() external payable {}

    // receive
    receive() external payable {}

    function withdraw(address to, uint256 value) public override onlyOwner {
        super.withdraw(to, value);
    }

    function withdrawERC20(
        address erc20Address,
        address to,
        uint256 value
    ) public override onlyOwner {
        super.withdrawERC20(erc20Address, to, value);
    }

    function withdrawERC721(
        address erc721Address,
        address to,
        uint256 tokenId
    ) public override onlyOwner {
        super.withdrawERC721(erc721Address, to, tokenId);
    }

    function withdrawERC1155(
        address erc1155Address,
        address to,
        uint256 id,
        uint256 amount
    ) public override onlyOwner {
        super.withdrawERC1155(erc1155Address, to, id, amount);
    }
}
