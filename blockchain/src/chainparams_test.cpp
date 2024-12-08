// Copyright (c) 2024 SaudiChain Developers

#include <chainparams.h>
#include <chainparamsseeds.h>
#include <consensus/merkle.h>
#include <util/system.h>

class CTestNetParams : public CChainParams {
public:
    CTestNetParams() {
        strNetworkID = "test";
        consensus.nSubsidyHalvingInterval = 210000;
        consensus.nStakeMinAge = 1 * 60 * 60; // 1 hour for testing (vs 12 hours in mainnet)
        consensus.nStakeMaxAge = 24 * 60 * 60; // 24 hours for testing (vs 30 days in mainnet)
        consensus.nStakeTargetSpacing = 1 * 60; // 1 minute blocks for testing
        consensus.nStakeReward = 5; // Same 5% as mainnet
        
        // Test net uses lower difficulty
        consensus.powLimit = uint256S("0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
        consensus.posLimit = uint256S("0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
        
        // Test addresses start with 't'
        base58Prefixes[PUBKEY_ADDRESS] = std::vector<unsigned char>(1,111);
        base58Prefixes[SCRIPT_ADDRESS] = std::vector<unsigned char>(1,196);
        base58Prefixes[SECRET_KEY] = std::vector<unsigned char>(1,239);
        
        // Test network magic bytes
        pchMessageStart[0] = 0xcd;
        pchMessageStart[1] = 0xf2;
        pchMessageStart[2] = 0xc0;
        pchMessageStart[3] = 0xef;
        
        // Different port for testnet
        nDefaultPort = 18333;
        
        // Create testnet genesis block
        const char* pszTimestamp = "SaudiChain Testnet Launch 2024";
        CMutableTransaction txNew;
        txNew.nVersion = 1;
        txNew.vin.resize(1);
        txNew.vout.resize(1);
        txNew.vin[0].scriptSig = CScript() << 486604799 << CScriptNum(4)
            << std::vector<unsigned char>((const unsigned char*)pszTimestamp,
            (const unsigned char*)pszTimestamp + strlen(pszTimestamp));
        txNew.vout[0].nValue = 50 * COIN;
        txNew.vout[0].scriptPubKey = CScript() << ParseHex("04678afdb0fe5548271967f1a67130b7105cd6a828e03909a67962e0ea1f61deb649f6bc3f4cef38c4f35504e51ec112de5c384df7ba0b8d578a4c702b6bf11d5f") << OP_CHECKSIG;
        
        genesis = CreateGenesisBlock(txNew, 1704672000, 2083236893, 0x1d00ffff, 1, 50 * COIN);
        consensus.hashGenesisBlock = genesis.GetHash();
    }
};
