import 'package:food_app/models/main_food_model.dart';
import 'package:get/get.dart';

import '../data_process/repository/food_list_repo.dart';

class FoodListController extends GetxController {
  final FoodListRepo foodListRepo;

  FoodListController({required this.foodListRepo});

  // the data gotten from the main food repo will be save in this list
  List<dynamic> _foodListProductList = [];

  //This will make the mainProductList generally available across the application...
  List<dynamic> get foodListProductList => _foodListProductList;
  late bool _dataAvailable = false;
  bool get dataAvailable => _dataAvailable;

  Future<void> getFoodListProductList() async {
    Response response = await foodListRepo.getFoodListProductList();

    if (response.statusCode == 200) {
      // why initialize to null here is to avoid duplicate data ... cause the method might be called many times
      _foodListProductList = [];
      _foodListProductList.addAll(Product.fromJson(response.body).products);
      _dataAvailable = true;
      print('The length of the foodList is ${_foodListProductList.length}');
      update();
    } else {
      print("❌list  Error getting products:");
      print("Status Code: ${response.statusCode}");
      print("Status Text: ${response.statusText}");
      print("Response Body: ${response.body}");
    }
  }
}
