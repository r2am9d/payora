// dart format off
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Payora';

  @override
  String get bottomNavbarItemWallet => 'Wallet';

  @override
  String get bottomNavbarItemTransactions => 'Transactions';

  @override
  String get bottomNavbarItemProfile => 'Profile';

  @override
  String get walletGreetingsTitle => 'Hello';

  @override
  String get walletGreetingsSubtitle => 'Today is a great day!';

  @override
  String get walletCardSubtitile => 'Balance';

  @override
  String get walletActionsItemSendMoney => 'Send Money';

  @override
  String get walletActionsItemViewTransactions => 'View Transactions';
}
