//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";

import "./IMinterAccessControl.sol";

contract MinterAccessControl is IMinterAccessControl, Ownable {
    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }

    mapping(bytes32 => RoleData) private _roles;

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    function hasRole(bytes32 role, address account)
        public
        view
        override
        returns (bool)
    {
        return _roles[role].members[account];
    }

    function _grantRole(bytes32 role, address account) private {
        if (!hasRole(role, account)) {
            _roles[role].members[account] = true;
            emit RoleGranted(role, account, _msgSender());
        }
    }

    function _setupRole(bytes32 role, address account) internal virtual {
        _grantRole(role, account);
    }

    function _revokeRole(bytes32 role, address account) private {
        if (hasRole(role, account)) {
            _roles[role].members[account] = false;
            emit RoleRevoked(role, account, _msgSender());
        }
    }

    modifier isMinterOrOwner() {
        address _sender = _msgSender();
        require(
            isMinter(_sender) || owner() == _sender,
            "MinterAccessControl: caller is not minter or owner"
        );
        _;
    }

    modifier onlyMinter() {
        require(
            isMinter(_msgSender()),
            "MinterAccessControl: caller is not minter"
        );
        _;
    }

    function isMinter(address account) public view override returns (bool) {
        return hasRole(MINTER_ROLE, account);
    }

    function addMinter(address account) public override onlyOwner {
        _grantRole(MINTER_ROLE, account);
    }

    function revokeMinter(address account) public override onlyOwner {
        _revokeRole(MINTER_ROLE, account);
    }
}
