import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../l10n/messages_all_locales.dart';


class AppLocalization {
  static Future<AppLocalization> load(Locale locale) async {
    String name =
        locale.countryCode!.isEmpty ? locale.languageCode : locale.toString();

    final String localeName = Intl.canonicalizedLocale(name);
     return initializeMessages(localeName).then((value) => 
      AppLocalization());
    
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of(context, AppLocalization);
  }

  String get doctors {
    return Intl.message(
      "Doctors",
      name: "doctors",
      desc: "Here are some of the most popular doctors",
    );
  }

  String get more {
    return Intl.message(
      "More",
      name: "more",
      desc: "more",
    );
  }
  String get show{
    return Intl.message(
      "show",
      name: "show"
    );
  }
}

class AppLocalizationDelgate extends LocalizationsDelegate<AppLocalization> {
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) {
    return AppLocalization.load(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) {
    return false;
  }
}
