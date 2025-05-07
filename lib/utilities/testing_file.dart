/*
// CartItems Models part
// This is need to be created in other to make the data globally available and also to be able to store datra back to the server
// THe product model is added in other to be able to access the product controller from the cart controller
import 'package:food_app/models/main_food_model.dart';

class CartItemsModel {
  int? id;
  String? name;
  int? price;
  String? img;
  String? createdAt;
  String? updatedAt;
  int? quantity;
  bool? isExist;
  String? time;
  ProductsModel? productsModel;

  CartItemsModel({
    this.id,
    this.name,
    this.price,
    this.img,
    this.createdAt,
    this.updatedAt,
    this.quantity,
    this.time,
    this.isExist,
    this.productsModel,
  });

  // Converting a Json to an object...
  CartItemsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    time = json['time'];
    isExist = json['isExist'];
    // It need to be converted to a json ..
    productsModel = ProductsModel.fromJson(json['productsModel']);
  }

  // converting from object to Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'img': img,
      'quantity': quantity,
      'isExit': isExist,
      'time': time,
      'productsModel': productsModel!.toJson(),
    };
  }
}



//Cart controller part
import 'package:flutter/material.dart';
import 'package:food_app/data_process/repository/cart_items_repo.dart';
import 'package:food_app/models/cart_items_model.dart';
import 'package:food_app/models/main_food_model.dart';
import 'package:get/get.dart';

import '../utilities/colors.dart';

class CartItemsController extends GetxController {
  final CartItemsRepo cartItemsRepo;

  @override
  void onInit() {
    super.onInit();
    getCartData(); // Load cart items from local storage
  }

  CartItemsController({required this.cartItemsRepo});
  // Making the variable private
  late Map<int, CartItemsModel> _cartItems = {};

  Map<int, CartItemsModel> get cartItems => _cartItems;

  List<CartItemsModel> storedData = [];

  // This is the function that will be called and add items to the cart list...
  void addCartItem(ProductsModel products, int quantity) {
    // This track the state of the quantity checking if zero
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
          time: '',
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
            time: '',
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
    // This pass the list of the items to the addtocardlist.. so that it can be used over there
    cartItemsRepo.addToCartList(getCartItem);

    update();
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

  // This is called immediately the application start cos this get us any previous data if available and if yes it will be displayed and also be used for some certain functionality
  List<CartItemsModel> getCartData() {
    // This get the list of the data stored and set it to the setCartItems...
    setCartItems = cartItemsRepo.getCartItemList();
    return storedData;
  }

  set setCartItems(List<CartItemsModel> items) {
    storedData = items;
    print('The length of the cart item is ${storedData.length}');
    for (int i = 0; i < storedData.length; i++) {
      _cartItems.putIfAbsent(
        storedData[i].productsModel!.id!,
            () => storedData[i],
      );
    }
  }

  void getCartListHistory() {
    cartItemsRepo.addToHistoryScreen();
    remove();
    displayData();
  }

  // This remove the data from the cart item picked screen
  void remove() {
    _cartItems = {};
    update();
  }

  void displayData() {
    cartItemsRepo.getCartItemHistory();
  }

  List<CartItemsModel> getCartItemHistoryList() {
    return cartItemsRepo.getCartItemHistory();
  }
}


// cart repo part
import 'dart:convert';

import 'package:food_app/models/cart_items_model.dart';
import 'package:food_app/utilities/constant_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class CartItemsRepo {
  final SharedPreferences sharedPreferences;
  CartItemsRepo({required this.sharedPreferences});

  // The shared preference save data as string ...
  // Global variable that save it globally for general use within the app
  List<String> cartListItems = [];
  List<String> cartHistoryItems = [];

  // This crap  the data and saved it in the preference
  void addToCartList(List<CartItemsModel> cartList) {
    // the whole data need to be remove first time....
    // sharedPreferences.remove(ConstantData.cartListItem);
    // sharedPreferences.remove(ConstantData.cartHistoryItem);
    // this will be use a lot of time so anytime calling this function will want to make sure the cart list is empty
    cartListItems = [];
    DateTime time = DateTime.now();
    String dateFormat = DateFormat('dd/MM/yyyy  hh:mm a').format(time);

    for (var e in cartList) {
      // This reset the time field and make sure they all have same time at the point of check out...
      e.time = dateFormat;
      // this will help to convert the cart model object to a string .. so that it can be added to the local storage @shared preference which take only string...
      print('The time is $dateFormat');
      cartListItems.add(jsonEncode(e));
    }
    // This save the data in the shared preference which in turn phone memory..
    sharedPreferences.setStringList(ConstantData.cartListItem, cartListItems);
    //print(sharedPreferences.getStringList('Cart-List_items'));
    // getCartItemList();
  }

  // This help to save the data in string to object format .... basically retried data fromm the local storage...
  List<CartItemsModel> getCartItemList() {
    // This is the local variable...
    List<String> carts = [];
    if (sharedPreferences.containsKey(ConstantData.cartListItem)) {
      carts = sharedPreferences.getStringList(ConstantData.cartListItem)!;
      //print('inside the get cartItems: $carts');
    }
    // since we need to return a model instead of list of string the string will now be turn to a model ...
    List<CartItemsModel> cartListItemData = [];
    for (var e in carts) {
      cartListItemData.add(CartItemsModel.fromJson(jsonDecode(e)));
    }
    return cartListItemData;
  }

  // in other to get the data and display it on the history screen....
  void addToHistoryScreen() {
    if (sharedPreferences.containsKey(ConstantData.cartHistoryItem)) {
      cartHistoryItems =
      sharedPreferences.getStringList(ConstantData.cartHistoryItem)!;
    }
    for (int i = 0; i < cartListItems.length; i++) {
      cartHistoryItems.add(cartListItems[i]);
    }
    removeCartData();
    sharedPreferences.setStringList(
      ConstantData.cartHistoryItem,
      cartHistoryItems,
    );
    print('The cart History data is:  $cartHistoryItems');
  }

  void removeCartData() {
    cartListItems = [];
    sharedPreferences.remove(ConstantData.cartListItem);
    print('The history length is  : ${getCartItemHistory().length}');

    for (int j = 0; j < getCartItemHistory().length; j++) {
      print('The Time is  : ${getCartItemHistory()[j].time}');
    }
  }

  List<CartItemsModel> getCartItemHistory() {
    if (sharedPreferences.containsKey(ConstantData.cartHistoryItem)) {
      cartHistoryItems = [];
      cartHistoryItems =
      sharedPreferences.getStringList(ConstantData.cartHistoryItem)!;
    }

    // since we need to return a model instead of list of string the string will now be turn to a model ...
    List<CartItemsModel> cartHistoryItemData = [];
    for (var e in cartHistoryItems) {
      cartHistoryItemData.add(CartItemsModel.fromJson(jsonDecode(e)));
    }
    return cartHistoryItemData;
  }
}


// cart history part
import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_items_controller.dart';
import 'package:food_app/utilities/colors.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';
import 'package:food_app/widgets/icons_reuse.dart';
import 'package:food_app/widgets/main_text.dart';
import 'package:food_app/widgets/pre_loading_page.dart';
import 'package:food_app/widgets/sub_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utilities/constant_data.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    // This help us to get history of the data stored in the memory...
    var getCartItemsHistory =
    Get.find<CartItemsController>().getCartItemHistoryList();

    Map<String, int> getItemsPerOrder = {};

    for (int i = 0; i < getCartItemsHistory.length; i++) {
      if (getItemsPerOrder.containsKey(getCartItemsHistory[i].time)) {
        getItemsPerOrder.update(
          getCartItemsHistory[i].time.toString(),
              (value) => ++value,
        );
      } else {
        getItemsPerOrder.putIfAbsent(
          getCartItemsHistory[i].time.toString(),
              () => 1,
        );
      }
    }

    // This turn the map to List....
    List<int> orderItems() {
      return getItemsPerOrder.entries.map((e) => e.value).toList();
    }

    // this save the number of the time the same time occur...
    List<int> orderItemTimes = orderItems();
    int listCount = 0;
    print('The orders are occuring simuteouley as follow: $orderItemTimes');

    print('the cartHistory data are: $getCartItemsHistory');
    print('the ordertimes is  ${orderItems()}');
    print(
      'the lenght of the items in the storage is: ${getItemsPerOrder.length}',
    );

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.infinity,
            height: DynamicDimensions.size100,
            padding: EdgeInsets.only(
              left: DynamicDimensions.size30,
              top: DynamicDimensions.size45,
              right: DynamicDimensions.size30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainText(text: 'Cart History', color: Colors.white),
                IconsReuse(
                  icons: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                  iconSize: DynamicDimensions.size24,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: DynamicDimensions.size20,
                left: DynamicDimensions.size20,
                right: DynamicDimensions.size20,
              ),
              // The remove padding help to remove the list view default padding
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  children: [
                    for (int i = 0; i < orderItemTimes.length; i++)
                      Container(
                        height:
                        DynamicDimensions.size120 +
                            DynamicDimensions.size20,
                        margin: EdgeInsets.only(
                          bottom: DynamicDimensions.size10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MainText(
                              text: getCartItemsHistory[i].time.toString(),
                            ),
                            // SizedBox(height: DynamicDimensions.size5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  direction: Axis.horizontal,
                                  children: List.generate(orderItemTimes[i], (
                                      index,
                                      ) {
                                    if (listCount <
                                        getCartItemsHistory.length) {
                                      listCount++;
                                    }
                                    return index <= 2
                                        ? Container(
                                      height: DynamicDimensions.size80,
                                      width: DynamicDimensions.size80,
                                      margin: EdgeInsets.only(
                                        right: DynamicDimensions.size5,
                                      ),
                                      child: PreLoadingPage(
                                        borderRadius:
                                        DynamicDimensions.size10,
                                        imagePath:
                                        // the minus 1 add is to make sure they set back to noraml count cause initial it 0 but when the loop happened ot increase
                                        '${ConstantData.BASE_URL}${ConstantData.UPLOAD_URL}${getCartItemsHistory[listCount - 1].img}',
                                      ),
                                    )
                                        : Container();
                                  }),
                                ),
                                Container(
                                  height: DynamicDimensions.size100,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SubText(
                                        text: 'Total',
                                        color: AppColors.titleColor,
                                      ),
                                      MainText(
                                        text: '${orderItemTimes[i]} Items',
                                        color: AppColors.titleColor,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(
                                          DynamicDimensions.size5,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            DynamicDimensions.size16 * 0.5,
                                          ),
                                          border: Border.all(
                                            color: AppColors.mainColor,
                                            width: DynamicDimensions.size2,
                                          ),
                                        ),
                                        child: Center(
                                          child: SubText(
                                            text: 'more items',
                                            color: AppColors.mainColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

*/
