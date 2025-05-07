import 'package:flutter/material.dart';
import 'package:food_app/models/main_food_model.dart';
import 'package:food_app/utilities/constant_data.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';
import 'package:food_app/widgets/food_review_details.dart';
import 'package:food_app/widgets/pre_loading_page.dart';

Widget buildPageItem(
  int index,
  double pageValue,
  ProductsModel mainProduct,
  bool dataAvailable,
) {
  double scaleFactor = DynamicDimensions.size08;
  int pageFloor = pageValue.floor();
  double height = DynamicDimensions.size220;
  Matrix4 matrix = Matrix4.identity();
  // This is currently referring to the current page...
  if (index == pageFloor) {
    var currentScale = 1 - (pageValue - index) * (1 - scaleFactor);
    var currentTransform = height * (1 - currentScale) / 2;
    // this change the scaling and the position of current page
    matrix = Matrix4.diagonal3Values(1, currentScale, 1)
      ..setTranslationRaw(0, currentTransform, 0);
    // This  is currently referring to the next page...
  } else if (index == pageFloor + 1) {
    var currentScale =
        scaleFactor + (pageValue - index + 1) * (1 - scaleFactor);
    var currentTransform = height * (1 - currentScale) / 2;
    // this change the scaling and the position of next  page
    matrix = Matrix4.diagonal3Values(1, currentScale, 1)
      ..setTranslationRaw(0, currentTransform, 0);
    //This is referring to the previous page.....
  } else if (index == pageFloor - 1) {
    var currentScale = 1 - (pageValue - index) * (1 - scaleFactor);
    var currentTransform = height * (1 - currentScale) / 2;
    // this change the scaling and the position of next  page
    matrix = Matrix4.diagonal3Values(1, currentScale, 1)
      ..setTranslationRaw(0, currentTransform, 0);
    // This deal with the rest of the condition...
  } else {
    var currentScale = DynamicDimensions.size08;
    var currentTransform = height * (1 - scaleFactor) / 2;
    matrix = Matrix4.diagonal3Values(1, currentScale, 1)
      ..setTranslationRaw(0, currentTransform, 0);
  }
  return Transform(
    transform: matrix,
    child: Stack(
      children: [
        Container(
          height: height,
          margin: EdgeInsets.only(
            left: DynamicDimensions.size10,
            right: DynamicDimensions.size10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DynamicDimensions.size30),
            color:
                index.isEven ? Color(0xFF69c5df) : Colors.deepPurple.shade300,
          ),
          child: PreLoadingPage(
            imagePath:
                '${ConstantData.BASE_URL}${ConstantData.UPLOAD_URL}${mainProduct.img}',
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: DynamicDimensions.size120,
            margin: EdgeInsets.only(
              left: DynamicDimensions.size30,
              right: DynamicDimensions.size30,
              bottom: DynamicDimensions.size30,
            ),
            padding: EdgeInsets.only(
              left: DynamicDimensions.size20,
              right: DynamicDimensions.size20,
              top: DynamicDimensions.size10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(DynamicDimensions.size20),
              // This is to give the container a shadow
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFe8e8e8),
                  blurRadius: DynamicDimensions.size5,
                  offset: Offset(0, DynamicDimensions.size5),
                ),
                BoxShadow(
                  color: Color(0xFFe8e8e8),
                  blurRadius: DynamicDimensions.size5,
                  offset: Offset(
                    DynamicDimensions.size2,
                    -DynamicDimensions.size5,
                  ),
                ),
              ],
            ),
            child: FoodReviewDetails(
              text: mainProduct.name!,
              rating: mainProduct.stars!,
            ),
          ),
        ),
      ],
    ),
  );
}
