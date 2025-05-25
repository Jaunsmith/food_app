import 'package:flutter/material.dart';
import 'package:food_app/models/delivery_address_model.dart';
import 'package:food_app/utilities/colors.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';
import 'package:food_app/widgets/bio_data_input.dart';
import 'package:food_app/widgets/main_text.dart';
import 'package:food_app/widgets/show_error_messages.dart';
import 'package:food_app/widgets/sub_text.dart';
import 'package:get/get.dart';

class DeliveryAddressScreen extends StatelessWidget {
  const DeliveryAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var mailController = TextEditingController();
    var stateController = TextEditingController();
    var cityController = TextEditingController();
    var streetNameController = TextEditingController();
    var moreInfoController = TextEditingController();

    void submitDetails() {
      String name = nameController.text;
      String phone = phoneController.text;
      String mail = mailController.text;
      String state = stateController.text;
      String city = cityController.text;
      String street = streetNameController.text;
      String moreInfo = moreInfoController.text;
      if (name.isEmpty) {
        showErrorMessage('Enter name ', title: 'name');
      } else if (phone.isEmpty) {
        showErrorMessage('Enter Phone Number ', title: 'Phone');
      } else if (mail.isEmpty) {
        showErrorMessage('Enter Phone Mail ', title: 'Mail');
      } else if (GetUtils.isEmail(mail)) {
        showErrorMessage('Enter Valid Mail ', title: 'Mail');
      } else if (state.isEmpty) {
        showErrorMessage('Enter State ', title: 'State');
      } else if (city.isEmpty) {
        showErrorMessage('Enter City ', title: 'City');
      } else if (street.isEmpty) {
        showErrorMessage('Enter Street address', title: 'Street');
      } else {
        DeliveryAddressModel deliveryAddressModel = DeliveryAddressModel(
          recipientCity: city,
          recipientMail: mail,
          recipientName: name,
          recipientPhone: phone,
          recipientState: state,
          recipientStreetName: street,
          recipientMoreInfo: moreInfo,
        );

        showErrorMessage(
          'Delivery Details Successfully Submitted ',
          title: 'Submitted',
          color: AppColors.mainColor,
          icons: Icons.check,
          iconColor: Colors.white,
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: MainText(
          text: 'Delivery Details',
          color: Colors.white,
          fontSize: DynamicDimensions.size30,
        ),
      ),
      body: Container(
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
                  text: 'Hi, Adedeji,',
                  color: AppColors.mainBlackColor,
                  fontSize: DynamicDimensions.size20,
                ),
                SizedBox(height: DynamicDimensions.size5),
                SubText(
                  text: 'Kindly provide the delivery details ',
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
                          print('The submitted clicked');
                          submitDetails();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: DynamicDimensions.size20,
                            vertical: DynamicDimensions.size15,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(
                              DynamicDimensions.size20,
                            ),
                          ),
                          child: MainText(
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
      ),
    );
  }
}
