import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageActions {
  static FlutterSecureStorage _storage = new FlutterSecureStorage();

  static Future<String> get(String key) {
    return _storage.read(key: key);
  }

  static Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }
}
