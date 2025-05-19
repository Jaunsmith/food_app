import 'package:food_app/data_process/api/api_client.dart';
import 'package:get/get.dart';

import '../../utilities/constant_data.dart';

class DrinksRepo extends GetxService {
  ApiClient apiClient;

  DrinksRepo({required this.apiClient});

  Future<Response> getDrinksData() async {
    return await apiClient.getData(ConstantData.DRINK_LIST_URL);
  }
}
