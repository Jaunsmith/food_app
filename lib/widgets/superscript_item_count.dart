import 'package:flutter/material.dart';

import '../utilities/colors.dart';
import '../utilities/dynamic_dimensions.dart';
import 'main_text.dart';

class SuperscriptItemCount extends StatelessWidget {
  const SuperscriptItemCount({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DynamicDimensions.size20,
      width: DynamicDimensions.size20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DynamicDimensions.size20 / 2),
        color: AppColors.mainColor,
      ),
      child: Center(
        child: MainText(
          text: text,
          color: Colors.white,
          fontSize: DynamicDimensions.size12,
        ),
      ),
    );
  }
}
