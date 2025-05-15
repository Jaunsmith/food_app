import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app/screens/auth/sign_up_screen.dart';

import 'package:get/get.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';

import '../../controllers/food_list_controller.dart';
import '../../controllers/main_food_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // This help us to perform animation
  late Animation<double> animation;
  late AnimationController animationController;

  late Animation<double> animationText;
  late AnimationController animationControllerText;

  // This help to load the data from the internet before the app start to they run all this happen while the welcome page is loading....
  Future<void> _loadData() async {
    await Get.find<MainFoodController>().getMainProductList();
    await Get.find<FoodListController>().getFoodListProductList();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..forward();
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    );

    // the .. is like creating and instance and based on the instance you do something...
    animationControllerText = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..forward();
    animationText = Tween<double>(
      begin: 0.5,
      end: 1.5,
    ).animate(animationControllerText);

    // this part let all what we animated display and then moved to the designated page to be display which is the homepage
    // Timer(Duration(seconds: 6), () => Get.toNamed(AppRoute.getInitialPage()));
    Timer(Duration(seconds: 6), () => Get.to(SignUpScreen()));
  }

  @override
  void dispose() {
    animationController.dispose();
    animationControllerText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                'assets/image/logo part 1.png',
                width: DynamicDimensions.size250,
              ),
            ),
          ),
          SizedBox(height: DynamicDimensions.size20),
          ScaleTransition(
            scale: animationText,
            child: Center(
              child: Image.asset(
                'assets/image/logo part 2.png',
                width: DynamicDimensions.size250,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
