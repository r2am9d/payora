import 'package:intl/intl.dart';

extension NumExtension on num {
  String get withComma {
    final formatter = NumberFormat('#,##0.00');
    return formatter.format(this);
  }
}
