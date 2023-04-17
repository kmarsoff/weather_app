import 'dart:io';
import 'package:flutter/material.dart';
import 'package:weather/l10n/l10n.dart';

Locale getLocale() {
  Locale locale = L10n.all[0];
  if (Platform.localeName.contains('ru')) {
    locale = L10n.all[1];
    return locale;
  } else {
    return locale;
  }
}
