# SaudiChain Wallet Generator

## Overview
This tool generates secure wallet addresses and private keys for the SaudiChain development funds. It should be run in a secure, offline environment to ensure the safety of the generated keys.

## Security Requirements

1. Offline System:
   - Use an air-gapped computer
   - Never connect the system to the internet
   - Use a clean operating system installation

2. Dependencies:
   ```bash
   pip install ecdsa base58 qrcode pillow
   ```

## Usage

1. Copy the script to the offline system:
   ```bash
   # On the offline system:
   python3 address_generator.py
   ```

2. The script will generate:
   - Text file with wallet details
   - QR codes for addresses and private keys
   - 5 complete wallets for development funds

3. Outputs:
   - Wallet information file (saudichain_wallets_[timestamp].txt)
   - QR code directory (wallet_qr_codes_[timestamp])

## Security Best Practices

1. Key Storage:
   - Store private keys in cold storage
   - Keep multiple secure backups
   - Consider hardware security modules

2. Distribution:
   - Securely distribute keys to authorized team members
   - Use multi-signature setups for fund management
   - Implement time-lock mechanisms

3. After Generation:
   - Securely wipe the computer's memory
   - Store offline backups in multiple secure locations
   - Never store private keys digitally on internet-connected devices

## Verification

To verify the generated addresses:
1. Use multiple independent wallet software to verify address generation
2. Test with small amounts before large transfers
3. Verify QR codes with multiple devices

## Emergency Procedures

1. If private keys are compromised:
   - Immediately transfer funds to new secure addresses
   - Document the incident
   - Review security procedures

2. Keep emergency contact information for:
   - Security team members
   - Development fund managers
   - Multi-signature participants