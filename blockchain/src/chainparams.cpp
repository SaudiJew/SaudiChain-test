// Copyright (c) 2024 SaudiChain Developers
// Based on Peercoin by Sunny King and Scott Nadal
// Distributed under the MIT software license

#include <chainparams.h>
#include <chainparamsseeds.h>
#include <consensus/merkle.h>
#include <deploymentinfo.h>
#include <hash.h>
#include <script/interpreter.h>
#include <util/string.h>
#include <util/system.h>

#include <assert.h>

static CBlock CreateGenesisBlock(const char* pszTimestamp, const CScript& genesisOutputScript, uint32_t nTime, uint32_t nNonce, uint32_t nBits, int32_t nVersion, const CAmount& genesisReward)
{
    CMutableTransaction txNew;
    txNew.nVersion = 1;
    txNew.vin.resize(1);
    txNew.vout.resize(1);
    txNew.vin[0].scriptSig = CScript() << 486604799 << CScriptNum(4) << std::vector<unsigned char>((const unsigned char*)pszTimestamp, (const unsigned char*)pszTimestamp + strlen(pszTimestamp));
    txNew.vout[0].nValue = genesisReward;
    txNew.vout[0].scriptPubKey = genesisOutputScript;

    CBlock genesis;
    genesis.nTime    = nTime;
    genesis.nBits    = nBits;
    genesis.nNonce   = nNonce;
    genesis.nVersion = nVersion;
    genesis.vtx.push_back(MakeTransactionRef(std::move(txNew)));
    genesis.hashPrevBlock.SetNull();
    genesis.hashMerkleRoot = BlockMerkleRoot(genesis);
    return genesis;
}

void CChainParams::UpdateVersionBitsParameters(Consensus::DeploymentPos d, int64_t nStartTime, int64_t nTimeout)
{
    consensus.vDeployments[d].nStartTime = nStartTime;
    consensus.vDeployments[d].nTimeout = nTimeout;
}

static CMainParams::CMainParams()
{
    strNetworkID = CBaseChainParams::MAIN;
    consensus.signet_blocks = false;
    consensus.signet_challenge.clear();
    
    // SaudiChain specific parameters
    consensus.nSubsidyHalvingInterval = 210000; // Same as Bitcoin
    consensus.nMajorityEnforceBlockUpgrade = 750;
    consensus.nMajorityRejectBlockOutdated = 950;
    consensus.nMajorityWindow = 1000;
    consensus.powLimit = uint256S("00000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
    consensus.posLimit = uint256S("00000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
    consensus.nTargetTimespan = 24 * 60 * 60; // 1 day
    consensus.nTargetSpacing = 10 * 60; // 10 minutes
    consensus.fPowAllowMinDifficultyBlocks = false;
    consensus.fPowNoRetargeting = false;
    consensus.nRuleChangeActivationThreshold = 1916; // 95% of 2016
    consensus.nMinerConfirmationWindow = 2016; // nTargetTimespan / nTargetSpacing
    
    // The message start string is designed to be unlikely to occur in normal data
    pchMessageStart[0] = 0xsa;
    pchMessageStart[1] = 0xud;
    pchMessageStart[2] = 0x1c;
    pchMessageStart[3] = 0xha;
    nDefaultPort = 8333;
    
    // Generate a new genesis block
    const char* pszTimestamp = "SaudiChain Launch 2024 - A New Era of Digital Finance";
    const CScript genesisOutputScript = CScript() << ParseHex("04678afdb0fe5548271967f1a67130b7105cd6a828e03909a67962e0ea1f61deb649f6bc3f4cef38c4f35504e51ec112de5c384df7ba0b8d578a4c702b6bf11d5f") << OP_CHECKSIG;
    genesis = CreateGenesisBlock(pszTimestamp, genesisOutputScript, 1607731200, 2083236893, 0x1d00ffff, 1, 50 * COIN);
    consensus.hashGenesisBlock = genesis.GetHash();
    
    base58Prefixes[PUBKEY_ADDRESS] = std::vector<unsigned char>(1,0); // Start with 1
    base58Prefixes[SCRIPT_ADDRESS] = std::vector<unsigned char>(1,5); // Start with 3
    base58Prefixes[SECRET_KEY] =     std::vector<unsigned char>(1,128);
    base58Prefixes[EXT_PUBLIC_KEY] = {0x04, 0x88, 0xB2, 0x1E}; // xpub
    base58Prefixes[EXT_SECRET_KEY] = {0x04, 0x88, 0xAD, 0xE4}; // xprv
    
    // Note: testnet and regtest parameters would go here
    
    chainTxData = ChainTxData{
        0,
        0,
        0
    };
}
