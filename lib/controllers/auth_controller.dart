import 'package:food_app/data_process/api/api_client.dart';
import 'package:food_app/data_process/repository/auth_repo.dart';
import 'package:food_app/models/response_model.dart';
import 'package:food_app/models/sign_up_model.dart';
import 'package:get/get.dart';

// The service is called because we need to use repo
class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  late bool _loaded = false;
  bool get loaded => _loaded;
  // This is a registration method communicating to the server and internet
  Future<ResponseModel> registration(SignUpModel signUpModel) async {
    // this means data is loading or loaded
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

  // This is a login method communicating to the server and internet
  Future<ResponseModel> login(String number, String password) async {
    ApiClient apiClient = Get.find();
    _loaded = true;
    update();

    try {
      Response response = await authRepo.login(number, password);

      // print('Full response: ${response.body}');
      // print('Status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final token = response.body['token'];
        if (token == null) {
          return ResponseModel(false, 'Token not found in response');
        }
        authRepo.userToken(token);
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

  // to hold the user login info...
  void saveUserLoginDetails(String number, String password) {
    authRepo.saveUserLoginDetails(number, password);
  }

  bool userLoggedIn() {
    var check = authRepo.userLoggedIn();

    print(' the check data is  $check');
    return check;
  }

  bool logOut() {
    return authRepo.logOut();
  }
}
