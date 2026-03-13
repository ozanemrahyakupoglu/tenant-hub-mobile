import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class SecureStorageService {
  static const _tokenKey = 'access_token';
  final FlutterSecureStorage _storage;

  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  Future<String?> getToken() async {
    if (kIsWeb) {
      return html.window.localStorage[_tokenKey];
    }
    return _storage.read(key: _tokenKey);
  }

  Future<void> setToken(String token) async {
    if (kIsWeb) {
      html.window.localStorage[_tokenKey] = token;
      return;
    }
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<void> clearToken() async {
    if (kIsWeb) {
      html.window.localStorage.remove(_tokenKey);
      return;
    }
    await _storage.delete(key: _tokenKey);
  }
}
