/**
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

pragma solidity ^0.8.0;

contract DummyTemplate {
    string public name = "bean the DAO on the Blocks";

    function initialize(string memory _name) external returns (bool) {
        name = _name;
        return true;
    }
}
