import 'package:flutter/material.dart';

// Snackbar'ların oluşturulması için kullanılır.
class SnackbarFactoryUtil {
  static const Duration snackbarDuration = Duration(seconds: 3);
  static SnackBar buildSuccessSnackBar(String message) {
    return SnackBar(
      content: Text(message),
      backgroundColor: Colors.blue,
      duration: snackbarDuration,
    );
  }

  static SnackBar buildErrorSnackBar(String message) {
    return SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      duration: snackbarDuration,
    );
  }

  static SnackBar buildInfoSnackBar(String message) {
    return SnackBar(
      content: Text(message),
      backgroundColor: Colors.grey[500],
      duration: snackbarDuration,
    );
  }
}

// Global Key ile ekranlar arası snackbar kullanımı için kullanılır.
class GlobalSnackBarUtil {
  // Ana scaffold'ın keyi
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  // Başarılı snackbar
  static void showSuccessSnackbar(String message) {
    // Önceki snackbar'ları temizle
    scaffoldMessengerKey.currentState?.clearSnackBars();
    // Yeni snackbar'ı göster
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackbarFactoryUtil.buildSuccessSnackBar(message),
    );
  }

  // Hata snackbar
  static void showErrorSnackbar(String message) {
    // Önceki snackbar'ları temizle
    scaffoldMessengerKey.currentState?.clearSnackBars();
    // Yeni snackbar'ı göster
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackbarFactoryUtil.buildErrorSnackBar(message),
    );
  }

  // Bilgi snackbar
  static void showInfoSnackbar(String message) {
    // Önceki snackbar'ları temizle
    scaffoldMessengerKey.currentState?.clearSnackBars();
    // Yeni snackbar'ı göster
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackbarFactoryUtil.buildInfoSnackBar(message),
    );
  }
}
