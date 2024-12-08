import 'package:flutter_test/flutter_test.dart';
import 'package:saudichain_wallet/config/portable_config.dart';
import 'dart:io';

void main() {
  group('Portable Configuration Tests', () {
    test('Detects Portable Mode', () {
      // Test portable mode detection
      expect(PortableConfig.isPortable, false);
      
      // Set portable environment
      Platform.environment['SAUDICHAIN_PORTABLE'] = '1';
      expect(PortableConfig.isPortable, true);
    });

    test('Uses Correct Directories in Portable Mode', () {
      Platform.environment['SAUDICHAIN_PORTABLE'] = '1';
      Platform.environment['SAUDICHAIN_DATA_DIR'] = 'test_data';

      expect(PortableConfig.dataDirectory, 'test_data');
      expect(PortableConfig.walletDirectory,
          contains(Platform.pathSeparator + 'wallets'));
    });

    test('Uses Default Directories in Normal Mode', () {
      Platform.environment.remove('SAUDICHAIN_PORTABLE');

      expect(PortableConfig.dataDirectory, contains('SaudiChain'));
      expect(PortableConfig.walletDirectory, contains('wallets'));
    });
  });
}