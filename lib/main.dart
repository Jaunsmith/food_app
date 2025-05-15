import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_items_controller.dart';
import 'package:food_app/controllers/food_list_controller.dart';
import 'package:food_app/controllers/main_food_controller.dart';
import 'package:food_app/screens/auth/sign_up_screen.dart';
import 'package:get/get.dart';
import 'package:food_app/dependency/dependencies.dart' as dependent;

Future<void> main() async {
  // This ensure the dependencies is loaded before it run the application...
  WidgetsFlutterBinding.ensureInitialized();
  await dependent.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
              home: SignUpScreen(),
              // initialRoute: AppRoute.getInitialPage(),
              // getPages: AppRoute.routes,
            );
          },
        );
      },
    );
  }
}
