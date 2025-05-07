import 'package:food_app/screens/cart/cart_picked_item_screen.dart';
import 'package:food_app/screens/home/home_page_screen.dart';
import 'package:food_app/screens/home/details/food_list_screen_details.dart';
import 'package:food_app/screens/home/details/main_food_screen_details.dart';

import 'package:food_app/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppRoute {
  static const String initial = '/';
  static const String splashScreen = '/splash-screen';
  static const String mainFoodPage = '/main-food-page';
  static const String foodListPage = '/food-list-page';
  static const String cartItemsPage = '/cart-items-page';

  // Function is being used in other to be able pass parameter to the path and be able to use for diff purposes
  static String getInitialPage() => '$initial';

  static String getSplashscreen() => '$splashScreen';

  // To pass data into the function and make it available you use it  within this class like this ...
  static String getMainFoodPage(int index, String cartPage) =>
      // Anytime passing and parameter from a function first is ? rest will be gotten with &
      // this also help us to be able to display this particular screen in any places
      '$mainFoodPage?index=$index&cartPage=$cartPage';

  static String getFoodListPage(int indexFoodList, String foodListPageR) =>
      '$foodListPage?indexFoodList=$indexFoodList&foodListPageR=$foodListPageR';

  static String getCartItemsPage() => '$cartItemsPage';

  //  This make out routing very organizing and easy to use anywhere within the app and also faster...
  static List<GetPage> routes = [
    GetPage(name: initial, page: () => HomePage()),
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(
      name: mainFoodPage,
      transition: Transition.fadeIn,
      transitionDuration: Duration(seconds: 2),
      page: () {
        print('now routed to the details page');
        var index = Get.parameters['index'];
        var indexCart = Get.parameters['cartPage'];
        return MainFoodDetails(
          index: int.parse(index!),
          foodListPage: indexCart!,
        );
      },
    ),
    GetPage(
      name: foodListPage,
      transition: Transition.leftToRightWithFade,
      transitionDuration: Duration(seconds: 2),
      page: () {
        var indexFoodList = Get.parameters['indexFoodList'];
        var foodListPageR = Get.parameters['foodListPageR'];
        print('now routed to the list details page');
        return FoodListPageDetails(
          index: int.parse(indexFoodList!),
          foodListPage: foodListPageR!,
        );
      },
    ),
    GetPage(
      transition: Transition.circularReveal,
      transitionDuration: Duration(seconds: 1),
      name: cartItemsPage,
      page: () {
        return CartPickedItem();
      },
    ),
  ];
}
