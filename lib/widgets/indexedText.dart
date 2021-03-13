import 'package:flutter/material.dart';

import '../colors.dart';

class IndexedText extends StatelessWidget {
  final String text;
  final Function function;
  final Color bgColor;
  final double width;
  final double height;
  final double fontSize;
  final Color fontColor;
  IndexedText(
      {this.text,
      this.function,
      this.bgColor = white,
      this.height = 65,
      this.width = 330,
      this.fontSize = 30,
      this.fontColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
          width: width,
          height: height,
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: bgColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w200,
                color: fontColor,
              ),
            ),
          )),
    );
  }
}
