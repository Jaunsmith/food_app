import 'package:flutter/material.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';
import 'package:food_app/widgets/main_text.dart';
import 'package:get/get.dart';

// The {} represent optional parameter...
void showErrorMessage(
  String message, {
  bool error = true,
  String title = 'Error',
  Color color = const Color(0xFFFF0000),
  IconData icons = Icons.close,
  Color iconColor = const Color(0xFFFFFFFF),
  int time = 0,
}) {
  Get.snackbar(
    title,
    message,
    titleText: MainText(text: title, color: Colors.white),
    messageText: Text(message, style: TextStyle(color: Colors.white)),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: color,
    icon: Icon(
      icons,
      color: iconColor,
      size: DynamicDimensions.size30,
      weight: DynamicDimensions.size30,
    ),
    duration: Duration(seconds: time == 0 ? 1 : time),
  );
}
