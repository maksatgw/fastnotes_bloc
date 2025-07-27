import 'package:logger/logger.dart';

// Log Leveları kontrol edilmesi için bu enum kullanılıyor.
enum LogLevel {
  info,
  error,
  warning,
  debug,
  fatal,
}

// AppLogger sınıfı, loglama işlemlerini yönetir.
class AppLogger {
  // Logger Nesnesi
  late Logger _logger;

  // AppLogger oluşturulduğunda initialize fonksiyonu çağrılır.
  AppLogger() {
    _initialize();
  }

  void _initialize() {
    // Logger Nesnesini oluşturur.
    _logger = Logger(
      level: Level.all,
      output: ConsoleOutput(),
      printer: PrettyPrinter(
        dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      ),
    );
  }

  // Ana log fonksiyonu, loglama işlemlerini yönetir.
  void log(
    LogLevel level,
    String message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    switch (level) {
      case LogLevel.info:
        _logger.i(message, error: error, stackTrace: stackTrace);
      case LogLevel.error:
        _logger.e(message, error: error, stackTrace: stackTrace);
      case LogLevel.warning:
        _logger.w(message, error: error, stackTrace: stackTrace);
      case LogLevel.debug:
        _logger.d(message, error: error, stackTrace: stackTrace);
      case LogLevel.fatal:
        _logger.f(message, error: error, stackTrace: stackTrace);
    }
  }

  // Info log fonksiyonu, info loglama işlemlerini yönetir.
  void info(String message, {dynamic error, StackTrace? stackTrace}) {
    log(LogLevel.info, message, error: error, stackTrace: stackTrace);
  }

  // Error log fonksiyonu, error loglama işlemlerini yönetir.
  void error(String message, {dynamic error, StackTrace? stackTrace}) {
    log(LogLevel.error, message, error: error, stackTrace: stackTrace);
  }

  // Warning log fonksiyonu, warning loglama işlemlerini yönetir.
  void warning(String message, {dynamic error, StackTrace? stackTrace}) {
    log(LogLevel.warning, message, error: error, stackTrace: stackTrace);
  }

  // Debug log fonksiyonu, debug loglama işlemlerini yönetir.
  void debug(String message, {dynamic error, StackTrace? stackTrace}) {
    log(LogLevel.debug, message, error: error, stackTrace: stackTrace);
  }

  // Fatal log fonksiyonu, fatal loglama işlemlerini yönetir.
  void fatal(String message, {dynamic error, StackTrace? stackTrace}) {
    log(LogLevel.fatal, message, error: error, stackTrace: stackTrace);
  }
}
