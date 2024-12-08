# Building and Testing SaudiChain

## Prerequisites

### Linux (Ubuntu/Debian)
```bash
sudo apt-get update
sudo apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils python3 libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
```

### macOS
```bash
brew install automake berkeley-db4 libtool boost openssl pkg-config python3
```

### Windows
Install Visual Studio 2019 with C++ support and Windows SDK

## Building

1. Clone the repository:
```bash
git clone https://github.com/SaudiJew/SaudiChain-test.git
cd SaudiChain-test/blockchain
```

2. Generate build files:
```bash
./autogen.sh
```

3. Configure:
```bash
# For mainnet
./configure

# For testnet with debug symbols
./configure --enable-debug
```

4. Build:
```bash
make -j$(nproc) # Use number of CPU cores
```

## Testing

### Running Test Suite
```bash
# Build and run all tests
./test/run_tests.sh

# Run specific test
./test/test_saudichain -t test_stake_reward_calculation
```

### Running Testnet

1. Start testnet daemon:
```bash
./src/saudichaind -testnet -daemon
```

2. Create test wallet:
```bash
./src/saudichain-cli -testnet createwallet "test_wallet"
```

3. Generate address:
```bash
./src/saudichain-cli -testnet getnewaddress
```

4. Check staking info:
```bash
./src/saudichain-cli -testnet getstakinginfo
```

### Test Parameters

Testnet uses these modified parameters for faster testing:
- 1-minute blocks (vs 10 minutes on mainnet)
- 1-hour minimum stake age (vs 12 hours on mainnet)
- Lower difficulty target
- Test addresses start with 't'

## Common Issues

1. Build Errors
- Check all dependencies are installed
- Try `make clean` and rebuild
- Ensure boost version >= 1.58.0

2. Runtime Errors
- Check debug.log in data directory
- Ensure enough disk space
- Verify network connectivity

## Development Workflow

1. Make changes in src/
2. Add tests in test/
3. Run test suite
4. Test on testnet
5. Create pull request