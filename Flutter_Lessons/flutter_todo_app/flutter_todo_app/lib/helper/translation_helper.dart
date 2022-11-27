// ignore_for_file: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TranslationHelper {
  TranslationHelper._(); // Nesne Üretimez.

  static getLocaleType(BuildContext context) {
    String localeType = context.deviceLocale.countryCode!.toLowerCase();

    switch (localeType) {
      case "tr":
        return LocaleType.tr;
      case "en":
        return LocaleType.en;
    }
  }
}
