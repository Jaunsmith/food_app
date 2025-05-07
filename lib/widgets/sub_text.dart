import 'package:flutter/material.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';

class SubText extends StatelessWidget {
  const SubText({
    super.key,
    this.color = const Color(0xFFccc7c5),
    required this.text,
    this.fontSize = 0,
    this.height = 1.2,
    this.textAlign = TextAlign.start,
  });

  final Color color;
  final String text;
  final double fontSize;
  final double height;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      // This maxLine help to make the overflow be effective...
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: fontSize == 0 ? DynamicDimensions.size12 : fontSize,
        height: height,
      ),
      textAlign: textAlign,
    );
  }
}
