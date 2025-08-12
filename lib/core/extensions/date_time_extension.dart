extension DateTimeExtension on DateTime {
  String get formattedDate {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    // Day
    final day = this.day.toString().padLeft(2, '0');
    // Month
    final month = months[this.month - 1];
    // Year
    final year = this.year.toString();
    // Hour
    final hour = this.hour > 12
        ? this.hour - 12
        : (this.hour == 0 ? 12 : this.hour);
    final amPm = this.hour >= 12 ? 'PM' : 'AM';
    final minute = this.minute.toString().padLeft(2, '0');

    return '$day $month $year $hour:$minute $amPm';
  }
}
