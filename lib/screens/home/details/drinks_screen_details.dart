import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_items_controller.dart';
import 'package:food_app/controllers/drinks_controller.dart';
import 'package:food_app/controllers/main_food_controller.dart';
import 'package:food_app/utilities/route/app_route.dart';
import 'package:food_app/widgets/about_food_text.dart';
import 'package:food_app/widgets/icons_reuse.dart';
import 'package:food_app/widgets/pre_loading_page.dart';
import 'package:get/get.dart';

import '../../../utilities/colors.dart';
import '../../../utilities/constant_data.dart';
import '../../../utilities/dynamic_dimensions.dart';
import '../../../widgets/main_text.dart';
import '../../../widgets/superscript_item_count.dart';

class DrinksScreenDetails extends StatelessWidget {
  const DrinksScreenDetails({
    super.key,
    required this.index,
    required this.drinkListPage,
  });

  final int index;
  final String drinkListPage;

  @override
  Widget build(BuildContext context) {
    var productLists = Get.find<DrinksController>().productDrinksList[index];
    Get.find<MainFoodController>().resetProductData(
      productLists,
      Get.find<CartItemsController>(),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // this part is what is setting the top of the page
          SliverAppBar(
            // This is set to false to avoid the auto back icon
            automaticallyImplyLeading: false,
            // The pinned let the appbar be pin down and not disappear when the screen scroll reach there...
            pinned: true,
            //this give the color to display when the scroll reach the app bar point ...
            backgroundColor: AppColors.yellowColor,
            //this give the total size the main background will expand to @ the picture...
            expandedHeight: DynamicDimensions.size320,
            // This will give the title height mostly icons
            toolbarHeight: DynamicDimensions.size100 - DynamicDimensions.size20,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (drinkListPage == 'foodListPage') {
                      Get.toNamed(AppRoute.getCartItemsPage());
                    } else {
                      Get.toNamed(AppRoute.getInitialPage());
                    }
                  },
                  child: IconsReuse(icons: Icons.clear),
                ),
                // IconsReuse(icons: Icons.shopping_cart_outlined),
                GetBuilder<MainFoodController>(
                  builder: (drinksControl) {
                    return GestureDetector(
                      onTap:
                          drinksControl.totalQuantity >= 1
                              ? () {
                                Get.toNamed(AppRoute.getCartItemsPage());
                              }
                              : () {},
                      child: Stack(
                        children: [
                          IconsReuse(icons: Icons.shopping_cart_outlined),
                          drinksControl.totalQuantity >= 1
                              ? Positioned(
                                right: 0,
                                top: 0,
                                child: SuperscriptItemCount(
                                  text: drinksControl.totalQuantity.toString(),
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
            // This is used to set the main background image
            flexibleSpace: FlexibleSpaceBar(
              background: PreLoadingPage(
                imagePath:
                    '${ConstantData.BASE_URL}${ConstantData.UPLOAD_URL}${productLists.img}',
              ),
            ),
            //This is used to set the size of the bottom of the app bar
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(DynamicDimensions.size20),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: DynamicDimensions.size5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(DynamicDimensions.size20),
                    topLeft: Radius.circular(DynamicDimensions.size20),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.only(left: DynamicDimensions.size10),
                  child: MainText(
                    fontSize: DynamicDimensions.size26,
                    text: productLists.name ?? 'unknow',
                    maxLines: 2,
                  ),
                ),
              ),
            ),
          ),
          // This is setting off the body
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: DynamicDimensions.size10,
              ),
              child: AboutFoodText(text: productLists.description ?? 'unknow'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<MainFoodController>(
        builder: (cartItems) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: DynamicDimensions.size45,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        cartItems.getQuantity(false);
                        print(' The food list remove is tapped');
                      },
                      child: IconsReuse(
                        icons: Icons.remove,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: DynamicDimensions.size24,
                      ),
                    ),
                    MainText(
                      text:
                          '\$ ${productLists.price}   x  ${cartItems.cartItems}',
                      color: AppColors.mainBlackColor,
                      fontSize: DynamicDimensions.size26,
                    ),
                    GestureDetector(
                      onTap: () {
                        cartItems.getQuantity(true);
                        print('The food list add is tapped');
                      },
                      child: IconsReuse(
                        icons: Icons.add,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: DynamicDimensions.size24,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: DynamicDimensions.size10),
              Container(
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
                      padding: EdgeInsets.all(DynamicDimensions.size20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          DynamicDimensions.size20,
                        ),
                      ),
                      child: Icon(Icons.favorite, color: AppColors.mainColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        cartItems.addItems(productLists);
                        print('the food list add button is clicked');
                      },
                      child: Container(
                        padding: EdgeInsets.all(DynamicDimensions.size15),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(
                            DynamicDimensions.size20,
                          ),
                        ),
                        child: MainText(
                          text: '\$ ${productLists.price} |  Add to cart',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
