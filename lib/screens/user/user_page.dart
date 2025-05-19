import 'package:flutter/material.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/controllers/cart_items_controller.dart';
import 'package:food_app/controllers/user_controller.dart';
import 'package:food_app/utilities/extension.dart';
import 'package:food_app/utilities/route/app_route.dart';
import 'package:food_app/widgets/custom_loader.dart';
import 'package:food_app/widgets/data_input.dart';

import '../../utilities/colors.dart';
import '../../utilities/dynamic_dimensions.dart';
import '../../widgets/main_text.dart';
import 'package:get/get.dart';

import '../../widgets/show_error_messages.dart';
import '../auth/sign_up_screen.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (userLoggedIn) {
      Get.find<UserController>().getUserData();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: MainText(text: 'Profile', color: Colors.white, fontSize: 24),
        backgroundColor: AppColors.mainColor,
        automaticallyImplyLeading: false,
      ),
      body:
          userLoggedIn
              ? GetBuilder<UserController>(
                builder: (userController) {
                  return userController.loaded
                      ? Column(
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
                                  size:
                                      DynamicDimensions.size100 -
                                      DynamicDimensions.size20,
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
                                    text:
                                        userController.userModel.name
                                            .toUpperCase(),
                                    iconBckColor: AppColors.mainColor,
                                  ),
                                  DataInput(
                                    icons: Icons.phone,
                                    text: userController.userModel.phone,
                                    iconBckColor: AppColors.yellowColor,
                                  ),
                                  DataInput(
                                    icons: Icons.email,
                                    text: userController.userModel.email,
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
                                        Get.find<CartItemsController>()
                                            .removeHistoryData();
                                        showErrorMessage(
                                          'Log Out Successfully',
                                          title: 'Thanks',
                                          color: AppColors.mainColor,
                                          icons: Icons.check,
                                          iconColor: Colors.white,
                                          time: 3,
                                        );
                                        Get.offNamed(AppRoute.getSignInPage());
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
                      )
                      : CustomLoader();
                },
              )
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: DynamicDimensions.size150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        DynamicDimensions.size20,
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/image/signintocontinue.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  20.ht,
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(
                        DynamicDimensions.size10,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: DynamicDimensions.size20,
                          ),
                          child: MainText(
                            text: 'Please kindly log in or Sign up ',
                            color: AppColors.mainBlackColor,
                            fontSize: DynamicDimensions.size20,
                          ),
                        ),
                        10.ht,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.toNamed(AppRoute.getSignInPage());
                              },
                              child: MainText(
                                text: 'Log in ',
                                color: AppColors.mainColor,
                                fontSize: DynamicDimensions.size30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(() => SignUpScreen());
                              },
                              child: MainText(
                                text: 'Sign Up',
                                color: AppColors.mainColor,
                                fontSize: DynamicDimensions.size30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
