import 'package:flutter/material.dart';
import 'package:food_app/controllers/drinks_controller.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';
import 'package:food_app/widgets/custom_loader.dart';
import 'package:get/get.dart';

import '../../../utilities/colors.dart';
import '../../../utilities/constant_data.dart';
import '../../../utilities/route/app_route.dart';
import '../../../widgets/icon_text.dart';
import '../../../widgets/main_text.dart';
import '../../../widgets/pre_loading_page.dart';
import '../../../widgets/sub_text.dart';

class DrinksScreen extends StatefulWidget {
  const DrinksScreen({super.key});

  @override
  State<DrinksScreen> createState() => _DrinksScreenState();
}

class _DrinksScreenState extends State<DrinksScreen> {
  final DrinksController drinksController = Get.find();

  @override
  void initState() {
    super.initState();
    drinksController.getProductDrinkList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DrinksController>(
      builder: (drinksControl) {
        if (!drinksControl.dataAvailable &&
            drinksControl.productDrinksList.isEmpty) {
          return Center(child: CustomLoader());
        } else {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: DynamicDimensions.size10),
            shrinkWrap: true,
            itemCount: drinksControl.productDrinksList.length,
            itemBuilder: (context, index) {
              final drinks = drinksControl.productDrinksList[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoute.getDrinksListPage(index, ''));
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: DynamicDimensions.size10,
                    right: DynamicDimensions.size10,
                    bottom: DynamicDimensions.size10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                              '${ConstantData.BASE_URL}${ConstantData.UPLOAD_URL}${drinks.img}',
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: DynamicDimensions.size120,
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
                            padding: EdgeInsets.only(
                              bottom: DynamicDimensions.size20,
                              left: DynamicDimensions.size10,
                              right: DynamicDimensions.size10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MainText(text: drinks.name ?? 'Unknown'),
                                SizedBox(height: DynamicDimensions.size10),
                                SubText(
                                  text: drinks.description ?? 'unknown',
                                  maxLines: 1,
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
