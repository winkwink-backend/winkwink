import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class LegalLocalizations {
  LegalLocalizations(this.locale);

  final Locale locale;
  late Map<String, String> _localizedStrings;

  static LegalLocalizations of(BuildContext context) {
    return Localizations.of<LegalLocalizations>(context, LegalLocalizations)!;
  }

  static const LocalizationsDelegate<LegalLocalizations> delegate =
      _LegalLocalizationsDelegate();

  Future<bool> load() async {
    // Fallback automatico
    String code = locale.languageCode;
    if (code != 'it' && code != 'en') {
      code = 'en';
    }

    final jsonString = await rootBundle.loadString(
      'assets/legal/legal_$code.arb',
    );

    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String get(String key) => _localizedStrings[key] ?? key;
}

class _LegalLocalizationsDelegate
    extends LocalizationsDelegate<LegalLocalizations> {
  const _LegalLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['it', 'en'].contains(locale.languageCode);

  @override
  Future<LegalLocalizations> load(Locale locale) async {
    final localizations = LegalLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_LegalLocalizationsDelegate old) => false;
}
