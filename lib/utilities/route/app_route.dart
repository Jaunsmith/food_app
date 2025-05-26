import 'package:food_app/screens/auth/sign_in_screen.dart';
import 'package:food_app/screens/cart/cart_picked_item_screen.dart';
import 'package:food_app/screens/home/details/drinks_screen_details.dart';
import 'package:food_app/screens/home/home_page_screen.dart';
import 'package:food_app/screens/home/details/food_list_screen_details.dart';
import 'package:food_app/screens/home/details/main_food_screen_details.dart';

import 'package:food_app/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

import '../../screens/address/delivery_address_screen.dart';

class AppRoute {
  static const String initial = '/';
  static const String splashScreen = '/splash-screen';
  static const String mainFoodPage = '/main-food-page';
  static const String foodListPage = '/food-list-page';
  static const String cartItemsPage = '/cart-items-page';
  static const String signInPage = '/sign-in-page';
  static const String drinksScreen = '/drinks-screen';
  static const String locationScreen = '/location-screen';

  // Function is being used in other to be able pass parameter to the path and be able to use for diff purposes
  static String getInitialPage() => '$initial';

  static String getSplashscreen() => '$splashScreen';

  static String getSignInPage() => '$signInPage';

  static String getDeliveryScreen() => '$locationScreen';

  // To pass data into the function and make it available you use it  within this class like this ...
  static String getMainFoodPage(int index, String cartPage) =>
      // Anytime passing and parameter from a function first is ? rest will be gotten with &
      // this also help us to be able to display this particular screen in any places
      '$mainFoodPage?index=$index&cartPage=$cartPage';

  static String getFoodListPage(int indexFoodList, String foodListPageR) =>
      '$foodListPage?indexFoodList=$indexFoodList&foodListPageR=$foodListPageR';

  static String getDrinksListPage(int indexDrinkList, String drinkListPageR) =>
      '$drinksScreen?indexDrinkList=$indexDrinkList&drinkListPageR=$drinkListPageR';

  static String getCartItemsPage() => '$cartItemsPage';

  //  This make out routing very organizing and easy to use anywhere within the app and also faster...
  static List<GetPage> routes = [
    GetPage(name: initial, page: () => HomePage()),
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: locationScreen, page: () => DeliveryAddressScreen()),
    GetPage(
      name: signInPage,
      page: () => SignInScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(seconds: 3),
    ),
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
      name: drinksScreen,
      transition: Transition.rightToLeftWithFade,
      transitionDuration: Duration(seconds: 2),
      page: () {
        var indexDrinkList = Get.parameters['indexDrinkList'];
        var drinkListPageR = Get.parameters['drinkListPageR'];
        print('now routed to the drink details page');
        return DrinksScreenDetails(
          index: int.parse(indexDrinkList!),
          drinkListPage: drinkListPageR!,
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
