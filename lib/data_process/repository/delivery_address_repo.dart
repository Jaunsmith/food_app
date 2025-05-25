import 'dart:convert';

import 'package:food_app/models/delivery_address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryAddressRepo {
  SharedPreferences sharedPreferences;

  DeliveryAddressRepo({required this.sharedPreferences});

  Future<void> addDeliveryDetails(
    String number,
    DeliveryAddressModel deliveryDetails,
  ) async {
    final preference = await SharedPreferences.getInstance();
    String userData = jsonEncode(deliveryDetails.toJson());
    await preference.setString(number, userData);
  }

  Future<DeliveryAddressModel?> getUserDeliveryDetails(String number) async {
    final prefs = await SharedPreferences.getInstance();

    String? deliveryDetails = prefs.getString(number);

    if (deliveryDetails != null) {
      Map<String, dynamic> details = jsonDecode(deliveryDetails);
      return DeliveryAddressModel.fromJson(details);
    } else {
      return null;
    }
  }
}
