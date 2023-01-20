import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import 'storage_manager.dart';

LocaleManager localeManager = LocaleManager();

class LocaleManager with ChangeNotifier {
  final List<Locale> supportedLocales = S.supportedLocales;
  late Locale currentLocale;

  Future<void> loadCurrentLocale() async {
    await StorageManager.readData('locale').then((dynamic value) {
      value ??= 'en';
      currentLocale = supportedLocales.firstWhere((Locale element) => element.languageCode == value);
      notifyListeners();
    });
  }

  void setCurrentLocale(Locale? locale) {
    if (locale == null) return;

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

  String formatDuration(Duration duration, {bool shouldPadHours = true}) {
    String hours = duration.inHours.toString().padLeft(shouldPadHours ? 2 : 0, "0");
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, "0");
    return "$hours:$minutes";
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
