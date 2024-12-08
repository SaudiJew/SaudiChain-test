#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Starting SaudiChain Test Scenario${NC}"

# Build and start the test network
echo -e "${GREEN}Building and starting test network...${NC}"
docker-compose -f docker/docker-compose.yml up -d

# Wait for nodes to start
sleep 10

# Test 1: Check if nodes are running
echo -e "\n${GREEN}Test 1: Checking node status${NC}"
for i in {1..3}; do
    echo "Checking node$i:"
    docker-compose -f docker/docker-compose.yml exec node$i saudichain-cli -testnet getblockcount
    docker-compose -f docker/docker-compose.yml exec node$i saudichain-cli -testnet getconnectioncount
done

# Test 2: Create wallets and check balances
echo -e "\n${GREEN}Test 2: Creating test wallets${NC}"
for i in {1..3}; do
    echo "Creating wallet on node$i:"
    docker-compose -f docker/docker-compose.yml exec node$i saudichain-cli -testnet createwallet "test_wallet_$i"
    docker-compose -f docker/docker-compose.yml exec node$i saudichain-cli -testnet getnewaddress
done

# Test 3: Check staking status
echo -e "\n${GREEN}Test 3: Checking staking status${NC}"
for i in {1..3}; do
    echo "Staking info for node$i:"
    docker-compose -f docker/docker-compose.yml exec node$i saudichain-cli -testnet getstakinginfo
done

# Test 4: Monitor block creation
echo -e "\n${GREEN}Test 4: Monitoring block creation (30 seconds)${NC}"
for i in {1..6}; do
    echo "Block heights:"
    for node in {1..3}; do
        height=$(docker-compose -f docker/docker-compose.yml exec node$node saudichain-cli -testnet getblockcount)
        echo "Node$node height: $height"
    done
    sleep 5
done

echo -e "\n${YELLOW}Test scenario complete${NC}"
