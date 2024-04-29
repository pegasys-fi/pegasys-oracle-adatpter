# Pegasys Oracle Adapter

The Pegasys Oracle Adapter is a Solidity smart contract designed to convert price feed data from the SupraSValueFeed oracle into a format compatible with Chainlink oracle interfaces.

## Installation

Clone the repository and install its dependencies:

```bash
git clone https://github.com/pegasys-fi/pegasys-oracle-adatpter.git
cd pegasys-oracle-adatpter
yarn install
```

## Deployment

To deploy the Oracle adapters, you can use the provided script which automates the deployment of contracts for various predefined currency pairs:

```bash
npx hardhat run scripts/deployOracles.ts
```
