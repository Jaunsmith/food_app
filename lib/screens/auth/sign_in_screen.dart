import 'package:flutter/material.dart';
import 'package:food_app/screens/auth/sign_up_screen.dart';
import 'package:food_app/utilities/extension.dart';
import 'package:food_app/utilities/route/app_route.dart';
import 'package:food_app/widgets/bio_data_input.dart';
import 'package:food_app/widgets/custom_loader.dart';
import 'package:food_app/widgets/main_text.dart';
import 'package:food_app/widgets/sub_text.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../utilities/colors.dart';
import '../../utilities/dynamic_dimensions.dart';
import '../../widgets/show_error_messages.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var numberController = TextEditingController();
    var passwordController = TextEditingController();

    void login(AuthController authController) {
      // . trim() remove any white space there and only grap the text
      String phone = numberController.text.trim();
      String password = passwordController.text.trim();

      if (phone.isEmpty) {
        showErrorMessage('Enter your valid mail', title: 'Mail');
      } else if (password.length < 8) {
        showErrorMessage(
          'Password can\'t be less than 8 character',
          title: 'Password',
        );
      } else {
        authController.login(phone, password).then((value) {
          if (value.isSuccessful) {
            print('Login Successful');
            showErrorMessage(
              'Login Successful',
              title: 'logged in',
              color: AppColors.mainColor,
              icons: Icons.check,
              iconColor: Colors.white,
            );
            Get.toNamed(AppRoute.getInitialPage());
          } else {
            showErrorMessage(
              'invalid Login details',
              title: 'Error',
              icons: Icons.close,
              iconColor: Colors.white,
            );
            print('The error gotten is ${value.message}');
          }
        });
        print('The entered details are Email: $phone   Password: $password');
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (authControl) {
          return !authControl.loaded
              ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height:
                          DynamicDimensions.size80 - DynamicDimensions.size30,
                    ),
                    Container(
                      height:
                          DynamicDimensions.size220 - DynamicDimensions.size30,
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: DynamicDimensions.size80,
                          backgroundImage: AssetImage(
                            'assets/image/logo part 1.png',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: DynamicDimensions.size20,
                        right: DynamicDimensions.size20,
                        bottom: DynamicDimensions.size20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MainText(
                            text: 'Hello',
                            fontSize: DynamicDimensions.size80,
                          ),
                          SubText(
                            text: 'Sign in into your account',
                            fontSize: DynamicDimensions.size20,
                            color: AppColors.titleColor,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: DynamicDimensions.size20),
                    Column(
                      children: [
                        BioDataInput(
                          hintText: 'Number',
                          icons: Icons.phone,
                          controller: numberController,
                          textInputType: TextInputType.phone,
                        ),
                        BioDataInput(
                          hintText: 'Password',
                          icons: Icons.password_sharp,
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          isPassword: true,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: DynamicDimensions.size20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SubText(
                            text: 'Sign into your account',
                            fontSize: DynamicDimensions.size15,
                            color: AppColors.titleColor,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: DynamicDimensions.size30),
                    GestureDetector(
                      onTap: () {
                        login(authControl);
                      },
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(
                            top: DynamicDimensions.size20,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: DynamicDimensions.size45,
                            vertical: DynamicDimensions.size15,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              DynamicDimensions.size30,
                            ),
                            color: AppColors.mainColor,
                          ),
                          child: MainText(
                            text: 'Sign in ',
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: DynamicDimensions.size30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SubText(
                          text: 'Don\'t have an account?',
                          fontSize: DynamicDimensions.size12,
                          color: AppColors.titleColor,
                        ),
                        5.wt,
                        GestureDetector(
                          onTap: () {
                            Get.to(() => SignUpScreen());
                          },
                          child: MainText(
                            text: 'Create',
                            fontSize: 12,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoute.getInitialPage());
                        },
                        child: SubText(
                          text: 'Click here to go to home page',
                          color: AppColors.mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : CustomLoader();
        },
      ),
    );
  }
}
