import 'package:food_app/data_process/api/api_client.dart';
import 'package:food_app/utilities/constant_data.dart';
import 'package:get/get.dart';

// since data is being loaded from the internet why will keep extending GetxSerivice if you use get package
class FoodListRepo extends GetxService {
  final ApiClient apiClient;
  // The constructor...
  FoodListRepo({required this.apiClient});

  // Now we pass the apiclient to the repo since they are connected...
  // repo has the instance of the apiclient in other to communicate with it
  // this pass the url to the api client so that it can be able to get us data from the server...
  Future<Response> getFoodListProductList() async {
    return await apiClient.getData(ConstantData.FOOD_LIST_URL);
  }
}
