//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;
import "../access/OperatorAccessControl.sol";
import "@openzeppelin/contracts/utils/Address.sol";

interface IERC721 {
    function mintTo(
        address to,
        uint256 tokenId,
        string calldata _tokenURI
    ) external;
}

interface IERC1155 {
    function mintTo(
        address to,
        uint256 id,
        uint256 amount,
        string calldata _uri
    ) external;
}

contract NFTFactory is OperatorAccessControl {
    using Address for address;

    function batchMintERC721To(
        address erc721Address,
        address[] memory tos,
        uint256[] memory tokenIds,
        string[] memory _tokenURIs
    ) public isOperatorOrOwner {
        require(
            erc721Address.isContract(),
            "NFTFactory: batchMintERC721To erc721Address must be contract address"
        );
        require(
            tos.length == tokenIds.length,
            "NFTFactory: batchMintERC721To tos length does not match tokenIds length"
        );
        require(
            tos.length == _tokenURIs.length,
            "NFTFactory: batchMintERC721To tos length does not match _tokenURIs length"
        );
        IERC721 erc721 = IERC721(erc721Address);

        for (uint256 _i; _i < tos.length; _i++) {
            erc721.mintTo(tos[_i], tokenIds[_i], _tokenURIs[_i]);
        }
    }

    function batchMintERC1155To(
        address erc1155Address,
        address[] memory tos,
        uint256[] memory ids,
        uint256[] memory amounts,
        string[] memory _uris
    ) public isOperatorOrOwner {
        require(
            erc1155Address.isContract(),
            "NFTFactory: batchMintERC1155To erc1155Address must be contract address"
        );
        require(
            tos.length == ids.length,
            "NFTFactory: batchMintERC1155To tos length does not match ids length"
        );
        require(
            tos.length == amounts.length,
            "NFTFactory: batchMintERC1155To tos length does not match amounts length"
        );
        require(
            tos.length == _uris.length,
            "NFTFactory: batchMintERC1155To tos length does not match _uris length"
        );
        IERC1155 erc1155 = IERC1155(erc1155Address);

        for (uint256 _i; _i < tos.length; _i++) {
            erc1155.mintTo(tos[_i], ids[_i], amounts[_i], _uris[_i]);
        }
    }
}
