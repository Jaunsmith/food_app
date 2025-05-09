import 'package:flutter/material.dart';
import 'package:food_app/screens/auth/sign_up_screen.dart';
import 'package:food_app/widgets/bio_data_input.dart';
import 'package:food_app/widgets/main_text.dart';
import 'package:food_app/widgets/sub_text.dart';
import 'package:get/get.dart';

import '../../utilities/colors.dart';
import '../../utilities/dynamic_dimensions.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: DynamicDimensions.size80 - DynamicDimensions.size30),
          Container(
            height: DynamicDimensions.size220 - DynamicDimensions.size30,
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: DynamicDimensions.size80,
                backgroundImage: AssetImage('assets/image/logo part 1.png'),
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
                MainText(text: 'Hello', fontSize: DynamicDimensions.size80),
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
                hintText: 'Phone',
                icons: Icons.smartphone_rounded,
                controller: phoneController,
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
                  fontSize: DynamicDimensions.size20,
                  color: AppColors.titleColor,
                ),
              ],
            ),
          ),
          SizedBox(height: DynamicDimensions.size30),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: DynamicDimensions.size20),
              padding: EdgeInsets.symmetric(
                horizontal: DynamicDimensions.size45,
                vertical: DynamicDimensions.size15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DynamicDimensions.size30),
                color: AppColors.mainColor,
              ),
              child: MainText(
                text: 'Sign in ',
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
          SizedBox(height: DynamicDimensions.size30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SubText(
                text: 'Don\'t have an account?',
                fontSize: DynamicDimensions.size20,
                color: AppColors.titleColor,
              ),
              TextButton(
                onPressed: () {
                  Get.to(
                    () => SignUpScreen(),
                    transition: Transition.fadeIn,
                    duration: Duration(seconds: 2),
                  );
                },
                child: MainText(text: 'Create'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
