# Ezeking Token (EZK)

A customised ERC-20 token built with [Foundry](https://book.getfoundry.sh/) and
[OpenZeppelin Contracts v5](https://github.com/OpenZeppelin/openzeppelin-contracts),
tested locally and deployed to the Sepolia Ethereum testnet. Sample/tutorial project.

## Submission

[Google Doc with repository link, build/test/deployment screenshots and transaction hash](https://docs.google.com/document/d/1bPbW-k0YhQ3hQ7rBTbkeZ5gNfLfzpCnT8ojI-H_UwI4/edit?usp=sharing)

## Token

| Property       | Value                                   |
| -------------- | --------------------------------------- |
| Name           | Ezeking Token                           |
| Symbol         | EZK                                     |
| Decimals       | 18                                      |
| Initial supply | 1,000,000 EZK (minted to the deployer)  |

## Features

- ERC-20 standard
- Burnable: any holder can burn their own tokens
- Mintable: owner only
- Pausable: owner can pause and unpause all transfers
- Ownable access control

## Layout

```
src/EzekingToken.sol              the token contract
test/EzekingToken.t.sol           12 tests (incl. a fuzz test), 100% coverage
script/DeployEzekingToken.s.sol   deployment script
```

## Usage

```bash
forge install          # fetch forge-std and OpenZeppelin (git submodules)
forge build            # compile
forge test -vv         # run tests
forge coverage         # coverage report
```

## Deploy to Sepolia

Create a git-ignored `.env` file with a Sepolia RPC endpoint and a throwaway
wallet that only holds Sepolia test ETH. Never commit it.

```
SEPOLIA_RPC_URL=https://sepolia.infura.io/v3/<your-project-id>
PRIVATE_KEY=0x<your-test-wallet-private-key>
```

```bash
source .env
forge script script/DeployEzekingToken.s.sol \
  --rpc-url $SEPOLIA_RPC_URL --broadcast --private-key $PRIVATE_KEY \
  --gas-estimate-multiplier 800
```

> **Gas note:** Sepolia currently charges far more gas for contract creation than
> forge's local simulation predicts (the node estimates ~5.0M gas for this contract;
> the local estimate is ~0.8M). Without the multiplier the transaction runs out of
> gas at the code-deposit step and fails. Unused gas is refunded, and the total
> cost is a tiny fraction of a cent of test ETH.

The transaction details are written to `broadcast/DeployEzekingToken.s.sol/11155111/run-latest.json`.

## Deployment (Sepolia)

| Item             | Value |
| ---------------- | ----- |
| Network          | Sepolia (chain ID 11155111) |
| Contract address | [`0x26E4f4C9289d90face214A68279015217E0e4829`](https://sepolia.etherscan.io/address/0x26E4f4C9289d90face214A68279015217E0e4829) |
| Transaction hash | [`0x39598246a28b6d39df8bb0d8778d29c9a5a7e17deabd6b2e1ee1be881cc30b74`](https://sepolia.etherscan.io/tx/0x39598246a28b6d39df8bb0d8778d29c9a5a7e17deabd6b2e1ee1be881cc30b74) |
| Block            | 11922490 |
| Deployer / owner | `0x194a5eDfF78ab1D2bc57DC5F842C2F6433818807` |

## Tech

Solidity 0.8.28, Foundry, OpenZeppelin Contracts v5.4.0.
