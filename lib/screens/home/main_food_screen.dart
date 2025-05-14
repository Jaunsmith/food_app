import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:food_app/utilities/colors.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';
import 'package:food_app/widgets/main_text.dart';
import 'package:food_app/widgets/sub_text.dart';
import 'package:get/get.dart';

import '../../controllers/food_list_controller.dart';
import '../../controllers/main_food_controller.dart';
import 'body/food_page_screen.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  late String _dayName = '';
  late String _dateFormat = '';
  late String _timeFormat;
  late Timer _timer;

  void getDate() {
    DateTime dateTime = DateTime.now();
    //This help in auto rendering the variable so that can display the latest time...
    setState(() {
      _dayName = DateFormat('EEE').format(dateTime);
      _dateFormat = DateFormat('dd/MM/yy ').format(dateTime);
      _timeFormat = DateFormat('hh:mm:ss a').format(dateTime);
    });
  }

  Future<void> _loadData() async {
    await Get.find<MainFoodController>().getMainProductList();
    await Get.find<FoodListController>().getFoodListProductList();
  }

  // This help in auto updating the time
  @override
  void initState() {
    super.initState();
    getDate();
    _timer = Timer.periodic(Duration(seconds: 1), (duration) => getDate());
  }

  @override
  void dispose() {
    _timer.cancel(); // clean up the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getDate();
    return RefreshIndicator(
      color: AppColors.mainColor,
      onRefresh: _loadData,
      child: Column(
        children: [
          //The header part of the home page...
          Container(
            // this will be used later....
            child: Container(
              margin: EdgeInsets.only(
                top: DynamicDimensions.size45,
                bottom: DynamicDimensions.size15,
              ),
              padding: EdgeInsets.only(
                left: DynamicDimensions.size20,
                right: DynamicDimensions.size20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      MainText(text: 'Nigeria', color: AppColors.mainColor),
                      Row(
                        children: [
                          SubText(text: 'Osun'),
                          Icon(Icons.arrow_drop_down_rounded),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: DynamicDimensions.size10),
                    child: Column(
                      children: [
                        MainText(
                          text: '$_dayName, $_dateFormat',
                          color: AppColors.mainColor,
                        ),
                        MainText(text: _timeFormat, color: AppColors.mainColor),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      width: DynamicDimensions.size45,
                      height: DynamicDimensions.size45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          DynamicDimensions.size15,
                        ),
                        color: AppColors.mainColor,
                      ),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: DynamicDimensions.size24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // The body of the home page
          // The whole food page Need to be scrollable and also maintain its space
          Expanded(child: SingleChildScrollView(child: FoodPage())),
        ],
      ),
    );
  }
}
