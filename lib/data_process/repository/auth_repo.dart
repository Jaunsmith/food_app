import 'package:food_app/data_process/api/api_client.dart';
import 'package:food_app/models/sign_up_model.dart';
import 'package:food_app/utilities/constant_data.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  // to save the token that will be send from the server for authentication purpose
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  // For registration ...
  Future<Response> registration(SignUpModel sigUpModel) async {
    // The data need to be converted to Json since we are sending it to the server...
    Response response = await apiClient.postData(
      ConstantData.REGISTRATION_URL,
      sigUpModel.toJson(),
    );
    return response;
  }

  Future<String> getUserToken() async {
    return sharedPreferences.getString(ConstantData.TOKEN) ?? 'None';
  }

  // for login
  Future<Response> login(String email, String password) async {
    // The data need to be converted to Json since we are sending it to the server...
    Response response = await apiClient.postData(ConstantData.LOGIN_URL, {
      'email': email,
      'password': password,
    });
    return response;
  }

  // This is used to authenticate a user...sent from the server
  Future<bool> userToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    // the token is saved in other to keep the data in the phone local memory for future use ...
    var savedData = await sharedPreferences.setString(
      ConstantData.TOKEN,
      token,
    );
    return savedData;
  }

  // This hold the user login details ...
  Future<void> saveUserLoginDetails(String phone, String password) async {
    try {
      await sharedPreferences.setString(ConstantData.PHONE, phone);
      await sharedPreferences.setString(ConstantData.PASSWORD, password);
    } catch (e) {
      throw e;
    }
  }
}
