# bit2 (🟠, ❷)

## Deployments

### Ethereum

`WWBTC`: [`0x0000000000004250039d1Cf730bDD00b31942D18`](https://etherscan.io/address/0x0000000000004250039d1cf730bdd00b31942d18#code)
> 18 decimal [WBTC](0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599) wrapper

`ZapETH_WWBTC`: [`0x000000000000EAD3660cac3d5bF1061F529523b1`](https://etherscan.io/address/0x000000000000ead3660cac3d5bf1061f529523b1#code)
> ETH -> WETH -> WBTC -> WWBTC via UniswapV3

`HypERC20Collateral`: [`0x8c95540FB7eeBa511a3dceAF405329f87B6d22FA`](https://etherscan.io/address/0x8c95540FB7eeBa511a3dceAF405329f87B6d22FA#code)
> WWBTC -> Sepolia (Bridge Router)

### Sepolia

`WWBTCS`: [`0x1B1aA1de252145A6a73A5E73cDa64c34260891Eb`](https://sepolia.etherscan.io/address/0x1b1aa1de252145a6a73a5e73cda64c34260891eb#code)
> WWBTC Synth/Sepolia (Bridge Router)

## Getting Started

Run: `curl -L https://foundry.paradigm.xyz | bash && source ~/.bashrc && foundryup`

Build the foundry project with `forge build`. Run tests with `forge test`. Measure gas with `forge snapshot`. Format with `forge fmt`.

## Disclaimer

*These smart contracts and testing suite are being provided as is. No guarantee, representation or warranty is being made, express or implied, as to the safety or correctness of anything provided herein or through related user interfaces. This repository and related code have not been audited and as such there can be no assurance anything will work as intended, and users may experience delays, failures, errors, omissions, loss of transmitted information or loss of funds. The creators are not liable for any of the foregoing. Users should proceed with caution and use at their own risk.*

## License

See [LICENSE](./LICENSE) for more details.
