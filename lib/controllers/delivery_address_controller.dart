import 'package:food_app/data_process/repository/delivery_address_repo.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DeliveryAddressController extends GetxController implements GetxService {
  DeliveryAddressRepo deliveryAddressRepo;

  DeliveryAddressController({required this.deliveryAddressRepo});
}
