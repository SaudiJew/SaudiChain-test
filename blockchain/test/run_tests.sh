#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Ensure we're in the right directory
cd "$(dirname "$0")/.." || exit 1

echo "Building SaudiChain tests..."

# Generate build files if needed
if [ ! -f Makefile ]; then
    echo "Running autogen..."
    ./autogen.sh || exit 1
    
    echo "Running configure..."
    ./configure --enable-tests || exit 1
fi

# Build everything
echo "Running make..."
make check -j$(nproc) || exit 1

# Run the test suite
echo "Running test suite..."
./test/test_saudichain

if [ $? -eq 0 ]; then
    echo -e "${GREEN}All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}Tests failed!${NC}"
    exit 1
fi