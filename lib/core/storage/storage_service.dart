import 'package:fastnotes_bloc/core/errors/exception_handler.dart';
import 'package:fastnotes_bloc/core/errors/exceptions.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveBoxes {
  static const String app = 'app';
}

// Storage Servis için arayüz
abstract class StorageService {
  Future<void> init();
  Future<void> setBool(String key, bool value);
  Future<bool> getBool(String key);
  bool getBoolSync(String key);
  Future<void> setString(String key, String value);
  Future<String?> getString(String key);
  String? getStringSync(String key);
  Future<void> clearAll();
}

// Storage Servis için implementasyon
class StorageServiceImpl implements StorageService {
  // Hive Box oluşturuyoruz.
  Box? _appBox;

  // Ana fonksiyonlar
  @override
  Future<void> init() async {
    try {
      // Hive'ı başlatıyoruz.
      await Hive.initFlutter();
      // Hive Box'ı açıyoruz.
      _appBox = await Hive.openBox(HiveBoxes.app);
    } catch (e) {
      throw handleCacheError(CacheException(message: e.toString()));
    }
  }

  // Bool değerleri için fonksiyonlar
  @override
  Future<bool> getBool(String key) async {
    try {
      return await _appBox?.get(key) ?? false;
    } catch (e) {
      throw handleCacheError(CacheException(message: e.toString()));
    }
  }

  @override
  bool getBoolSync(String key) {
    try {
      return _appBox?.get(key) ?? false;
    } catch (e) {
      throw handleCacheError(CacheException(message: e.toString()));
    }
  }

  @override
  Future<void> setBool(String key, bool value) async {
    try {
      await _appBox?.put(key, value);
    } catch (e) {
      throw handleCacheError(CacheException(message: e.toString()));
    }
  }

  // Tüm değerleri temizleme fonksiyonu
  @override
  Future<void> clearAll() async {
    try {
      await _appBox?.clear();
    } catch (e) {
      throw handleCacheError(CacheException(message: e.toString()));
    }
  }

  @override
  Future<String?> getString(String key) async {
    try {
      return await _appBox?.get(key);
    } catch (e) {
      throw handleCacheError(CacheException(message: e.toString()));
    }
  }

  @override
  String? getStringSync(String key) {
    try {
      return _appBox?.get(key);
    } catch (e) {
      throw handleCacheError(CacheException(message: e.toString()));
    }
  }

  @override
  Future<void> setString(String key, String value) async {
    try {
      await _appBox?.put(key, value);
    } catch (e) {
      throw handleCacheError(CacheException(message: e.toString()));
    }
  }
}
