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

  // This is to save the token for authentication purpose....
  Future<String> getUserToken() async {
    return sharedPreferences.getString(ConstantData.TOKEN) ?? 'None';
  }

  // confirming the status of the user if logged in or not...
  bool userLoggedIn() {
    var checking = sharedPreferences.containsKey(ConstantData.TOKEN);

    print('it contain a token... $checking ');
    return checking;
  }

  // for login
  Future<Response> login(String number, String password) async {
    return await apiClient.postData(
      ConstantData.LOGIN_URL,
      {'phone': number, 'password': password},
      isAuthRequest: true, // This will prevent sending auth header
    );
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
  Future<void> saveUserLoginDetails(String number, String password) async {
    try {
      await sharedPreferences.setString(ConstantData.PHONE, number);
      await sharedPreferences.setString(ConstantData.PASSWORD, password);
    } catch (e) {
      throw e;
    }
  }

  //for logging out of the application...
  bool logOut() {
    sharedPreferences.remove(ConstantData.TOKEN);
    sharedPreferences.remove(ConstantData.PASSWORD);
    sharedPreferences.remove(ConstantData.PHONE);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }
}
