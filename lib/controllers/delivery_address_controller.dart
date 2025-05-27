import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/controllers/cart_items_controller.dart';
import 'package:food_app/data_process/repository/delivery_address_repo.dart';
import 'package:food_app/models/delivery_address_model.dart';
import 'package:food_app/models/response_model.dart';
import 'package:get/get.dart';

class DeliveryAddressController extends GetxController implements GetxService {
  final DeliveryAddressRepo deliveryAddressRepo;
  final AuthController authController;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  DeliveryAddressModel? _currentDeliveryAddress;
  DeliveryAddressModel? get currentDeliveryAddress => _currentDeliveryAddress;

  DeliveryAddressController({
    required this.deliveryAddressRepo,
    required this.authController,
  });

  Future<void> loadDeliveryAddress() async {
    _isLoading = true;
    update();
    try {
      String userPhone = authController.getCurrentUserPhone();
      if (userPhone.isEmpty) {
        _currentDeliveryAddress = null;
        return;
      }
      _currentDeliveryAddress = await deliveryAddressRepo
          .getUserDeliveryDetails(userPhone);
    } catch (e) {
      _currentDeliveryAddress = null;
    } finally {
      _isLoading = false;
      update();
    }
  }

  Future<ResponseModel> saveDeliveryDetails(
    DeliveryAddressModel deliveryDetails,
  ) async {
    _isLoading = true;
    update();
    try {
      String userPhone = authController.getCurrentUserPhone();
      if (userPhone.isEmpty) {
        return ResponseModel(false, "User not authenticated");
      }
      bool success = await deliveryAddressRepo.addDeliveryDetails(
        userPhone,
        deliveryDetails,
      );
      if (success) {
        _currentDeliveryAddress = deliveryDetails;
      }
      return ResponseModel(
        success,
        success
            ? "Delivery details saved successfully"
            : "Failed to save delivery details",
      );
    } catch (e) {
      return ResponseModel(false, "Error: ${e.toString()}");
    } finally {
      _isLoading = false;
      update();
    }
  }
}
