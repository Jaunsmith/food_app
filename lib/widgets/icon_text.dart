import 'package:flutter/material.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';
import 'package:food_app/widgets/sub_text.dart';

class IconText extends StatelessWidget {
  const IconText({
    super.key,
    required this.text,
    required this.icon,
    required this.iconColor,
  });

  final String text;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        SizedBox(width: DynamicDimensions.size5),
        SubText(text: text),
      ],
    );
  }
}
