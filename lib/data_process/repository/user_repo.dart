import 'package:food_app/data_process/api/api_client.dart';
import 'package:food_app/utilities/constant_data.dart';
import 'package:get/get.dart';

class UserRepo {
  ApiClient apiClient;

  UserRepo({required this.apiClient});

  Future<Response> getUserData() async {
    Response response = await apiClient.getData(ConstantData.USER_DATA_URL);
    return response;
  }
}
