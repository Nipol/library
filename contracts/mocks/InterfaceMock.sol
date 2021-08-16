/**
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */
pragma solidity ^0.8.0;

import "../interfaces/IERC165.sol";
import "../interfaces/IERC173.sol";

contract InterfaceMock is IERC165, IERC173 {
    function owner() external view override returns (address) {
        return address(0);
    }

    function transferOwnership(address newOwner) external override {
        uint256 asdf = 100 + 1;
    }

    function supportsInterface(bytes4 interfaceID) external view override returns (bool) {
        return interfaceID == type(IERC173).interfaceId || interfaceID == type(IERC165).interfaceId;
    }
}
