import 'package:food_app/data_process/api/api_client.dart';
import 'package:food_app/models/sign_up_model.dart';
import 'package:food_app/utilities/constant_data.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> registration(SignUpModel signUpModel) async {
    return await apiClient.postData(
      ConstantData.REGISTRATION_URL,
      signUpModel.toJson(),
    );
  }

  Future<String> getUserToken() async {
    return sharedPreferences.getString(ConstantData.TOKEN) ?? 'None';
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(ConstantData.TOKEN);
  }

  Future<Response> login(String number, String password) async {
    return await apiClient.postData(ConstantData.LOGIN_URL, {
      'phone': number,
      'password': password,
    }, isAuthRequest: true);
  }

  Future<bool> userToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(ConstantData.TOKEN, token);
  }

  Future<void> saveUserLoginDetails(String number, String password) async {
    try {
      await sharedPreferences.setString(ConstantData.PHONE, number);
      await sharedPreferences.setString(ConstantData.PASSWORD, password);
    } catch (e) {
      throw e;
    }
  }

  bool logOut() {
    sharedPreferences.remove(ConstantData.TOKEN);
    sharedPreferences.remove(ConstantData.PASSWORD);
    sharedPreferences.remove(ConstantData.PHONE);
    sharedPreferences.remove(ConstantData.USER_PHONE);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }

  String getUserPhone() {
    return sharedPreferences.getString(ConstantData.USER_PHONE) ?? '';
  }

  Future<bool> saveUserPhone(String phone) async {
    return await sharedPreferences.setString(ConstantData.USER_PHONE, phone);
  }

  Future<bool> clearUserPhone() async {
    return await sharedPreferences.remove(ConstantData.USER_PHONE);
  }
}
