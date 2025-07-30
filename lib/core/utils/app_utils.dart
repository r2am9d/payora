import 'package:intl/intl.dart';

class AppUtils {
  factory AppUtils() => _instance;

  AppUtils._internal();

  static final AppUtils _instance = AppUtils._internal();

  static String formatWithCommas(num value) {
    final formatter = NumberFormat('#,##0.00');
    return formatter.format(value);
  }
}
