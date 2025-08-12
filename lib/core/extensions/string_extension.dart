extension StringExtension on String {
  String get withNewlines => replaceAll(' ', '\n');
  String get last => split('-').last;
}
