import 'package:flutter/material.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';
import 'package:food_app/widgets/main_text.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({
    super.key,
    required this.text,
    this.imagePath = 'assets/image/empty_cart.png',
  });

  final String text;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imagePath,
          height: DynamicDimensions.image150,
          width: DynamicDimensions.image150,
        ),
        SizedBox(height: DynamicDimensions.size20),
        MainText(
          text: text,
          fontSize: DynamicDimensions.size15,
          color: Theme.of(context).disabledColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
