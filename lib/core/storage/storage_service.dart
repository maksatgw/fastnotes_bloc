import 'package:fastnotes_bloc/core/errors/failures.dart';
import 'package:fastnotes_bloc/core/logging/app_logger.dart';
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
  Future<void> remove(String key);
}

// Storage Servis için implementasyon
class StorageServiceImpl implements StorageService {
  // Hive Box oluşturuyoruz.
  Box? _appBox;
  final AppLogger _appLogger;
  StorageServiceImpl(this._appLogger);
  // Ana fonksiyonlar
  @override
  Future<void> init() async {
    try {
      _appLogger.debug('Initializing Hive');
      // Hive'ı başlatıyoruz.
      await Hive.initFlutter();
      // Hive Box'ı açıyoruz.
      _appBox = await Hive.openBox(HiveBoxes.app);
    } catch (e) {
      _appLogger.error(
        'Error in init',
        error: e,
        stackTrace: StackTrace.current,
      );
      throw CacheFailure(message: e.toString());
    }
  }

  // Bool değerleri için fonksiyonlar
  @override
  Future<bool> getBool(String key) async {
    try {
      _appLogger.debug('Getting $key from storage');
      return await _appBox?.get(key) ?? false;
    } catch (e) {
      _appLogger.error(
        'Error in getBool',
        error: e,
        stackTrace: StackTrace.current,
      );
      throw CacheFailure(message: e.toString());
    }
  }

  @override
  bool getBoolSync(String key) {
    try {
      _appLogger.debug('Getting $key from storage');
      return _appBox?.get(key) ?? false;
    } catch (e) {
      _appLogger.error(
        'Error in getBoolSync',
        error: e,
        stackTrace: StackTrace.current,
      );
      throw CacheFailure(message: e.toString());
    }
  }

  @override
  Future<void> setBool(String key, bool value) async {
    try {
      _appLogger.debug('Setting $key');
      await _appBox?.put(key, value);
    } catch (e) {
      _appLogger.error(
        'Error in setBool',
        error: e,
        stackTrace: StackTrace.current,
      );
      throw CacheFailure(message: e.toString());
    }
  }

  // Tüm değerleri temizleme fonksiyonu
  @override
  Future<void> clearAll() async {
    try {
      _appLogger.debug('Clearing all storage');
      await _appBox?.clear();
    } catch (e) {
      _appLogger.error(
        'Error in clearAll',
        error: e,
        stackTrace: StackTrace.current,
      );
      throw CacheFailure(message: e.toString());
    }
  }

  @override
  Future<String?> getString(String key) async {
    try {
      _appLogger.debug('Getting $key from storage');
      return await _appBox?.get(key);
    } catch (e) {
      _appLogger.error(
        'Error in getString',
        error: e,
        stackTrace: StackTrace.current,
      );
      throw CacheFailure(message: e.toString());
    }
  }

  @override
  String? getStringSync(String key) {
    try {
      _appLogger.debug('Getting $key from storage');
      return _appBox?.get(key);
    } catch (e) {
      _appLogger.error(
        'Error in getStringSync',
        error: e,
        stackTrace: StackTrace.current,
      );
      throw CacheFailure(message: e.toString());
    }
  }

  @override
  Future<void> setString(String key, String value) async {
    try {
      _appLogger.debug('Setting to $value');
      await _appBox?.put(key, value);
    } catch (e) {
      _appLogger.error(
        'Error in setString',
        error: e,
        stackTrace: StackTrace.current,
      );
      throw CacheFailure(message: e.toString());
    }
  }

  @override
  Future<void> remove(String key) async {
    try {
      _appLogger.debug('Removing $key from storage');
      await _appBox?.delete(key);
    } catch (e) {
      _appLogger.error(
        'Error in remove',
        error: e,
        stackTrace: StackTrace.current,
      );
      throw CacheFailure(message: e.toString());
    }
  }
}
