import 'package:flutter/material.dart';

class L10n {
  L10n._();

  static final all = [
    const Locale('en'),
    const Locale('fr'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'fr':
        return 'French';
      case 'en':
      default:
        return 'English';
    }
  }
}
