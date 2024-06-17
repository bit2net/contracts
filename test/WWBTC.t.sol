// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.19;

import {WWBTC} from "../src/WWBTC.sol";
import {Test} from "../lib/forge-std/src/Test.sol";

contract WWBTCTest is Test {
    address constant whale = 0x6daB3bCbFb336b29d06B9C793AEF7eaA57888922;
    WWBTC constant WBTC = WWBTC(0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599);
    WWBTC constant wwbtc = WWBTC(0x0000000000004250039d1Cf730bDD00b31942D18);

    function setUp() public payable {
        vm.createSelectFork(vm.rpcUrl("main")); // Ethereum mainnet fork.
    }

    function testDeploy() public payable {
        new WWBTC();
    }

    function testDeposit() public payable {
        vm.prank(whale);
        WBTC.approve(address(wwbtc), type(uint256).max);
        vm.prank(whale);
        wwbtc.deposit(999 ether / 10 ** 10);
    }

    function testWithdraw() public payable {
        testDeposit();
        vm.prank(whale);
        wwbtc.withdraw(999 ether);
        assertEq(0, wwbtc.balanceOf(whale));
    }
}
