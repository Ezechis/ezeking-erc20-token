# Ezeking Token (EZK)

A customised ERC-20 token built with [Foundry](https://book.getfoundry.sh/) and
[OpenZeppelin Contracts v5](https://github.com/OpenZeppelin/openzeppelin-contracts),
tested locally and deployed to the Sepolia Ethereum testnet. Sample/tutorial project.

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
  --rpc-url $SEPOLIA_RPC_URL --broadcast --private-key $PRIVATE_KEY
```

The transaction details are written to `broadcast/DeployEzekingToken.s.sol/11155111/run-latest.json`.

## Deployment

Pending: this section is filled in after the Sepolia deployment.

## Tech

Solidity 0.8.28, Foundry, OpenZeppelin Contracts v5.4.0.
