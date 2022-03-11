// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import {IMulticall, Multicall} from "../library/Multicall.sol";

interface CheatCodes {
    function prank(address) external;

    function expectRevert(bytes calldata) external;
}

contract MulticallTest is Multicall, DSTest {
    CheatCodes cheats = CheatCodes(HEVM_ADDRESS);
    uint256 public counter;

    function setUp() public {
        counter = 0;
    }

    function increase() public {
        counter++;
    }

    function decrease() public {
        counter--;
    }

    function revertCall() public {
        revert("Message From Revert");
    }

    function emptyRevertCall() public {
        revert();
    }

    function test3TimesCall() public {
        bytes memory cd = abi.encodeWithSelector(bytes4(keccak256("increase()")));
        bytes[] memory cds = new bytes[](3);

        (cds[0], cds[1], cds[2]) = (cd, cd, cd);
        IMulticall(address(this)).multicall(cds);

        assertEq(counter, 3);
    }

    function test6TimesCall() public {
        bytes memory cd = abi.encodeWithSelector(bytes4(keccak256("increase()")));
        bytes[] memory cds = new bytes[](6);

        (cds[0], cds[1], cds[2], cds[3], cds[4], cds[5]) = (cd, cd, cd, cd, cd, cd);

        IMulticall(address(this)).multicall(cds);

        assertEq(counter, 6);
    }

    function testFailRevertCaseCall() public {
        bytes memory cd = abi.encodeWithSelector(bytes4(keccak256("decrease()")));
        bytes[] memory cds = new bytes[](1);
        (cds[0]) = (cd);

        IMulticall(address(this)).multicall(cds);
    }

    function testRevertMessageCaseCall() public {
        bytes memory cd = abi.encodeWithSelector(bytes4(keccak256("revertCall()")));
        bytes[] memory cds = new bytes[](1);

        (cds[0]) = (cd);

        cheats.expectRevert(bytes("Message From Revert"));
        IMulticall(address(this)).multicall(cds);
    }

    function testEmptyRevertMessageCaseCall() public {
        bytes memory cd = abi.encodeWithSelector(bytes4(keccak256("emptyRevertCall()")));
        bytes[] memory cds = new bytes[](1);

        (cds[0]) = (cd);

        cheats.expectRevert(bytes(""));
        IMulticall(address(this)).multicall(cds);
    }
}
