//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./IProtocolBase.sol";

contract ProtocolBase is IProtocolBase {
    string private _protocol = "xNFT";

    function protocol() public view override returns (string memory) {
        return _protocol;
    }
}
