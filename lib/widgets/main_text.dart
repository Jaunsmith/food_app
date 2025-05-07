import 'package:flutter/material.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';

class MainText extends StatelessWidget {
  const MainText({
    super.key,
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.fontSize = 0,
    this.textOverflow = TextOverflow.ellipsis,
    this.maxLines = 0,
    this.textAlign = TextAlign.start,
  });

  final Color color;
  final String text;
  final double fontSize;
  final TextOverflow textOverflow;
  final int maxLines;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      maxLines: maxLines == 0 ? 1 : maxLines,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: fontSize == 0 ? DynamicDimensions.size20 : fontSize,
        fontWeight: FontWeight.w500,
      ),
      textAlign: textAlign,
    );
  }
}
