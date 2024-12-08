# SaudiChain Modifications

## Changes from Peercoin

1. Genesis Block
   - New timestamp and message
   - Fresh mining parameters
   - New initial difficulty targets

2. Network Parameters
   - Custom network magic bytes
   - Modified peer discovery seeds
   - New default port: 8333

3. Consensus Rules
   - Maintained proof-of-stake mechanism
   - Modified initial difficulty
   - Custom block time targets

4. Block Rewards
   - Modified initial coin distribution
   - Adjusted reward schedule

## Setup Instructions

1. Build Requirements
   - Same as Peercoin/Bitcoin Core
   - C++ compiler with C++17 support
   - Boost libraries
   - OpenSSL

2. Build Steps
   ```bash
   ./autogen.sh
   ./configure
   make
   ```

3. Initial Setup
   ```bash
   ./src/saudichaind -daemon
   ./src/saudichain-cli getnewaddress
   ```

## Development Guidelines

1. Branching Strategy
   - develop: Active development
   - main: Stable releases
   - feature/*: New features
   - fix/*: Bug fixes

2. Testing
   - Unit tests required for all changes
   - Integration tests for major features
   - Testnet deployment before mainnet
