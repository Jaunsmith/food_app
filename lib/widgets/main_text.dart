import 'package:flutter/material.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';

class MainText extends StatelessWidget {
  const MainText({
    super.key,
    this.color,
    required this.text,
    this.fontSize = 0,
    this.textOverflow = TextOverflow.ellipsis,
    this.maxLines = 0,
    this.textAlign = TextAlign.start,
    this.fontWeight,
  });

  final Color? color;
  final String text;
  final double fontSize;
  final TextOverflow textOverflow;
  final int maxLines;
  final TextAlign textAlign;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      maxLines: maxLines == 0 ? 1 : maxLines,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color ?? Color(0xFF332d2b).withValues(alpha: 0.5),
        fontSize: fontSize == 0 ? DynamicDimensions.size15 : fontSize,
        fontWeight: fontWeight == null ? FontWeight.w400 : fontWeight,
      ),
      textAlign: textAlign,
    );
  }
}
