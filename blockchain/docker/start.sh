#!/bin/bash

# Start the testnet daemon
/saudichain/src/saudichaind -testnet -daemon

# Wait for daemon to start
sleep 5

# Create test wallet
/saudichain/src/saudichain-cli -testnet createwallet "test_wallet"

# Generate a new address
ADDRESS=$(/saudichain/src/saudichain-cli -testnet getnewaddress)
echo "Test wallet address: $ADDRESS"

# Keep container running
tail -f /root/.saudichain/testnet/debug.log
