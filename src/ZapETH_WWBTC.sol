// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.19;

/// @title ZapETH WWBTC
/// @author bit2.network
/// @dev Zap ETH to WWBTC
contract ZapETH_WWBTC {
    /// ========================= CONSTANTS ========================= ///

    /// @dev The canonical wrapped ETH address on Ethereum.
    address internal constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    /// @dev The popular wrapped BTC address.
    address internal constant WBTC = 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599;

    /// @dev The wrapper for WBTC on Ethereum.
    address internal constant WWBTC = 0x0000000000004250039d1Cf730bDD00b31942D18;

    /// @dev The chosen Uniswap V3 liquidity pool (500 fee).
    address internal constant POOL = 0x4585FE77225b41b697C938B018E2Ac67Ac5a20c0;

    /// @dev The address of the Uniswap V3 Factory.
    address internal constant UNISWAP_V3_FACTORY = 0x1F98431c8aD98523631AE4a59f267346ea31F984;

    /// @dev The maximum value that can be returned from `getSqrtRatioAtTick` (minus one).
    uint160 internal constant MAX_SQRT_RATIO_MINUS_ONE =
        1461446703485210103287273052203988822378723970341;

    /// @dev The Uniswap V3 Pool `initcodehash`.
    bytes32 internal constant UNISWAP_V3_POOL_INIT_CODE_HASH =
        0xe34f199b19b2b4f47f68442619d555527d244f78a3297ea89325f843f87b8b54;

    /// @dev The decimal conversion factor for WBTC.
    uint256 constant DECIMALS_DIFFERENCE = 10 ** 10;

    /// ===================== SWAP EXECUTION ===================== ///

    /// @dev Initialize.
    constructor() payable {
        IWWBTC(WBTC).approve(WWBTC, type(uint256).max);
    }

    /// @dev ETH->WETH->WBTC->WWBTC.
    function zap() public payable {
        (int256 amount0,) = ISwapRouter(POOL).swap(
            address(this), false, int256(msg.value), MAX_SQRT_RATIO_MINUS_ONE, ""
        );
        uint256 output = uint256(-(amount0));
        IWWBTC(WWBTC).deposit(output);
        assembly ("memory-safe") {
            mstore(0x14, caller())
            mstore(0x34, mul(output, DECIMALS_DIFFERENCE))
            mstore(0x00, 0xa9059cbb000000000000000000000000)
            pop(call(gas(), WWBTC, 0, 0x10, 0x44, codesize(), 0x00))
            mstore(0x34, 0)
        }
    }

    /// @dev ETH->WETH->WBTC->WWBTC for `to`.
    function zapTo(address to) public payable {
        (int256 amount0,) = ISwapRouter(POOL).swap(
            address(this), false, int256(msg.value), MAX_SQRT_RATIO_MINUS_ONE, ""
        );
        uint256 output = uint256(-(amount0));
        IWWBTC(WWBTC).deposit(output);
        assembly ("memory-safe") {
            mstore(0x14, to)
            mstore(0x34, mul(output, DECIMALS_DIFFERENCE))
            mstore(0x00, 0xa9059cbb000000000000000000000000)
            pop(call(gas(), WWBTC, 0, 0x10, 0x44, codesize(), 0x00))
            mstore(0x34, 0)
        }
    }

    /// @dev `uniswapV3SwapCallback`.
    fallback() external payable {
        assembly ("memory-safe") {
            let amount1Delta := calldataload(0x24)
            if iszero(eq(caller(), POOL)) { revert(codesize(), 0x00) }
            pop(call(gas(), WETH, amount1Delta, codesize(), 0x00, codesize(), 0x00))
            mstore(0x14, caller())
            mstore(0x34, amount1Delta)
            mstore(0x00, 0xa9059cbb000000000000000000000000)
            pop(call(gas(), WETH, 0, 0x10, 0x44, codesize(), 0x00))
            mstore(0x34, 0)
        }
    }

    /// @dev Zaps any ether sent.
    receive() external payable {
        zap();
    }
}

/// @dev Simple Uniswap V3 swapping interface.
interface ISwapRouter {
    function swap(address, bool, int256, uint160, bytes calldata)
        external
        returns (int256, int256);
}

/// @dev Simple WWBTC deposit interface.
interface IWWBTC {
    function deposit(uint256) external;
    function approve(address, uint256) external returns (bool);
}
