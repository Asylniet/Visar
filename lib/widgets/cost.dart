import 'package:flutter/material.dart';

class Cost extends StatelessWidget {
  final int cost;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  Cost({this.cost, this.fontSize = 30, this.fontWeight = FontWeight.w200, this.color = Colors.black});

  String formatDecimal(int number) {
    if (number > -1000 && number < 1000) return number.toString();

    final String digits = number.abs().toString();
    final StringBuffer result = StringBuffer(number < 0 ? '-' : '');
    final int maxDigitIndex = digits.length - 1;
    for (int i = 0; i <= maxDigitIndex; i += 1) {
      result.write(digits[i]);
      if (i < maxDigitIndex && (maxDigitIndex - i) % 3 == 0) result.write(' ');
    }
    return result.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formatDecimal(cost) + " тг",
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
    );
  }
}
