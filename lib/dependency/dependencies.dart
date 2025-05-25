import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/controllers/cart_items_controller.dart';
import 'package:food_app/controllers/drinks_controller.dart';
import 'package:food_app/controllers/food_list_controller.dart';
import 'package:food_app/controllers/delivery_address_controller.dart';
import 'package:food_app/controllers/main_food_controller.dart';
import 'package:food_app/controllers/user_controller.dart';
import 'package:food_app/data_process/api/api_client.dart';
import 'package:food_app/data_process/repository/auth_repo.dart';
import 'package:food_app/data_process/repository/cart_items_repo.dart';
import 'package:food_app/data_process/repository/drinks_repo.dart';
import 'package:food_app/data_process/repository/food_list_repo.dart';
import 'package:food_app/data_process/repository/delivery_address_repo.dart';
import 'package:food_app/data_process/repository/main_food_repo.dart';
import 'package:food_app/data_process/repository/user_repo.dart';
import 'package:food_app/utilities/constant_data.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This file we are loading all the necessary tools needed...and help us to connect them all together
Future<void> init() async {
  // This help us to store data locally...
  final sharedPreferences = await SharedPreferences.getInstance();

  // Loading it into the  state management so that it can be use any where in out app
  Get.lazyPut(() => sharedPreferences);

  //apiclient
  // The sharedpreference is being loaded asap the app start.. for authentication
  Get.lazyPut(
    () => ApiClient(
      appBaseUrl: ConstantData.BASE_URL,
      sharedPreferences: Get.find(),
    ),
  );
  Get.lazyPut(
    () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()),
  );

  // since the repo takes apiclient the get.find help us to locate it and load it to the repo...
  // kindly note the name must match the name you use to initialize the file for instance here the name we used to initialize the Apiclient in the repo is apiclient with this the getx will be able to help us find it..
  Get.lazyPut(() => MainFoodRepo(apiClient: Get.find()));
  Get.lazyPut(() => FoodListRepo(apiClient: Get.find()));
  Get.lazyPut(() => DrinksRepo(apiClient: Get.find()));
  // This help to pass the package to cart repo after it has been loaded..
  Get.lazyPut(() => CartItemsRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => DeliveryAddressRepo(sharedPreferences: Get.find()));

  // controllers
  Get.lazyPut(() => MainFoodController(mainFoodRepo: Get.find()));
  Get.lazyPut(() => FoodListController(foodListRepo: Get.find()));
  Get.lazyPut(() => DrinksController(drinksRepo: Get.find()));
  Get.lazyPut(() => CartItemsController(cartItemsRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => DeliveryAddressController(deliveryAddressRepo: Get.find()));
}
