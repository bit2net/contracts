// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.19;

import {Test} from "../lib/forge-std/src/Test.sol";
import {ZapETH_WWBTC} from "../src/ZapETH_WWBTC.sol";

contract ZapETH_WWBTCTest is Test {
    address constant whale = 0x6daB3bCbFb336b29d06B9C793AEF7eaA57888922;
    address constant WBTC = 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599;
    address constant wwbtc = 0x0000000000004250039d1Cf730bDD00b31942D18;

    ZapETH_WWBTC constant zapper = ZapETH_WWBTC(payable(0x000000000000EAD3660cac3d5bF1061F529523b1));

    function setUp() public payable {
        vm.createSelectFork(vm.rpcUrl("main")); // Ethereum mainnet fork.
    }

    function testZap() public payable {
        vm.prank(whale);
        zapper.zap{value: 0.05 ether}();
    }
}
