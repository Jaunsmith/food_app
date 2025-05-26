import 'package:flutter/material.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/controllers/cart_items_controller.dart';
import 'package:food_app/controllers/food_list_controller.dart';
import 'package:food_app/controllers/main_food_controller.dart';
import 'package:food_app/utilities/colors.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';
import 'package:food_app/utilities/route/app_route.dart';
import 'package:food_app/widgets/empty_data.dart';
import 'package:food_app/widgets/icons_reuse.dart';
import 'package:food_app/widgets/main_text.dart';
import 'package:food_app/widgets/pre_loading_page.dart';
import 'package:food_app/widgets/sub_text.dart';
import 'package:get/get.dart';

import '../../utilities/constant_data.dart';
import '../../widgets/show_error_messages.dart';
import '../../widgets/superscript_item_count.dart';

class CartPickedItem extends StatelessWidget {
  const CartPickedItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // stack give us a lot of control on where a particular widget should be...
      body: Stack(
        children: [
          Positioned(
            left: DynamicDimensions.size20,
            right: DynamicDimensions.size20,
            top: DynamicDimensions.size30 * 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: IconsReuse(
                    icons: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: DynamicDimensions.size24,
                  ),
                ),
                SizedBox(width: DynamicDimensions.size100),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoute.getInitialPage());
                  },
                  child: IconsReuse(
                    icons: Icons.home_filled,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: DynamicDimensions.size24,
                  ),
                ),
                GetBuilder<MainFoodController>(
                  builder: (productsController) {
                    return Stack(
                      children: [
                        IconsReuse(icons: Icons.shopping_cart_outlined),
                        productsController.totalQuantity >= 1
                            ? Positioned(
                              right: 0,
                              top: 0,
                              child: SuperscriptItemCount(
                                text:
                                    productsController.totalQuantity.toString(),
                              ),
                            )
                            : Container(),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          GetBuilder<CartItemsController>(
            builder: (controller) {
              return controller.getCartItem.isNotEmpty
                  ? Positioned(
                    top: DynamicDimensions.size100,
                    left: DynamicDimensions.size20,
                    right: DynamicDimensions.size20,
                    bottom: 0,
                    child: Container(
                      // The media query helps to remove the padding auto set for listview builder
                      margin: EdgeInsets.only(top: DynamicDimensions.size20),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                left: DynamicDimensions.size5,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  DynamicDimensions.size10,
                                ),
                                color: AppColors.mainColor,
                              ),
                              child: MainText(
                                text:
                                    'You can only order  maximum of 20 quantity per items',
                                maxLines: 2,
                                fontSize: DynamicDimensions.size24,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: DynamicDimensions.size15),
                            Expanded(
                              child: GetBuilder<CartItemsController>(
                                builder: (cartItems) {
                                  return ListView.builder(
                                    itemCount: cartItems.getCartItem.length,
                                    itemBuilder: (_, index) {
                                      return Container(
                                        height: DynamicDimensions.size100,
                                        width: double.maxFinite,
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                // the concept here help us to locate the controller and pass the object to it to get the index of the object gotten from the project model based on data stored in the items and later based on the items display in the cart item page
                                                int mainFoodIndex = Get.find<
                                                      MainFoodController
                                                    >()
                                                    .mainProductList
                                                    .indexOf(
                                                      cartItems
                                                          .getCartItem[index]
                                                          .productsModel!,
                                                    );
                                                // the if statement try to check to know which object we making reference to at a point in time either the food list or the main food
                                                if (mainFoodIndex >= 0) {
                                                  Get.toNamed(
                                                    AppRoute.getMainFoodPage(
                                                      mainFoodIndex,
                                                      'cartPage',
                                                    ),
                                                  );
                                                } else {
                                                  int foodListIndex = Get.find<
                                                        FoodListController
                                                      >()
                                                      .foodListProductList
                                                      .indexOf(
                                                        cartItems
                                                            .getCartItem[index]
                                                            .productsModel!,
                                                      );
                                                  if (foodListIndex < 0) {
                                                    Get.snackbar(
                                                      '',
                                                      '',
                                                      titleText: MainText(
                                                        text: 'History Data',
                                                        color: Colors.white,
                                                      ),
                                                      messageText: SubText(
                                                        text:
                                                            'You cant review this items for now',
                                                        color: Colors.white,
                                                        fontSize:
                                                            DynamicDimensions
                                                                .size16,
                                                      ),
                                                      backgroundColor:
                                                          AppColors.mainColor,
                                                      icon: Icon(
                                                        Icons.cancel,
                                                        color: Colors.redAccent,
                                                      ),
                                                    );
                                                  } else {
                                                    Get.toNamed(
                                                      AppRoute.getFoodListPage(
                                                        foodListIndex,
                                                        'foodListPage',
                                                      ),
                                                    );
                                                  }
                                                }
                                              },
                                              child: Container(
                                                height:
                                                    DynamicDimensions.size100,
                                                width:
                                                    DynamicDimensions.size100,
                                                margin: EdgeInsets.only(
                                                  bottom:
                                                      DynamicDimensions.size10,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        DynamicDimensions
                                                            .size20,
                                                      ),
                                                  color: Colors.white,
                                                ),
                                                child: PreLoadingPage(
                                                  imagePath:
                                                      '${ConstantData.BASE_URL}${ConstantData.UPLOAD_URL}${cartItems.getCartItem[index].img}',
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: DynamicDimensions.size10,
                                            ),
                                            Expanded(
                                              child: Container(
                                                height:
                                                    DynamicDimensions.size100,
                                                margin: EdgeInsets.only(),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    MainText(
                                                      text:
                                                          cartItems
                                                              .getCartItem[index]
                                                              .name!,
                                                      color: Colors.black54,
                                                    ),
                                                    SubText(text: 'Spicy'),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        MainText(
                                                          text:
                                                              '\$${cartItems.getCartItem[index].price}',
                                                          color:
                                                              Colors.redAccent,
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets.symmetric(
                                                            horizontal:
                                                                DynamicDimensions
                                                                    .size78,
                                                            vertical:
                                                                DynamicDimensions
                                                                    .size78,
                                                          ),
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  DynamicDimensions
                                                                      .size15,
                                                                ),
                                                          ),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  cartItems.addCartItem(
                                                                    cartItems
                                                                        .getCartItem[index]
                                                                        .productsModel!,
                                                                    -1,
                                                                  );
                                                                },
                                                                child: Icon(
                                                                  Icons.remove,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    DynamicDimensions
                                                                        .size10,
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets.only(
                                                                  top:
                                                                      DynamicDimensions
                                                                          .size5,
                                                                ),
                                                                child: MainText(
                                                                  text:
                                                                      cartItems
                                                                          .getCartItem[index]
                                                                          .quantity
                                                                          .toString(),
                                                                  fontSize:
                                                                      DynamicDimensions
                                                                          .size15,
                                                                  color:
                                                                      AppColors
                                                                          .mainColor,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    DynamicDimensions
                                                                        .size10,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  cartItems.addCartItem(
                                                                    cartItems
                                                                        .getCartItem[index]
                                                                        .productsModel!,
                                                                    cartItems.getCartItem[index].quantity! >=
                                                                            20
                                                                        ? 0
                                                                        : 1,
                                                                  );
                                                                },
                                                                child: Icon(
                                                                  Icons.add,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  : EmptyData(text: 'Cart is Empty!!!');
            },
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartItemsController>(
        builder: (cartItemsPage) {
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
            child:
                cartItemsPage.getCartItem.isNotEmpty
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(DynamicDimensions.size15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              DynamicDimensions.size10,
                            ),
                          ),
                          child: MainText(
                            text: '\$ ${cartItemsPage.totalPriceOfProduct}',
                            color: AppColors.mainColor,
                            fontSize: DynamicDimensions.size20,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (Get.find<AuthController>().userLoggedIn()) {
                              cartItemsPage.getPickedItemsData();
                              showErrorMessage(
                                'Kindly add or preview Delivery details',
                                title: 'Delivery Details',
                                icons: Icons.location_history_rounded,
                                color: AppColors.mainColor,
                                time: 3,
                              );
                              Get.toNamed(AppRoute.getDeliveryScreen());
                            } else {
                              showErrorMessage(
                                'You need to SignIn to your account',
                                title: 'LogIn',
                                icons: Icons.close,
                                iconColor: Colors.white,
                                time: 3,
                              );
                              Get.toNamed(AppRoute.getSignInPage());
                            }

                            print('check out clicked');
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
                              text: 'Check Out',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                    : Container(),
          );
        },
      ),
      // bottomNavigationBar: Container(),
    );
  }
}
