// Copyright (c) 2024 SaudiChain Developers

#include <test/setup_common.h>
#include <consensus/validation.h>
#include <boost/test/unit_test.hpp>

BOOST_FIXTURE_TEST_SUITE(staking_tests, TestingSetup)

BOOST_AUTO_TEST_CASE(test_stake_age_requirements)
{
    // Test minimum stake age
    int64_t minStakeAge = 1 * 60 * 60; // 1 hour in testnet
    int64_t currentTime = GetTime();
    int64_t coinAge = currentTime - minStakeAge + 60; // Just under minimum
    
    BOOST_CHECK(!CheckStakeAge(coinAge, currentTime));
    
    coinAge = currentTime - minStakeAge - 60; // Just over minimum
    BOOST_CHECK(CheckStakeAge(coinAge, currentTime));
}

BOOST_AUTO_TEST_CASE(test_stake_reward_calculation)
{
    // Test 5% annual reward
    CAmount stakeAmount = 1000 * COIN;
    int64_t stakeDuration = 365 * 24 * 60 * 60; // 1 year
    
    CAmount reward = CalculateStakeReward(stakeAmount, stakeDuration);
    BOOST_CHECK_EQUAL(reward, 50 * COIN); // 5% of 1000
}

BOOST_AUTO_TEST_CASE(test_maximum_supply)
{
    CAmount currentSupply = 100000000 * COIN; // Max supply
    CAmount stakeAmount = 1000 * COIN;
    
    // Ensure no rewards when max supply reached
    BOOST_CHECK(!CanStakeWithCurrentSupply(currentSupply, stakeAmount));
    
    currentSupply = 99999000 * COIN;
    BOOST_CHECK(CanStakeWithCurrentSupply(currentSupply, stakeAmount));
}

BOOST_AUTO_TEST_SUITE_END()
