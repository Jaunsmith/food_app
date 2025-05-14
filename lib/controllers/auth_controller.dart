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
    ResponseModel responseModel;
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
  Future<ResponseModel> login(String email, String password) async {
    // Getting token...
    print('Getting user token');
    print('The saved token is:  ${authRepo.getUserToken().toString()}');
    // this means data is loading or loaded
    _loaded = true;
    update();

    Response response = await authRepo.login(email, password);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      print('Back End token');
      authRepo.userToken(response.body['token']);
      print('The token is ${response.body['token'].toString()}');
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }

    _loaded = false;
    update();
    return responseModel;
  }

  // to hold the user login info...
  void saveUserLoginDetails(String number, String password) {
    authRepo.saveUserLoginDetails(number, password);
  }
}
