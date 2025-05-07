import 'package:flutter/material.dart';
import 'package:food_app/controllers/food_list_controller.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';
import 'package:food_app/utilities/route/app_route.dart';
import 'package:food_app/widgets/main_text.dart';
import 'package:food_app/widgets/pre_loading_page.dart';
import 'package:food_app/widgets/sub_text.dart';
import 'package:get/get.dart';
import '../../../utilities/colors.dart';
import '../../../utilities/constant_data.dart';
import '../../../widgets/icon_text.dart';

Widget foodListPage() {
  return GetBuilder<FoodListController>(
    builder: (foodListProduct) {
      return foodListProduct.dataAvailable
          ? ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: foodListProduct.foodListProductList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoute.getFoodListPage(index, ''));
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: DynamicDimensions.size20,
                    right: DynamicDimensions.size20,
                    bottom: DynamicDimensions.size10,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: DynamicDimensions.size120,
                        width: DynamicDimensions.size120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            DynamicDimensions.size20,
                          ),
                          color:
                              index.isEven
                                  ? Colors.grey.shade200
                                  : Colors.purpleAccent.shade100,
                        ),
                        child: PreLoadingPage(
                          imagePath:
                              '${ConstantData.BASE_URL}${ConstantData.UPLOAD_URL}${foodListProduct.foodListProductList[index].img}',
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: DynamicDimensions.size100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(
                                DynamicDimensions.size20,
                              ),
                              bottomRight: Radius.circular(
                                DynamicDimensions.size20,
                              ),
                            ),
                            color: Colors.white60,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: DynamicDimensions.size10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MainText(
                                  text:
                                      foodListProduct
                                          .foodListProductList[index]
                                          .name,
                                ),
                                SizedBox(height: DynamicDimensions.size10),
                                SubText(text: 'with Chinese characteristics'),
                                SizedBox(height: DynamicDimensions.size10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
          : Center(
            child: CircularProgressIndicator(color: AppColors.mainColor),
          );
    },
  );
}
