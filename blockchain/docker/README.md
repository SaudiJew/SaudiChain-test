# SaudiChain Test Environment

## Overview
This directory contains Docker configuration for running a test network with multiple nodes.

## Prerequisites
- Docker
- Docker Compose

## Quick Start

1. Build and start the network:
```bash
docker-compose up -d
```

2. Run test scenario:
```bash
./test_scenario.sh
```

3. Check logs:
```bash
docker-compose logs -f
```

## Components

- 3 testnet nodes
- Automated test scenario
- Persistent data volumes
- Network isolation

## Test Scenario

The test_scenario.sh script performs:
1. Node status verification
2. Wallet creation
3. Staking status check
4. Block creation monitoring

## Monitoring

Access individual nodes:
```bash
docker-compose exec node1 saudichain-cli -testnet getinfo
```

## Cleanup

Stop and remove containers:
```bash
docker-compose down -v
```