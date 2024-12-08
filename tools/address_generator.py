#!/usr/bin/env python3

import hashlib
import ecdsa
import base58
import os
import qrcode
from datetime import datetime

def generate_private_key():
    """Generate a random private key"""
    return os.urandom(32)

def get_public_key(private_key):
    """Generate public key from private key using ECDSA"""
    signing_key = ecdsa.SigningKey.from_string(private_key, curve=ecdsa.SECP256k1)
    verifying_key = signing_key.get_verifying_key()
    return b'\x04' + verifying_key.to_string()

def hash160(public_key):
    """Perform SHA256 and RIPEMD160 hash functions"""
    sha256_hash = hashlib.sha256(public_key).digest()
    ripemd160_hash = hashlib.new('ripemd160')
    ripemd160_hash.update(sha256_hash)
    return ripemd160_hash.digest()

def create_address(public_key_hash, version_byte=0x00):
    """Create a Bitcoin-style address from public key hash"""
    # Add version byte
    vh160 = bytes([version_byte]) + public_key_hash
    
    # Double SHA256 for checksum
    double_sha256 = hashlib.sha256(hashlib.sha256(vh160).digest()).digest()
    
    # Add first 4 bytes as checksum
    addr = vh160 + double_sha256[:4]
    
    # Base58 encode
    return base58.b58encode(addr).decode('utf-8')

def wif_private_key(private_key, compressed=True, testnet=False):
    """Convert private key to WIF format"""
    # Add version byte and compression flag
    version = b'\xef' if testnet else b'\x80'
    extended_key = version + private_key
    if compressed:
        extended_key += b'\x01'
    
    # Double SHA256 for checksum
    double_sha256 = hashlib.sha256(hashlib.sha256(extended_key).digest()).digest()
    
    # Add checksum and encode
    extended_key += double_sha256[:4]
    return base58.b58encode(extended_key).decode('utf-8')

def generate_wallet(label):
    """Generate a complete wallet with address and private key"""
    private_key = generate_private_key()
    public_key = get_public_key(private_key)
    public_key_hash = hash160(public_key)
    address = create_address(public_key_hash)
    wif = wif_private_key(private_key)
    
    return {
        'label': label,
        'address': address,
        'private_key_wif': wif,
        'private_key_hex': private_key.hex()
    }

def save_wallet_info(wallets, filename):
    """Save wallet information to a file"""
    with open(filename, 'w') as f:
        f.write("SAUDICHAIN DEVELOPMENT WALLETS\n")
        f.write(f"Generated at: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
        f.write("WARNING: KEEP THIS INFORMATION SECURE AND OFFLINE!\n\n")
        
        for wallet in wallets:
            f.write(f"=== {wallet['label']} ===\n")
            f.write(f"Address: {wallet['address']}\n")
            f.write(f"Private Key (WIF): {wallet['private_key_wif']}\n")
            f.write(f"Private Key (HEX): {wallet['private_key_hex']}\n\n")

def generate_qr_codes(wallets, directory):
    """Generate QR codes for addresses and private keys"""
    os.makedirs(directory, exist_ok=True)
    
    for wallet in wallets:
        # Generate QR code for address
        addr_qr = qrcode.QRCode(version=1, box_size=10, border=5)
        addr_qr.add_data(wallet['address'])
        addr_qr.make(fit=True)
        addr_img = addr_qr.make_image(fill_color="black", back_color="white")
        addr_img.save(f"{directory}/{wallet['label']}_address.png")
        
        # Generate QR code for private key
        key_qr = qrcode.QRCode(version=1, box_size=10, border=5)
        key_qr.add_data(wallet['private_key_wif'])
        key_qr.make(fit=True)
        key_img = key_qr.make_image(fill_color="black", back_color="white")
        key_img.save(f"{directory}/{wallet['label']}_private_key.png")

def main():
    # Define development fund labels
    labels = [
        "Core Development Fund",
        "Marketing & Adoption Fund",
        "Partnership & Integration Fund",
        "Community Development Fund",
        "Reserve Fund"
    ]
    
    # Generate wallets
    wallets = [generate_wallet(label) for label in labels]
    
    # Save information
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    save_wallet_info(wallets, f'saudichain_wallets_{timestamp}.txt')
    
    # Generate QR codes
    qr_directory = f'wallet_qr_codes_{timestamp}'
    generate_qr_codes(wallets, qr_directory)
    
    print("\nWallet Generation Complete!")
    print(f"Wallet information saved to: saudichain_wallets_{timestamp}.txt")
    print(f"QR codes saved to directory: {qr_directory}")
    print("\nIMPORTANT: Store these files securely and offline!")

if __name__ == '__main__':
    main()
