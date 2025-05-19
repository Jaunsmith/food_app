import 'package:flutter/material.dart';
import 'package:food_app/utilities/colors.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: DynamicDimensions.size100,
        width: DynamicDimensions.size100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DynamicDimensions.size100 / 2),
          color: Colors.transparent,
        ),
        child: CircularProgressIndicator.adaptive(
          backgroundColor: AppColors.mainColor,
          strokeWidth: DynamicDimensions.size20,
        ),
      ),
    );
  }
}
