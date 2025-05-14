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

class FoodListPage extends StatefulWidget {
  const FoodListPage({super.key});

  @override
  State<FoodListPage> createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  final FoodListController foodListController = Get.find();

  @override
  void initState() {
    super.initState();
    foodListController.getFoodListProductList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodListController>(
      builder: (foodListProduct) {
        if (!foodListProduct.dataAvailable &&
            foodListProduct.foodListProductList.isEmpty) {
          return Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: AppColors.mainColor,
              strokeWidth: 10,
            ),
          );
        } else {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: foodListProduct.foodListProductList.length,
            itemBuilder: (context, index) {
              final food = foodListProduct.foodListProductList[index];
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
                              '${ConstantData.BASE_URL}${ConstantData.UPLOAD_URL}${food.img}',
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
                                MainText(text: food.name ?? 'Unknown'),
                                SizedBox(height: DynamicDimensions.size10),
                                const SubText(
                                  text: 'with Chinese characteristics',
                                ),
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
          );
        }
      },
    );
  }
}
