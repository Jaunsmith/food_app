import 'package:food_app/data_process/repository/user_repo.dart';
import 'package:food_app/models/response_model.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/utilities/route/app_route.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({required this.userRepo});

  bool _loaded = false;
  late UserModel _userModel;

  bool get loaded => _loaded;
  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserData() async {
    Response response = await userRepo.getUserData();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _loaded = true;
      responseModel = ResponseModel(true, 'Data successfully gotten ');
    } else if (response.statusCode == 401) {
      _loaded = false;
      responseModel = ResponseModel(false, 'Unauthorized Please kindly Login');
      Get.toNamed(AppRoute.getSignInPage());
    } else {
      _loaded = false;
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }
}
