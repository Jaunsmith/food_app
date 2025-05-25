import 'package:flutter/material.dart';
import 'package:food_app/widgets/sub_text.dart';

import '../utilities/colors.dart';
import '../utilities/dynamic_dimensions.dart';
import 'icon_text.dart';
import 'main_text.dart';

class FoodReviewDetails extends StatelessWidget {
  const FoodReviewDetails({
    super.key,
    required this.text,
    this.rating = 5,
    this.maxLines = 1,
  });

  final String text;
  final int rating;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainText(
          text: text,
          fontSize: DynamicDimensions.size26,
          maxLines: maxLines == 0 ? 1 : maxLines,
          color: AppColors.mainColor,
        ),
        SizedBox(height: DynamicDimensions.size10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // this is used to display same thing repeatedly horizontally....
            Wrap(
              children: List.generate(
                rating,
                (index) => Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: DynamicDimensions.size15,
                ),
              ),
            ),
            SubText(text: rating.toString()),
            SubText(text: '455  comments'),
          ],
        ),
        SizedBox(height: DynamicDimensions.size15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconText(
              text: 'Normal',
              icon: Icons.circle_sharp,
              iconColor: AppColors.iconColor1,
            ),
            IconText(
              text: '1.5km',
              icon: Icons.location_on,
              iconColor: AppColors.mainColor,
            ),
            IconText(
              text: '20min',
              icon: Icons.access_time_rounded,
              iconColor: AppColors.iconColor2,
            ),
          ],
        ),
      ],
    );
  }
}
