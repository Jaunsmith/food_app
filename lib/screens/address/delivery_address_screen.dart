import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_items_controller.dart';
import 'package:food_app/controllers/delivery_address_controller.dart';
import 'package:food_app/models/delivery_address_model.dart';
import 'package:food_app/utilities/colors.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';
import 'package:food_app/utilities/route/app_route.dart';
import 'package:food_app/widgets/bio_data_input.dart';
import 'package:food_app/widgets/custom_loader.dart';
import 'package:food_app/widgets/main_text.dart';
import 'package:food_app/widgets/show_error_messages.dart';
import 'package:food_app/widgets/sub_text.dart';
import 'package:get/get.dart';

class DeliveryAddressScreen extends StatefulWidget {
  const DeliveryAddressScreen({super.key});

  @override
  State<DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController mailController;
  late final TextEditingController stateController;
  late final TextEditingController cityController;
  late final TextEditingController streetNameController;
  late final TextEditingController moreInfoController;

  @override
  void initState() {
    super.initState();
    initializeControllers();
    loadExistingData();
  }

  void initializeControllers() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    mailController = TextEditingController();
    stateController = TextEditingController();
    cityController = TextEditingController();
    streetNameController = TextEditingController();
    moreInfoController = TextEditingController();
  }

  Future<void> loadExistingData() async {
    final deliveryAddressController = Get.find<DeliveryAddressController>();
    await deliveryAddressController.loadDeliveryAddress();

    if (deliveryAddressController.currentDeliveryAddress != null && mounted) {
      final address = deliveryAddressController.currentDeliveryAddress!;
      setState(() {
        nameController.text = address.recipientName;
        phoneController.text = address.recipientPhone;
        mailController.text = address.recipientMail;
        stateController.text = address.recipientState;
        cityController.text = address.recipientCity;
        streetNameController.text = address.recipientStreetName;
        moreInfoController.text = address.recipientMoreInfo ?? '';
      });
    }
  }

  bool validateFields() {
    if (nameController.text.isEmpty) {
      showErrorMessage('Enter name', title: 'Name');
      return false;
    }
    if (phoneController.text.isEmpty) {
      showErrorMessage('Enter Phone Number', title: 'Phone');
      return false;
    }
    if (mailController.text.isEmpty) {
      showErrorMessage('Enter Email', title: 'Mail');
      return false;
    }
    if (!GetUtils.isEmail(mailController.text)) {
      showErrorMessage('Enter Valid Email', title: 'Mail');
      return false;
    }
    if (stateController.text.isEmpty) {
      showErrorMessage('Enter State', title: 'State');
      return false;
    }
    if (cityController.text.isEmpty) {
      showErrorMessage('Enter City', title: 'City');
      return false;
    }
    if (streetNameController.text.isEmpty) {
      showErrorMessage('Enter Street address', title: 'Street');
      return false;
    }
    return true;
  }

  Future<void> submitDetails() async {
    final deliveryAddressController = Get.find<DeliveryAddressController>();

    if (!validateFields()) return;

    DeliveryAddressModel deliveryAddress = DeliveryAddressModel(
      recipientCity: cityController.text,
      recipientMail: mailController.text,
      recipientName: nameController.text,
      recipientPhone: phoneController.text,
      recipientState: stateController.text,
      recipientStreetName: streetNameController.text,
      recipientMoreInfo: moreInfoController.text,
    );

    final response = await deliveryAddressController.saveDeliveryDetails(
      deliveryAddress,
    );

    showErrorMessage(
      response.message,
      title: response.isSuccessful ? 'Success' : 'Error',
      color: response.isSuccessful ? AppColors.mainColor : Colors.red,
      icons: response.isSuccessful ? Icons.check : Icons.error,
      iconColor: Colors.white,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    mailController.dispose();
    stateController.dispose();
    cityController.dispose();
    streetNameController.dispose();
    moreInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.mainColor,
        title: MainText(
          text: 'Delivery Details',
          color: Colors.white,
          fontSize: DynamicDimensions.size30,
        ),
      ),
      body: GetBuilder<DeliveryAddressController>(
        builder: (controller) {
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: DynamicDimensions.size15,
              vertical: DynamicDimensions.size15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainText(
                      text:
                          'Hi, ${controller.currentDeliveryAddress?.recipientName ?? 'User'},',
                      color: AppColors.mainBlackColor,
                      fontSize: DynamicDimensions.size20,
                    ),
                    SizedBox(height: DynamicDimensions.size5),
                    SubText(
                      text:
                          controller.currentDeliveryAddress == null
                              ? 'Kindly provide your delivery details'
                              : 'Review or update your delivery details',
                      color: AppColors.mainBlackColor,
                      maxLines: 2,
                      fontSize: DynamicDimensions.size15,
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              DynamicDimensions.size5,
                            ),
                            border: Border.all(
                              width: 1.5,
                              color: AppColors.mainColor,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BioDataInput(
                                hintText: 'Name',
                                icons: Icons.person,
                                controller: nameController,
                                textInputType: TextInputType.text,
                              ),
                              BioDataInput(
                                hintText: 'Phone Number',
                                icons: Icons.phone,
                                controller: phoneController,
                                textInputType: TextInputType.phone,
                              ),
                              BioDataInput(
                                hintText: 'E-mail',
                                icons: Icons.email,
                                controller: mailController,
                                textInputType: TextInputType.emailAddress,
                              ),
                              BioDataInput(
                                hintText: 'State',
                                icons: Icons.location_city,
                                controller: stateController,
                                textInputType: TextInputType.text,
                              ),
                              BioDataInput(
                                hintText: 'City',
                                icons: Icons.location_city_outlined,
                                controller: cityController,
                                textInputType: TextInputType.text,
                              ),
                              BioDataInput(
                                hintText: 'Street name',
                                icons: Icons.streetview,
                                controller: streetNameController,
                                textInputType: TextInputType.text,
                              ),
                              BioDataInput(
                                hintText: 'Additional Information',
                                icons: Icons.more,
                                controller: moreInfoController,
                                textInputType: TextInputType.text,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: DynamicDimensions.size20),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              controller.isLoading ? null : submitDetails;
                              showErrorMessage(
                                'Data submitted  successfully',
                                time: 2,
                              );
                              // Get.find<CartItemsController>()
                              //     .getPickedItemsData();
                              Get.toNamed(AppRoute.getInitialPage());
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: DynamicDimensions.size20,
                                vertical: DynamicDimensions.size15,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    controller.isLoading
                                        ? Colors.grey
                                        : AppColors.mainColor,
                                borderRadius: BorderRadius.circular(
                                  DynamicDimensions.size20,
                                ),
                              ),
                              child:
                                  controller.isLoading
                                      ? CustomLoader()
                                      : MainText(
                                        text: 'SUBMIT',
                                        color: Colors.white,
                                        fontSize: DynamicDimensions.size20,
                                      ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
