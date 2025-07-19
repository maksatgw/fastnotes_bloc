import 'package:flutter/material.dart';

// SnackbarUtils, uygulamada kullanılan snackbar'ları yönetir.

class SnackbarUtils {
  // Ana scaffold'ın keyi
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  // Başarılı snackbar
  static void showSuccessSnackbar(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Hata snackbar
  static void showErrorSnackbar(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Bilgi snackbar
  static void showInfoSnackbar(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.grey[500],
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
