import 'dart:io';
import 'package:path/path.dart' as path;

class PortableConfig {
  static bool get isPortable =>
      Platform.environment.containsKey('SAUDICHAIN_PORTABLE');

  static String get dataDirectory {
    if (isPortable) {
      return Platform.environment['SAUDICHAIN_DATA_DIR'] ?? 'data';
    }
    return _getDefaultDataDir();
  }

  static String get walletDirectory {
    if (isPortable) {
      return path.join(dataDirectory, 'wallets');
    }
    return _getDefaultWalletDir();
  }

  static String _getDefaultDataDir() {
    if (Platform.isWindows) {
      return path.join(
        Platform.environment['APPDATA'] ?? '',
        'SaudiChain',
      );
    }
    if (Platform.isMacOS) {
      return path.join(
        Platform.environment['HOME'] ?? '',
        'Library',
        'Application Support',
        'SaudiChain',
      );
    }
    // Linux and others
    return path.join(
      Platform.environment['HOME'] ?? '',
      '.saudichain',
    );
  }

  static String _getDefaultWalletDir() {
    return path.join(_getDefaultDataDir(), 'wallets');
  }

  static Future<void> initializePortableMode() async {
    if (!isPortable) return;

    // Create necessary directories
    await Directory(dataDirectory).create(recursive: true);
    await Directory(walletDirectory).create(recursive: true);

    // Create portable marker file
    final markerFile = File(path.join(dataDirectory, 'portable'));
    await markerFile.writeAsString('portable mode');
  }
}