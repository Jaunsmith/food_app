import 'package:flutter/material.dart';
import 'package:food_app/utilities/colors.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';
import 'package:food_app/widgets/icons_reuse.dart';
import 'package:food_app/widgets/main_text.dart';

class DataInput extends StatelessWidget {
  const DataInput({
    super.key,
    required this.icons,
    required this.text,
    required this.iconBckColor,
  });

  final IconData icons;
  final String text;
  final Color iconBckColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: DynamicDimensions.size20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: Colors.grey.shade200,
            blurRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.only(
        left: DynamicDimensions.size20,
        top: DynamicDimensions.size10,
        bottom: DynamicDimensions.size10,
      ),
      child: Row(
        children: [
          IconsReuse(
            icons: icons,
            backgroundColor: iconBckColor,
            iconColor: Colors.white,
            iconSize: DynamicDimensions.size250 / 10,
            size: DynamicDimensions.size150 / 3,
          ),
          SizedBox(width: DynamicDimensions.size15),
          MainText(text: text, color: AppColors.titleColor),
        ],
      ),
    );
  }
}
