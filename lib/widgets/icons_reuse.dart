import 'package:flutter/material.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';

class IconsReuse extends StatelessWidget {
  const IconsReuse({
    super.key,
    required this.icons,
    this.backgroundColor = const Color(0xFFfcf4e4),
    this.iconColor = const Color(0xFF756d54),
    this.size = 40,
    this.iconSize = 0,
  });
  final IconData icons;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: Center(
        child: Icon(
          icons,
          color: iconColor,
          size: iconSize == 0 ? DynamicDimensions.size15 : iconSize,
        ),
      ),
    );
  }
}
