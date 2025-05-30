import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_items_controller.dart';
import 'package:food_app/controllers/food_list_controller.dart';
import 'package:food_app/controllers/main_food_controller.dart';

import 'package:get/get.dart';
import 'package:food_app/dependency/dependencies.dart' as dependent;

import 'package:food_app/utilities/route/app_route.dart';

Future<void> main() async {
  // This ensure the dependencies is loaded before it run the application...
  WidgetsFlutterBinding.ensureInitialized();
  await dependent.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // This called the data asap our app is load
    Get.find<CartItemsController>().getStorageData();
    // This is called here so that the product list can be readily available for use in the application
    // and this is the convention to find a controller in flutter using getX package...
    return GetBuilder<MainFoodController>(
      builder: (_) {
        return GetBuilder<FoodListController>(
          builder: (_) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Food Delivery',
              // home: DeliveryAddressScreen(),
              initialRoute: AppRoute.getSplashscreen(),
              getPages: AppRoute.routes,
            );
          },
        );
      },
    );
  }
}
