import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class L10n {

  const L10n();

  static Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates() {
    return AppLocalizations.localizationsDelegates;
  }

  static Iterable<Locale> supportedLocales() {
    return AppLocalizations.supportedLocales;
  }

  static AppLocalizations str(BuildContext context){
    return AppLocalizations.of(context)!;
  }
}