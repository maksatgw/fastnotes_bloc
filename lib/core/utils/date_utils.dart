import 'package:intl/intl.dart';

// Tarih formatlama için kullanılır.
class DateFormatUtils {
  // Tarihi formatlı stringe çevirir.
  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm').format(date);

    // Örnek: 19/07/2025 10:00
  }
}
