import 'package:intl/intl.dart';

extension NumExtension on num {
  String get withComma {
    final formatter = NumberFormat('#,##0.00');
    return formatter.format(this);
  }

  String get formatAmount {
    if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}M';
    } else if (this >= 1000) {
      return '${(this / 1000).toStringAsFixed(1)}K';
    } else {
      return toStringAsFixed(0);
    }
  }
}
