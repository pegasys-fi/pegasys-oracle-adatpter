# Pegasys Oracle Adapter

The Pegasys Oracle Adapter is a Solidity smart contract designed to convert price feed data from the SupraSValueFeed oracle into a format compatible with Chainlink oracle interfaces.

## Installation

Clone the repository and install its dependencies:

```bash
git clone https://yourrepositoryurl.git
cd path-to-your-project
yarn install
```

## Deployment

To deploy the oracle adapters, you can use the provided script which automates the deployment of contracts for various predefined currency pairs:

```bash
npx hardhat run scripts/deploy.js
```
