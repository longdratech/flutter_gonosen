import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  static const KEY_TOKEN = 'user-token';
  static const KEY_USER_INFO = 'user-info';

  Future<String> get getToken async => _storage.read(key: KEY_TOKEN);

  Future<void> removeToken() async => _storage.delete(key: KEY_TOKEN);

  Future<void> saveToken(String userHash) {
    return _storage.write(key: KEY_TOKEN, value: userHash);
  }

  Future<String> get getUserId async => await _storage.read(key: KEY_USER_INFO);

  Future<void> removeUserInfo() async => _storage.delete(key: KEY_USER_INFO);

  Future<void> saveUserInfo(String name) {
    return _storage.write(key: KEY_USER_INFO, value: name);
  }
}
