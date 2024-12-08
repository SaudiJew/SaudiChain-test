#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}Starting SaudiChain Test Environment${NC}"

# Ensure we're starting fresh
echo -e "\n${GREEN}Cleaning up previous test environment...${NC}"
docker-compose down -v

# Start the network
echo -e "\n${GREEN}Starting test network...${NC}"
docker-compose up -d

# Wait for nodes to initialize
echo -e "\n${YELLOW}Waiting for nodes to initialize (30 seconds)...${NC}"
sleep 30

# Run the test scenario and generate report
echo -e "\n${GREEN}Running test scenario and generating report...${NC}"
python3 test_report.py

# Check if any errors occurred
if [ $? -eq 0 ]; then
    echo -e "\n${GREEN}All tests passed successfully!${NC}"
else
    echo -e "\n${RED}Some tests failed. Check the report for details.${NC}"
fi

# Offer to show logs
read -p "Would you like to see the node logs? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker-compose logs --tail=100
fi

# Ask if we should keep the network running
read -p "Would you like to keep the test network running? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\n${YELLOW}Shutting down test network...${NC}"
    docker-compose down -v
fi