import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _storage = FlutterSecureStorage();

Future<String> get getTokenCache async => _storage.read(key: 'user-token');

Future<void> removeToken() async => _storage.delete(key: 'user-info');

Future<void> saveToken(String userHash) {
  return _storage.write(key: 'user-token', value: userHash);
}

Future<void> saveCache(String url, String data) async {
  await _storage.write(key: url, value: data);
}

Future<String> readCache(String url) async {
  return _storage.read(key: url);
}

Future<void> deleteCached(String url) async {
  await _storage.delete(key: url);
}
