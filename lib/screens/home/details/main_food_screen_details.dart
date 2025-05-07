import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_items_controller.dart';
import 'package:food_app/controllers/main_food_controller.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';
import 'package:food_app/utilities/route/app_route.dart';
import 'package:food_app/widgets/about_food_text.dart';
import 'package:food_app/widgets/food_review_details.dart';
import 'package:food_app/widgets/superscript_item_count.dart';
import 'package:get/get.dart';

import '../../../utilities/colors.dart';
import '../../../utilities/constant_data.dart';
import '../../../widgets/icons_reuse.dart';
import '../../../widgets/main_text.dart';
import '../../../widgets/pre_loading_page.dart';

class MainFoodDetails extends StatelessWidget {
  const MainFoodDetails({
    super.key,
    required this.index,
    required this.foodListPage,
  });

  final int index;
  final String foodListPage;
  @override
  Widget build(BuildContext context) {
    // This get us the instance of the list.. and let us get access to the data in the list get.find help us to find the parameter needed
    var products = Get.find<MainFoodController>().mainProductList[index];
    Get.find<MainFoodController>().resetProductData(
      products,
      Get.find<CartItemsController>(),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              height: DynamicDimensions.size350,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.purpleAccent,
                // image: DecorationImage(
                //   image: AssetImage('assets/image/food0.png'),
                //   fit: BoxFit.cover,
                // ),
              ),
              child: PreLoadingPage(
                imagePath:
                    '${ConstantData.BASE_URL}${ConstantData.UPLOAD_URL}${products.img}',
              ),
            ),
          ),
          Positioned(
            top: DynamicDimensions.size45,
            left: DynamicDimensions.size20,
            right: DynamicDimensions.size20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (foodListPage == 'cartPage') {
                      Get.toNamed(AppRoute.getCartItemsPage());
                    } else {
                      Get.toNamed(AppRoute.getInitialPage());
                    }
                  },
                  child: IconsReuse(icons: Icons.arrow_back_ios),
                ),
                // TO make it dynamic and only use the stack only when items in cart is >= 1 ....
                GetBuilder<MainFoodController>(
                  builder: (productsController) {
                    return GestureDetector(
                      onTap:
                          productsController.totalQuantity >= 1
                              ? () {
                                Get.toNamed(AppRoute.getCartItemsPage());
                              }
                              : () {},
                      child: Stack(
                        children: [
                          IconsReuse(icons: Icons.shopping_cart_outlined),
                          productsController.totalQuantity >= 1
                              ? Positioned(
                                right: 0,
                                top: 0,
                                child: SuperscriptItemCount(
                                  text:
                                      productsController.totalQuantity
                                          .toString(),
                                ),
                              )
                              : Container(),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: DynamicDimensions.size350 - DynamicDimensions.size20,
            child: Container(
              padding: EdgeInsets.only(
                left: DynamicDimensions.size20,
                right: DynamicDimensions.size20,
                top: DynamicDimensions.size20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(DynamicDimensions.size20),
                  topLeft: Radius.circular(DynamicDimensions.size20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FoodReviewDetails(text: products.name, maxLines: 2),
                  SizedBox(height: DynamicDimensions.size20),
                  MainText(text: 'Introduction'),
                  SizedBox(height: DynamicDimensions.size10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: AboutFoodText(text: products.description),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<MainFoodController>(
        builder: (mainFood) {
          return Container(
            height: DynamicDimensions.size120,
            padding: EdgeInsets.only(
              top: DynamicDimensions.size30,
              bottom: DynamicDimensions.size30,
              left: DynamicDimensions.size20,
              right: DynamicDimensions.size20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(DynamicDimensions.size20 * 2),
                topLeft: Radius.circular(DynamicDimensions.size20 * 2),
              ),
              color: AppColors.buttonBackgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(DynamicDimensions.size15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      DynamicDimensions.size20,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          mainFood.getQuantity(false);
                        },
                        child: Icon(Icons.remove),
                      ),
                      SizedBox(width: DynamicDimensions.size10),
                      Container(
                        padding: EdgeInsets.only(top: DynamicDimensions.size5),
                        child: MainText(text: mainFood.cartItems.toString()),
                      ),
                      SizedBox(width: DynamicDimensions.size10),
                      GestureDetector(
                        onTap: () {
                          mainFood.getQuantity(true);
                        },
                        child: Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    mainFood.addItems(products);
                  },
                  child: Container(
                    padding: EdgeInsets.all(DynamicDimensions.size15),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(
                        DynamicDimensions.size20,
                      ),
                    ),
                    child: Row(
                      children: [
                        MainText(
                          text: '\$ ${products.price} |  Add to cart',
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
