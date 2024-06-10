// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.19;

import {WWBTC} from "../src/WWBTC.sol";
import {Test} from "../lib/forge-std/src/Test.sol";

contract WWBTCTest is Test {
    WWBTC internal wwbtc;

    uint256 constant z0r0zBalanceWBTC = 63567;
    uint256 constant z0r0zBalanceWWBTC = 635670000000000;
    address constant z0r0z = 0x1C0Aa8cCD568d90d61659F060D1bFb1e6f855A20;

    WWBTC constant WBTC = WWBTC(0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599);

    function setUp() public payable {
        vm.createSelectFork(vm.rpcUrl("main")); // Ethereum mainnet fork.
        wwbtc = new WWBTC();
    }

    function testDeploy() public payable {
        new WWBTC();
    }

    function testDeposit() public payable {
        vm.prank(z0r0z);
        WBTC.approve(address(wwbtc), z0r0zBalanceWBTC);
        vm.prank(z0r0z);
        wwbtc.deposit(z0r0zBalanceWBTC);
        assertEq(z0r0zBalanceWWBTC, wwbtc.balanceOf(z0r0z));
    }

    function testWithdraw() public payable {
        testDeposit();
        vm.prank(z0r0z);
        wwbtc.withdraw(z0r0zBalanceWWBTC);
        assertEq(0, wwbtc.balanceOf(z0r0z));
        assertEq(z0r0zBalanceWBTC, WBTC.balanceOf(z0r0z));
    }
}
