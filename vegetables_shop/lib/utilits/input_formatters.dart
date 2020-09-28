import 'dart:math';

import 'package:flutter/services.dart';

class CarNumberFormatter extends TextInputFormatter {
  static const int _maxChars = 16;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = _format(newValue.text, ' ');
    return newValue.copyWith(text: text, selection: updateCursorPosition(text));
  }

  String _format(String value, String separator) {
    value = value.replaceAll(separator, '');
    String newString = '';

    for (int i = 0; i < min(value.length, _maxChars); i++) {
      newString += value[i];
      if ((i == 3 || i == 7 || i == 11) && i != value.length - 1) {
        newString += separator;
      }
    }
    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}

class ExpireDateTextFormatter extends TextInputFormatter {
  static const int _maxChars = 4;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = _format(newValue.text, '/');
    return newValue.copyWith(text: text, selection: updateCursorPosition(text));
  }

  String _format(String value, String separator) {
    value = value.replaceAll(separator, '');
    String newString = '';

    for (int i = 0; i < min(value.length, _maxChars); i++) {
      newString += value[i];
      if ((i == 1 || i == 6) && i != value.length - 1) {
        newString += separator;
      }
    }
    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}
