
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StoragePlugin {

  final FlutterSecureStorage _storage;

  StoragePlugin(): _storage = const FlutterSecureStorage();

  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<Map<String, String>> getAll() async {
    return await _storage.readAll();
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }

}