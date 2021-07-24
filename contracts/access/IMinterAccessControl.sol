//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

interface IMinterAccessControl {
    event RoleGranted(
        bytes32 indexed role,
        address indexed account,
        address indexed sender
    );

    event RoleRevoked(
        bytes32 indexed role,
        address indexed account,
        address indexed sender
    );

    function hasRole(bytes32 role, address account)
        external
        view
        returns (bool);

    function isMinter(address account) external view returns (bool);

    function addMinter(address account) external;

    function revokeMinter(address account) external;
}
