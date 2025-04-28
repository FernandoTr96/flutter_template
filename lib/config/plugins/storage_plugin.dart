
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StoragePlugin {

  final FlutterSecureStorage storage;

  StoragePlugin(): storage = const FlutterSecureStorage();

  Future<void> write(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return await storage.read(key: key);
  }

  Future<void> delete(String key) async {
    await storage.delete(key: key);
  }

  Future<Map<String, String>> getAll() async {
    return await storage.readAll();
  }

  Future<void> clear() async {
    await storage.deleteAll();
  }

}