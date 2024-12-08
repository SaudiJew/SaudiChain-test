# SaudiChain Test Repository

A modified blockchain implementation based on Peercoin's proof-of-stake system.

## Project Structure

```
/
├── blockchain/           # Core blockchain implementation
│   ├── src/             # Source code
│   ├── MODIFICATIONS.md  # Changes from Peercoin
│   ├── TOKENOMICS.md    # Economic parameters
│   └── WALLETS.md       # Development fund wallets
│
├── wallet/              # Multi-platform wallet
│   └── SETUP.md         # Build instructions
│
└── tools/               # Development tools
    ├── address_generator.py  # Secure wallet generator
    └── README.md            # Tool documentation
```

## Key Features

1. Blockchain:
   - Pure Proof of Stake (no mining)
   - 5% annual staking reward
   - 100M maximum supply
   - 10-minute block time

2. Initial Distribution:
   - 5 development fund wallets
   - 20M coins per fund
   - 4-year vesting schedule

3. Development Tools:
   - Secure offline address generator
   - Multi-platform wallet support
   - Development documentation

## Setup Instructions

1. Blockchain Core:
   ```bash
   cd blockchain
   ./autogen.sh
   ./configure
   make
   ```

2. Wallet:
   ```bash
   cd wallet
   flutter pub get
   flutter run
   ```

3. Generate Development Addresses:
   ```bash
   cd tools
   python3 address_generator.py
   ```

## Development

- `main` branch: Stable releases
- `develop` branch: Active development
- Feature branches: Use `feature/*` naming

## Security

- All private keys must be generated offline
- Use multi-signature for development funds
- Follow security guidelines in tools/README.md

## Documentation

- [Modifications](blockchain/MODIFICATIONS.md)
- [Tokenomics](blockchain/TOKENOMICS.md)
- [Wallet Setup](wallet/SETUP.md)
- [Tools Guide](tools/README.md)
