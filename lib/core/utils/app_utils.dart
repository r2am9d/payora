class AppUtils {
  factory AppUtils() => _instance;

  AppUtils._internal();

  static final AppUtils _instance = AppUtils._internal();
}
