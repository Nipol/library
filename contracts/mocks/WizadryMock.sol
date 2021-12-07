/**
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

pragma solidity ^0.8.0;

import "../library/Wizadry.sol";

contract WizadryMock is Wizadry {
    function cast(bytes32[] memory spells, bytes[] memory elements) external {
        _cast(spells, elements);
    }
}
