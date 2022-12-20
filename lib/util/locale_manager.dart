import 'package:flutter/material.dart';
import 'package:flutter_app/util/storage_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

LocaleManager localeManager = LocaleManager();

class LocaleManager with ChangeNotifier {
  final supportedLocales = AppLocalizations.supportedLocales;
  final localizationsDelegates = const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
  late Locale currentLocale;

  Future<void> loadCurrentLocale() async {
    await StorageManager.readData('locale').then((value) {
      value ??= 'en';
      currentLocale = supportedLocales.firstWhere((element) => element.languageCode == value);
      notifyListeners();
    });
  }

  void setCurrentLocale(Locale locale) {
    currentLocale = locale;
    StorageManager.saveData('locale', locale.languageCode);
    notifyListeners();
  }

  String formatDate(DateTime date) {
    return DateFormat.yMd(currentLocale.languageCode).format(date);
  }

  String formatTime(DateTime time) {
    return DateFormat.Hm(currentLocale.languageCode).format(time);
  }
}

extension LanguageName on Locale {
  String get languageName {
    switch (languageCode) {
      case 'de':
        return 'Deutsch';
      case 'en':
        return 'English';
      default:
        return '';
    }
  }
}
