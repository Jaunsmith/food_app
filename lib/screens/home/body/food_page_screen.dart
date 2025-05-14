import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controllers/main_food_controller.dart';
import 'package:food_app/data_process/repository/food_list_repo.dart';
import 'package:food_app/screens/home/body/page_builder_function.dart';
import 'package:food_app/utilities/colors.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';
import 'package:food_app/utilities/route/app_route.dart';
import 'package:food_app/widgets/main_text.dart';
import 'package:food_app/widgets/sub_text.dart';
import 'package:get/get.dart';

import 'food_list_screen.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  FoodListRepo foodListRepo = FoodListRepo(apiClient: Get.find());
  PageController pageController = PageController(viewportFraction: 0.85);
  // in other to make the page display at ago more one will use the pageController..
  // The whole page is 1 but setting to certain to fraction make it to display images till it reach the size of 1...
  // instance if set to 0.8 the 0.2 to makes it 1 will be gotten from the rest of the pages to be display either 0.1 from each side of 0.2 from either side
  var _currentPageValue = 0.0;
  //The initstate is used cause we only need to create tje listener once @ the widget and this keep function till the app is kill this help us to prevent memory leak and re creation of the widget if to say it in the build ...
  @override
  void initState() {
    super.initState();
    foodListRepo.getFoodListProductList();
    // To get the current page value...  listener need to be attach to the controller..
    pageController.addListener(() {
      // This will be updating the current page value in real time... as we move and down the page...
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<MainFoodController>(
          builder: (mainProduct) {
            return mainProduct.dataAvailable
                ? Container(
                  height: DynamicDimensions.size320,
                  // This section is scrollable section it will be scrolling from left to right and vice versa
                  child: PageView.builder(
                    // The item count is the number of item to handle and this is connected to the index
                    itemCount: mainProduct.mainProductList.length,
                    // this link the page view Builder to the Page controller..
                    controller: pageController,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoute.getMainFoodPage(index, 'home'));
                        },
                        child: buildPageItem(
                          index,
                          _currentPageValue,
                          mainProduct.mainProductList[index],
                          mainProduct.dataAvailable,
                        ),
                      );
                    },
                  ),
                )
                : Container(
                  child: Text(
                    mainProduct.isBlank == true
                        ? 'Main Product is blank'
                        : 'something went wrong',
                  ),
                  // child: CircularProgressIndicator.adaptive(
                  //   backgroundColor: AppColors.mainColor,
                  // ),
                );
          },
        ),
        GetBuilder<MainFoodController>(
          builder: (mainProduct) {
            return DotsIndicator(
              dotsCount:
                  mainProduct.mainProductList.isEmpty
                      ? 1
                      : mainProduct.mainProductList.length,
              position: _currentPageValue,
              onTap: (int index) {
                pageController.animateToPage(
                  index,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                );
                print('current index of $_currentPageValue');
              },
              decorator: DotsDecorator(
                size: Size.square(DynamicDimensions.size10),
                activeColor: AppColors.mainColor,
                activeSize: Size(
                  DynamicDimensions.size20,
                  DynamicDimensions.size10,
                ),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DynamicDimensions.size5),
                ),
              ),
            );
          },
        ),
        SizedBox(height: DynamicDimensions.size30),
        Container(
          margin: EdgeInsets.only(left: DynamicDimensions.size30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MainText(text: 'Recommended'),
              SizedBox(width: DynamicDimensions.size10),
              Container(
                margin: EdgeInsets.only(bottom: DynamicDimensions.size3),
                child: MainText(text: '.'),
              ),
              SizedBox(width: DynamicDimensions.size10),
              Container(
                margin: EdgeInsets.only(bottom: DynamicDimensions.size3),
                child: SubText(text: 'Food Pairing'),
              ),
            ],
          ),
        ),
        FoodListPage(),
      ],
    );
  }
}
