# SaudiChain Testnet

## Overview
Testnet configuration for SaudiChain with faster blocks and easier staking for testing purposes.

## Key Differences from Mainnet

1. Staking Parameters
   - Minimum stake age: 1 hour (vs 12 hours on mainnet)
   - Maximum stake age: 24 hours (vs 30 days on mainnet)
   - Block time: 1 minute (vs 10 minutes on mainnet)

2. Network
   - Different magic bytes
   - Port: 18333
   - Test addresses start with 't'

3. Difficulty
   - Lower difficulty target for faster testing
   - Easier to generate stakes

## Building and Running Tests

```bash
# Build tests
./autogen.sh
./configure --enable-tests
make check

# Run testnet
./src/saudichaind -testnet

# Create test wallet
./src/saudichain-cli -testnet getnewaddress

# Get testnet coins
./src/saudichain-cli -testnet getstakinginfo
```

## Test Cases

1. Basic Functionality
   - Genesis block verification
   - Address generation
   - Transaction creation

2. Staking Tests
   - Stake generation
   - Reward calculation
   - Age requirements

3. Network Tests
   - Peer discovery
   - Block propagation
   - Transaction relay

## Development Workflow

1. Write tests in `test/` directory
2. Build with `make check`
3. Run specific tests with `test/test_saudichain`
4. Check test coverage with `make check-coverage`