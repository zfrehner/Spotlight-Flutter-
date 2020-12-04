import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class MaxLengthFormatter extends TextInputFormatter {
  final int maxLength;
  final VoidCallback maxExceeded;

  MaxLengthFormatter(this.maxLength, this.maxExceeded);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final texts = newValue.text.split('\n');
    final maxExceed = texts.any((text)=> text.length > maxLength);

    if(maxExceed) {
      if(maxExceeded != null) {
        maxExceeded();
      }

      return oldValue;
    }

    return newValue;
  }

}