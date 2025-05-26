import 'dart:convert';
import 'package:food_app/models/delivery_address_model.dart';
import 'package:food_app/utilities/constant_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryAddressRepo {
  final SharedPreferences sharedPreferences;

  DeliveryAddressRepo({required this.sharedPreferences});

  Future<bool> addDeliveryDetails(
    String phoneKey,
    DeliveryAddressModel deliveryDetails,
  ) async {
    try {
      String userData = jsonEncode(deliveryDetails.toJson());
      return await sharedPreferences.setString(
        '${ConstantData.DELIVERY_ADDRESS_PREFIX}$phoneKey',
        userData,
      );
    } catch (e) {
      return false;
    }
  }

  Future<DeliveryAddressModel?> getUserDeliveryDetails(String phoneKey) async {
    try {
      String? deliveryDetails = sharedPreferences.getString(
        '${ConstantData.DELIVERY_ADDRESS_PREFIX}$phoneKey',
      );
      if (deliveryDetails != null) {
        Map<String, dynamic> details = jsonDecode(deliveryDetails);
        return DeliveryAddressModel.fromJson(details);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
