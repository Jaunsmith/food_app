import 'package:food_app/data_process/api/api_client.dart';
import 'package:food_app/data_process/repository/auth_repo.dart';
import 'package:food_app/models/response_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/sign_up_model.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  final SharedPreferences? sharedPreferences;

  bool _loaded = false;
  bool get loaded => _loaded;

  AuthController({required this.authRepo, this.sharedPreferences});

  Future<ResponseModel> registration(SignUpModel signUpModel) async {
    _loaded = true;
    update();
    Response response = await authRepo.registration(signUpModel);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.userToken(response.body['token']);
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _loaded = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String number, String password) async {
    ApiClient apiClient = Get.find();
    _loaded = true;
    update();
    try {
      Response response = await authRepo.login(number, password);
      if (response.statusCode == 200) {
        final token = response.body['token'];
        if (token == null) {
          return ResponseModel(false, 'Token not found in response');
        }
        authRepo.userToken(token);
        authRepo.saveUserLoginDetails(number, password);
        authRepo.saveUserPhone(number);
        apiClient.updateHeader(token);
        return ResponseModel(true, token);
      } else {
        return ResponseModel(
          false,
          response.statusText ??
              response.body['message'] ??
              'Login failed with status ${response.statusCode}',
        );
      }
    } catch (e) {
      return ResponseModel(false, e.toString());
    } finally {
      _loaded = false;
      update();
    }
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  String getCurrentUserPhone() {
    if (userLoggedIn() == true) {
      print('the user enter number is ${authRepo.getUserPhone()}');
      return authRepo.getUserPhone();
    }
    return '';
  }

  bool logOut() {
    authRepo.clearUserPhone();
    return authRepo.logOut();
  }
}
