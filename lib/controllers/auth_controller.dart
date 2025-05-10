import 'package:food_app/data_process/repository/auth_repo.dart';
import 'package:food_app/models/sign_up_model.dart';
import 'package:get/get.dart';

// The service is called because we need to use repo
class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  late bool _loaded = false;
  bool get loaded => _loaded;

  registration(SignUpModel signUpModel) async {
    // this means data is loading or loaded
    _loaded = true;
    Response response = await authRepo.registration(signUpModel);

    if (response.statusCode == 200) {
      authRepo.userToken(response.body['token']);
    } else {}
  }
}
