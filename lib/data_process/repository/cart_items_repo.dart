import 'dart:convert';

import 'package:food_app/models/cart_items_model.dart';
import 'package:food_app/utilities/constant_data.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartItemsRepo {
  final SharedPreferences sharedPreferences;

  CartItemsRepo({required this.sharedPreferences});

  List<String> itemsStorage = [];
  List<String> pickedItemsStorage = [];

  //This  method let us send data to the storage
  void addItemsToStorage(List<CartItemsModel> toStorage) {
    DateTime dateTime = DateTime.now();
    String date = DateFormat('dd/MM/yyyy  hh:mm a').format(dateTime);
    // Setting the storage
    // sharedPreferences.remove(ConstantData.cartHistoryItem);
    // sharedPreferences.remove(ConstantData.cartListItem);
    itemsStorage = [];
    // for (var e in toStorage) {
    //   // this reset the time field to present time we are submitting
    //   e.time = date;
    //   // this help to convert object to string cause the shared preference only take string, list, map and co but don't take an object...
    //   itemsStorage.add(jsonEncode(e));
    // }
    toStorage.forEach((e) {
      e.time = date;
      return itemsStorage.add(jsonEncode(e));
    });

    // This help us to stored the data in the shared preference i.e the local storage..
    sharedPreferences.setStringList(ConstantData.cartListItem, itemsStorage);

    // getStorageItems();
  }

  // This help us to get the data stored in the pickedItemsStorage
  List<CartItemsModel> getStorageItems() {
    // now this help us to hold the data we get back from the storage
    List<String> storedData = [];
    if (sharedPreferences.containsKey(ConstantData.cartListItem)) {
      storedData = sharedPreferences.getStringList(ConstantData.cartListItem)!;
    }
    List<CartItemsModel> storageItems = [];
    for (var e in storedData) {
      // This convert the data back to object...from string to map to object...
      storageItems.add(CartItemsModel.fromJson(jsonDecode(e)));
    }
    // print('The storage  data is ${storedData.toString()}');
    return storageItems;
  }

  List<CartItemsModel> getPickedItemsHistory() {
    pickedItemsStorage = [];
    if (sharedPreferences.containsKey(ConstantData.cartHistoryItem)) {
      pickedItemsStorage =
          sharedPreferences.getStringList(ConstantData.cartHistoryItem)!;
    }

    List<CartItemsModel> pickedHistory = [];
    for (var e in pickedItemsStorage) {
      pickedHistory.add(CartItemsModel.fromJson(jsonDecode(e)));
      print('The cart history data is : $pickedItemsStorage');
    }
    return pickedHistory;
  }

  // This add items to the history global variable...
  void addItemsToPickedStorage() {
    if (sharedPreferences.containsKey(ConstantData.cartHistoryItem)) {
      pickedItemsStorage =
          sharedPreferences.getStringList(ConstantData.cartHistoryItem)!;
    }

    for (int i = 0; i < itemsStorage.length; i++) {
      print('The picked items are: ${itemsStorage[i]}');
      pickedItemsStorage.add(itemsStorage[i]);
    }
    removePickedData();
    sharedPreferences.setStringList(
      ConstantData.cartHistoryItem,
      pickedItemsStorage,
    );
    print(
      'The length of the history data is ${getPickedItemsHistory().length}',
    );
    for (int j = 0; j < pickedItemsStorage.length; j++) {
      print('The order time is ${getPickedItemsHistory()[j].time}');
    }
  }

  void removePickedData() {
    itemsStorage = [];
    sharedPreferences.remove(ConstantData.cartListItem);
  }

  void removeHistoryData() {
    removePickedData();
    pickedItemsStorage = [];
    sharedPreferences.remove(ConstantData.cartHistoryItem);
  }
}
