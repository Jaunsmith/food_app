import 'package:flutter/material.dart';
import 'package:food_app/screens/auth/sign_in_screen.dart';
import 'package:food_app/utilities/colors.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';
import 'package:food_app/widgets/bio_data_input.dart';
import 'package:food_app/widgets/main_text.dart';
import 'package:food_app/widgets/sub_text.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
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
                Container(
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
                  ),
                  child: MainText(
                    text: 'Sign Up ',
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => SignInScreen());
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
