import 'package:flutter/material.dart';
import 'package:food_app/models/sign_up_model.dart';
import 'package:food_app/screens/auth/sign_in_screen.dart';
import 'package:food_app/utilities/colors.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';
import 'package:food_app/widgets/bio_data_input.dart';
import 'package:food_app/widgets/main_text.dart';
import 'package:food_app/widgets/sub_text.dart';
import 'package:get/get.dart';

import '../../widgets/show_error_messages.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    void _registration() {
      // . trim() remove any white space there and only grap the text
      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showErrorMessage('Enter your name', title: 'Name');
      } else if (!GetUtils.isEmail(email)) {
        showErrorMessage('Enter your valid mail', title: 'Mail');
      } else if (phone.isEmpty) {
        showErrorMessage('Enter your phone number', title: 'Phone number');
      } else if (password.isEmpty) {
        showErrorMessage('Enter your password', title: 'Password');
      } else if (password.length < 8) {
        showErrorMessage(
          'Password can\'t be less than 8 character',
          title: 'Password',
        );
      } else if (email.isEmpty) {
        showErrorMessage('Enter your Email', title: 'Email');
      } else {
        showErrorMessage(
          'Valid data details',
          title: 'Submitted',
          color: AppColors.mainColor,
          icons: Icons.check,
          iconColor: Colors.white,
        );
        SignUpModel signUpModel = SignUpModel(
          email: email,
          password: password,
          phone: phone,
          name: name,
        );
        print('The entered details are  ${signUpModel}');
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: DynamicDimensions.size80 - DynamicDimensions.size30,
            ),
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
              margin: EdgeInsets.only(bottom: DynamicDimensions.size20),
              child: MainText(
                text: 'Sign Up here',
                fontSize: DynamicDimensions.size30,
              ),
            ),
            Column(
              children: [
                BioDataInput(
                  hintText: 'Name',
                  icons: Icons.person,
                  controller: nameController,
                  textInputType: TextInputType.name,
                  isPassword: false,
                ),
                BioDataInput(
                  hintText: 'Email',
                  icons: Icons.email,
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  isPassword: false,
                ),
                BioDataInput(
                  hintText: 'Password',
                  icons: Icons.password_sharp,
                  controller: passwordController,
                  textInputType: TextInputType.visiblePassword,
                  isPassword: true,
                ),
                BioDataInput(
                  hintText: 'Phone Number',
                  icons: Icons.phone,
                  controller: phoneController,
                  textInputType: TextInputType.phone,
                  isPassword: false,
                ),
                GestureDetector(
                  onTap: () {
                    _registration();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: DynamicDimensions.size20),
                    padding: EdgeInsets.symmetric(
                      horizontal: DynamicDimensions.size45,
                      vertical: DynamicDimensions.size15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        DynamicDimensions.size30,
                      ),
                      color: AppColors.mainColor,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(1, 7),
                          color: Colors.grey.shade300,
                          blurRadius: 10,
                          spreadRadius: 7,
                        ),
                      ],
                    ),
                    child: MainText(
                      text: 'Sign Up ',
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
                SizedBox(height: DynamicDimensions.size20),
                TextButton(
                  onPressed: () {
                    Get.to(
                      () => SignInScreen(),
                      transition: Transition.fade,
                      duration: Duration(seconds: 2),
                    );
                  },
                  child: SubText(text: 'Have an account?', fontSize: 20),
                ),
                SizedBox(height: DynamicDimensions.size15),
                SubText(
                  text: 'Sign up using one of the following',
                  fontSize: 17,
                ),
                SizedBox(height: DynamicDimensions.size15),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: DynamicDimensions.size30,
                  ),
                  margin: EdgeInsets.only(bottom: DynamicDimensions.size20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/image/g.png'),
                        ),
                      ),
                      Container(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/image/t.png'),
                        ),
                      ),
                      Container(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/image/f.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
