import 'package:flutter/material.dart';
import 'package:food_app/data_process/repository/cart_items_repo.dart';
import 'package:food_app/models/cart_items_model.dart';
import 'package:food_app/models/main_food_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../utilities/colors.dart';

class CartItemsController extends GetxController {
  final CartItemsRepo cartItemsRepo;

  CartItemsController({required this.cartItemsRepo});
  // Making the variable private
  late Map<int, CartItemsModel> _cartItems = {};

  Map<int, CartItemsModel> get cartItems => _cartItems;

  // This stored the data gotten from the storage
  List<CartItemsModel> storageItems = [];

  // This is the function that will be called and add items to the cart list...
  void addCartItem(ProductsModel products, int quantity) {
    // This track the state of the quantity checking if zero
    // This help us to get the date and time in format we want
    DateTime dateTime = DateTime.now();
    String date = DateFormat('dd/MM/yyyy  hh:mm a').format(dateTime);

    int totalQuantity = 0;
    if (_cartItems.containsKey(products.id!)) {
      _cartItems.update(products.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartItemsModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: date,
          // this is the part that give us access to the main food controller
          productsModel: products,
        );
      });
      // this tried to remove the data if the total quantity is zero ..
      if (totalQuantity <= 0) {
        _cartItems.remove(products.id);
        print('this item with ID: ${products.id} has been removed');
      }
    } else {
      if (quantity > 0) {
        _cartItems.putIfAbsent(products.id!, () {
          return CartItemsModel(
            id: products.id,
            name: products.name,
            price: products.price,
            img: products.img,
            quantity: quantity,
            isExist: true,
            time: date,
            // this is the part that give us access to the main food controller
            productsModel: products,
          );
        });
      } else {
        Get.snackbar(
          'Error',
          '0 quantity cant be added',
          icon: Icon(Icons.error, color: Colors.red),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.red,
          backgroundColor: AppColors.mainColor,
        );
      }
    }
    // This pass the list of the items to the add to cart list.. so that it can be used over there
    cartItemsRepo.addItemsToStorage(getCartItem);
    update();
    print('Saved at: ${DateFormat('hh:mm:ss').format(DateTime.now())}');
  }

  // This is checking if the particular product already exist in the map already
  bool inCart(ProductsModel product) {
    if (_cartItems.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(ProductsModel product) {
    int quantity = 0;
    if (_cartItems.containsKey(product.id)) {
      _cartItems.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  // To get the total quantity of items...
  // The get let us return a field since no parameter is needed to pass to the function ...
  int get totalItemQuantity {
    int totalQuantity = 0;
    _cartItems.forEach((key, value) {
      totalQuantity += value.quantity ?? 0;
    });
    return totalQuantity;
  }

  // In other to get the list of item stored in the map...
  // and this list have all our stored data and also auto updating as we are updating anything in the app
  List<CartItemsModel> get getCartItem {
    // This give us access to loop through the map .. the 'e' is referring to both the key and value of the map
    return _cartItems.entries.map((e) => e.value).toList();
  }

  // this method get us the total sum of the product the user want ...

  int get totalPriceOfProduct {
    int totalPrice = 0;
    _cartItems.forEach((key, value) {
      // This will loop through each items in the map one by one
      int itemPrice = value.quantity! * value.price!;
      totalPrice = totalPrice + itemPrice;
    });
    return totalPrice;
  }

  // This help to get the data stored in the storage..
  // This will be get called immediately the application start in other to retrieve any previous data if available
  List<CartItemsModel> getStorageData() {
    setStorageItems = cartItemsRepo.getStorageItems();
    return storageItems;
  }

  // This help us to set the storage data that stored dat in it
  set setStorageItems(List<CartItemsModel> itemsStored) {
    storageItems = itemsStored;

    // This loop through the items store and stored it in the map if only the data is absent...

    for (int i = 0; i < storageItems.length; i++) {
      print(
        'The length of the already stored data is: ${storageItems.length} ',
      );
      // This will loop through the data retrieved and put it in the items crtItems cause at lunch is empty this will help us to be able to display the retrieved data
      _cartItems.putIfAbsent(
        storageItems[i].productsModel!.id!,
        () => storageItems[i],
      );
    }
  }

  void getPickedItemsData() {
    cartItemsRepo.addItemsToPickedStorage();
    clearCartData();
  }

  void clearCartData() {
    _cartItems = {};
    update();
  }

  List<CartItemsModel> getPickedItemsHistoryList() {
    return cartItemsRepo.getPickedItemsHistory();
  }

  set setItemsData(Map<int, CartItemsModel> setItemsData) {
    _cartItems = {};
    _cartItems = setItemsData;
  }

  // Updating the addItems again in other for the storage items to get updated..

  void addToStorageItems() {
    cartItemsRepo.addItemsToStorage(getCartItem);
    update();
  }
}
