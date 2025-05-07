import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_items_controller.dart';
import 'package:food_app/data_process/repository/main_food_repo.dart';
import 'package:food_app/models/cart_items_model.dart';
import 'package:food_app/models/main_food_model.dart';
import 'package:food_app/utilities/colors.dart';
import 'package:get/get.dart';

class MainFoodController extends GetxController {
  final MainFoodRepo mainFoodRepo;

  MainFoodController({required this.mainFoodRepo});

  // the data gotten from the main food repo will be save in this list
  List<dynamic> _mainProductList = [];
  int _quantity = 0;
  bool _dataAvailable = false;
  int _cartItems = 0;
  late CartItemsController _cartItemsController =
      Get.find<CartItemsController>();

  //This will make the mainProductList generally available across the application...
  List<dynamic> get mainProductList => _mainProductList;
  int get quantity => _quantity;
  bool get dataAvailable => _dataAvailable;
  // This let the number of selected items to be globally available for use and display immediately for users to see the total number of items they have selected
  int get cartItems => _cartItems + _quantity;

  // This is helping us to get the data from the internet and saving it for local use in the app
  Future<void> getMainProductList() async {
    Response response = await mainFoodRepo.getMainProductList();

    if (response.statusCode == 200) {
      // why initialize to null here is to avoid duplicate data ... cause the method might be called many times
      _mainProductList = [];
      _mainProductList.addAll(Product.fromJson(response.body).products);
      _dataAvailable = true;
      update();
    } else {
      print("❌ Error getting products:");
      print("Status Code: ${response.statusCode}");
      print("Status Text: ${response.statusText}");
      print("Response Body: ${response.body}");
    }
  }

  void getQuantity(bool isIncreased) {
    if (isIncreased) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  void resetProductData(
    ProductsModel product,
    CartItemsController cartItemsController,
  ) {
    _quantity = 0;
    _cartItems = 0;
    _cartItemsController = cartItemsController;
    var yesCart = false;
    yesCart = _cartItemsController.inCart(product);
    if (yesCart) {
      _cartItems = _cartItemsController.getQuantity(product);
    }
  }

  void addItems(ProductsModel products) {
    _cartItemsController.addCartItem(products, _quantity);
    if (_quantity > 1) {
      Get.snackbar(
        'Added',
        '$quantity quantity added to ${products.name}',
        icon: Icon(Icons.check, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: AppColors.mainColor,
        duration: Duration(milliseconds: 700),
      );
    } else if (_quantity < 1 && _quantity != 0) {
      Get.snackbar(
        'Added',
        '${quantity.abs()} quantity is removed from the  ${products.name}',
        icon: Icon(Icons.check, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: AppColors.mainColor,
        duration: Duration(seconds: 1),
      );
    }
    //In other to make the quantity zero after adding to avoid duplicate addition...
    _quantity = 0;
    _cartItems = _cartItemsController.getQuantity(products);

    // To get access to each data of the items  inside the cart item we loop through each data in the map...
    _cartItemsController.cartItems.forEach((key, value) {
      print(
        'The Id of this product is ${value.id} and the quantity is ${value.quantity}',
      );
    });
    update();
  }

  int checkQuantity(int quantity) {
    if ((_cartItems + quantity) < 0) {
      Get.snackbar(
        'Limit',
        'You cant reduce more',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 1),
        icon: Icon(Icons.error, color: Colors.red),
        backgroundColor: AppColors.mainColor,
        colorText: AppColors.mainBlackColor,
      );
      // This help us to make sure the cart is zero after we tried to reduce the quantity to zero by adding the negative number of the previous items in the cart...
      if (_cartItems > 0) {
        _quantity = -_cartItems;
        return _quantity;
      }

      return 0;
    } else if ((_cartItems + quantity) > 20) {
      Get.snackbar(
        'Limit',
        'The Quantity cant be more than 20',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 1),
        icon: Icon(Icons.error, color: Colors.red),
        backgroundColor: AppColors.mainColor,
        colorText: AppColors.mainBlackColor,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  // this will call for for the total items in the cart controller and this will let is be able to access it from the UI

  int get totalQuantity {
    return _cartItemsController.totalItemQuantity;
  }

  List<CartItemsModel> get getCartItems {
    return _cartItemsController.getCartItem;
  }
}
