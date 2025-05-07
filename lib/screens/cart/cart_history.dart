import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_items_controller.dart';
import 'package:food_app/models/cart_items_model.dart';
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

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        // the reversed help to let the latest data be at the top while the to list help to convert it back to list so that it can be access via index
        Get.find<CartItemsController>()
            .getPickedItemsHistoryList()
            .reversed
            .toList();

    Map<String, int> cartItemsPerOrder = {};

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
          getCartHistoryList[i].time!,
          (value) => ++value,
        );
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<int> orderTimes = cartItemsPerOrderToList();

    List<String> cartOrderTimesToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<String> orderTimesList = cartOrderTimesToList();

    int counter = 0;

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.infinity,
            height: DynamicDimensions.size100,
            padding: EdgeInsets.only(
              left: DynamicDimensions.size30,
              top: DynamicDimensions.size45,
              right: DynamicDimensions.size30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainText(text: 'Cart Histories', color: Colors.white),
                IconsReuse(
                  icons: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                  iconSize: DynamicDimensions.size24,
                ),
              ],
            ),
          ),
          getCartHistoryList.isNotEmpty
              ? Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    top: DynamicDimensions.size20,
                    left: DynamicDimensions.size20,
                    right: DynamicDimensions.size20,
                  ),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView(
                      children: [
                        for (int i = 0; i < orderTimes.length; i++)
                          Container(
                            height: DynamicDimensions.size120,
                            margin: EdgeInsets.only(
                              bottom: DynamicDimensions.size20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MainText(
                                  text: getCartHistoryList[counter].time!,
                                ),
                                SizedBox(height: DynamicDimensions.size5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                      direction: Axis.horizontal,
                                      children: List.generate(orderTimes[i], (
                                        index,
                                      ) {
                                        if (counter <
                                            getCartHistoryList.length) {
                                          counter++;
                                        }
                                        return index <= 2
                                            ? Container(
                                              height: DynamicDimensions.size80,
                                              width: DynamicDimensions.size80,
                                              margin: EdgeInsets.only(
                                                right: DynamicDimensions.size5,
                                              ),
                                              child: PreLoadingPage(
                                                imagePath:
                                                    '${ConstantData.BASE_URL}${ConstantData.UPLOAD_URL}${getCartHistoryList[counter - 1].img}',
                                                borderRadius:
                                                    DynamicDimensions.size10,
                                              ),
                                            )
                                            : Container();
                                      }),
                                    ),
                                    Container(
                                      height: DynamicDimensions.size80,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SubText(
                                            text: 'Total',
                                            color: AppColors.titleColor,
                                          ),
                                          MainText(
                                            text: '${orderTimes[i]} times',
                                            color: AppColors.titleColor,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              // in other to be able to update the screen that go back to the cart history for more details

                                              Map<int, CartItemsModel>
                                              moreDetailsOrder = {};
                                              // The data in the getcartHistory list need to be pass to our main map displaying the items in the cart screen..and this will be compare with the time in other to know which one we are on
                                              for (
                                                int k = 0;
                                                k < getCartHistoryList.length;
                                                k++
                                              ) {
                                                if (getCartHistoryList[k]
                                                        .time ==
                                                    orderTimesList[i]) {
                                                  moreDetailsOrder.putIfAbsent(
                                                    getCartHistoryList[k].id!,
                                                    () => CartItemsModel.fromJson(
                                                      jsonDecode(
                                                        jsonEncode(
                                                          getCartHistoryList[k],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              }

                                              //print(
                                              //   'The order times of each  checked out items is ${orderTimesList[i]}',
                                              // );
                                              print('You clicked me ');
                                              // This send the data over to the setter set in the cart controller so that the UI can have access to it ... since both are map just equate them
                                              Get.find<CartItemsController>()
                                                      .setItemsData =
                                                  moreDetailsOrder;
                                              // This called the addtostorage so that the stored data can be updated!!!
                                              Get.find<CartItemsController>()
                                                  .addToStorageItems();

                                              Get.toNamed(
                                                AppRoute.getCartItemsPage(),
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(
                                                DynamicDimensions.size5,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1.5,
                                                  color: AppColors.mainColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      DynamicDimensions.size5,
                                                    ),
                                              ),
                                              child: SubText(
                                                text: 'more Items',
                                                color: AppColors.mainColor,
                                              ),
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
                      ],
                    ),
                  ),
                ),
              )
              : Container(
                height: DynamicDimensions.image550,
                child: Center(
                  child: EmptyData(
                    text: 'History is empty',
                    imagePath: 'assets/image/empty_box.png',
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
