// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.19;

import "@solady/src/tokens/ERC20.sol";

contract WWBTC is ERC20 {
    ERC20 constant WBTC = ERC20(0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599);

    uint256 constant DECIMALS_DIFFERENCE = 10 ** 10;

    function name() public view virtual override returns (string memory) {
        return "WWBTC";
    }

    function symbol() public view virtual override returns (string memory) {
        return "WWBTC";
    }

    function deposit(uint256 amount) public {
        WBTC.transferFrom(msg.sender, address(this), amount);
        _mint(msg.sender, amount * DECIMALS_DIFFERENCE);
    }

    function withdraw(uint256 amount) public {
        _burn(msg.sender, amount);
        WBTC.transfer(msg.sender, amount / DECIMALS_DIFFERENCE);
    }
}
