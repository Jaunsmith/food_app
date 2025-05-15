import 'package:flutter/material.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/controllers/cart_items_controller.dart';
import 'package:food_app/utilities/route/app_route.dart';
import 'package:food_app/widgets/data_input.dart';

import '../../utilities/colors.dart';
import '../../utilities/dynamic_dimensions.dart';
import '../../widgets/main_text.dart';
import 'package:get/get.dart';

import '../../widgets/show_error_messages.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MainText(text: 'Profile', color: Colors.white, fontSize: 24),
        backgroundColor: AppColors.mainColor,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(
                top: DynamicDimensions.size10,
                bottom: DynamicDimensions.size10,
              ),
              height: DynamicDimensions.size150,
              width: DynamicDimensions.size150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  DynamicDimensions.size150 * 0.5,
                ),
                color: AppColors.mainColor,
              ),
              child: Center(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: DynamicDimensions.size100 - DynamicDimensions.size20,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DataInput(
                    icons: Icons.person,
                    text: 'Owovickky',
                    iconBckColor: AppColors.mainColor,
                  ),
                  DataInput(
                    icons: Icons.phone,
                    text: '0703377841',
                    iconBckColor: AppColors.yellowColor,
                  ),
                  DataInput(
                    icons: Icons.email,
                    text: 'Jaunsmith2016@gmail.com',
                    iconBckColor: AppColors.yellowColor,
                  ),
                  DataInput(
                    icons: Icons.location_on,
                    text: 'Ondo road',
                    iconBckColor: AppColors.yellowColor,
                  ),
                  DataInput(
                    icons: Icons.message_outlined,
                    text: 'Messages',
                    iconBckColor: Colors.redAccent,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (Get.find<AuthController>().logOut()) {
                        Get.find<AuthController>().logOut();
                        Get.find<CartItemsController>().removeHistoryData();
                        showErrorMessage(
                          'Log Out Successfully',
                          title: 'Thanks',
                          color: AppColors.mainColor,
                          icons: Icons.check,
                          iconColor: Colors.white,
                          time: 3,
                        );
                        Get.toNamed(AppRoute.getSignInPage());
                      }
                      print('you taped logout');
                    },
                    child: DataInput(
                      icons: Icons.logout_rounded,
                      text: 'LogOut',
                      iconBckColor: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
