import 'package:food_app/data_process/repository/drinks_repo.dart';
import 'package:get/get.dart';

import '../models/main_food_model.dart';

class DrinksController extends GetxController {
  DrinksRepo drinksRepo;

  DrinksController({required this.drinksRepo});

  List<dynamic> _productDrinksList = [];

  List<dynamic> get productDrinksList => _productDrinksList;
  late bool _dataAvailable = false;
  bool get dataAvailable => _dataAvailable;

  Future<void> getProductDrinkList() async {
    Response response = await drinksRepo.getDrinksData();

    if (response.statusCode == 200) {
      // why initialize to null here is to avoid duplicate data ... cause the method might be called many times
      _productDrinksList = [];
      _productDrinksList.addAll(Product.fromJson(response.body).products);
      _dataAvailable = true;
      print('The length of the foodList is ${_productDrinksList.length}');
      update();
    } else {
      print("❌list  Error getting products:");
      print("Status Code: ${response.statusCode}");
      print("Status Text: ${response.statusText}");
      print("Response Body: ${response.body}");
    }
  }
}
