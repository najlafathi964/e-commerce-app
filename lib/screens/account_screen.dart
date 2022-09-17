import 'package:flutter/material.dart';
import 'package:food_delivary_app/controllers/auth_controller.dart';
import 'package:food_delivary_app/controllers/cart_controller.dart';
import 'package:food_delivary_app/controllers/user_controller.dart';
import 'package:food_delivary_app/data/api/api_client.dart';
import 'package:food_delivary_app/helper/route_helper.dart';
import 'package:food_delivary_app/shared/app_colors.dart';
import 'package:food_delivary_app/shared/app_constants.dart';
import 'package:food_delivary_app/shared/componants.dart';
import 'package:food_delivary_app/shared/dimenstion.dart';
import 'package:get/get.dart';

import '../controllers/location_controller.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: CustomAppBar(context: context, title: 'Profile') ,
      body: GetBuilder<UserController>(
        builder: (userController){
          if (_userLoggedIn) {
            return (userController.isLoading)?Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(top: Dimenstions.height20),
            child: Column(
              children: [
                AppIcon(icon: Icons.person ,
                    backgroundColor: AppColors.mainColor ,
                    iconColor: Colors.white ,
                    iconSize: Dimenstions.height45+Dimenstions.height30 , //75
                    size: Dimenstions.height15*10)  , //150 ,
                SizedBox(height: Dimenstions.height30,) ,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AccountWidget(
                            icon: Icons.person ,
                            color: AppColors.mainColor ,
                            text : userController.userModel.name
                        ) ,
                        SizedBox(height: Dimenstions.height20) ,AccountWidget(
                            icon: Icons.phone ,
                            color: AppColors.yellowColor ,
                            text : userController.userModel.phone
                        ) ,
                        SizedBox(height: Dimenstions.height20) ,
                        AccountWidget(
                            icon: Icons.email ,
                            color: AppColors.yellowColor ,
                            text : userController.userModel.email
                        ) ,
                        SizedBox(height: Dimenstions.height20) ,
                        GetBuilder<LocationController>(
                          builder : (locationController){
                            if(_userLoggedIn && locationController.addressList.isEmpty) {
                              return GestureDetector(
                                onTap: (){
                                  Get.offNamed(RouteHelper.getAddAddressPage());
                                },
                                child: AccountWidget(
                                    icon: Icons.location_on,
                                    color: AppColors.yellowColor,
                                    text: 'Fill in your address'
                                ),
                              );
                            }else{
                              return GestureDetector(
                                onTap: (){
                                  Get.offNamed(RouteHelper.getAddAddressPage());
                                },
                                child: AccountWidget(
                                    icon: Icons.location_on,
                                    color: AppColors.yellowColor,
                                    text: 'your address'
                                ),
                              );
                            }
                          }
                        ),
                        SizedBox(height: Dimenstions.height20)
                        ,AccountWidget(
                            icon: Icons.message_outlined ,
                            color: Colors.red ,
                            text : 'messsages'
                        ) ,
                        SizedBox(height: Dimenstions.height20) ,
                        GestureDetector(
                          onTap: (){
                            if(Get.find<AuthController>().userLoggedIn()){
                              Get.find<AuthController>().cleanSharedData();
                              Get.find<CartController>().clear();
                              Get.find<CartController>().clearCartHistory();
                              Get.find<LocationController>().clearAddressList();
                              Get.toNamed(RouteHelper.getSignInPage());
                            }else{

                              Get.toNamed(RouteHelper.getSignInPage());

                            }
                          },
                          child: AccountWidget(
                              icon: Icons.logout ,
                              color: Colors.red ,
                              text : 'logOut'
                          ),
                        ) ,
                        SizedBox(height: Dimenstions.height20) ,

                      ],
                    ),
                  ),
                )
              ],
            ),
          ):CustomLoader();
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                width:double.maxFinite ,
                height: Dimenstions.height20*8 ,
                margin: EdgeInsets.only(left: Dimenstions.width20 , right: Dimenstions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimenstions.radius20),
                  image: DecorationImage(
                    fit: BoxFit.cover ,
                    image: AssetImage(
                      'assets/images/signinprofile.jpg'
                    )
                  )
                ),
          ),
                SizedBox(height: Dimenstions.height20) ,
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getSignInPage());
                  },
                  child: Container(
                    width:double.maxFinite ,
                    height: Dimenstions.height20*5 ,
                    margin: EdgeInsets.only(left: Dimenstions.width20 , right: Dimenstions.width20),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor ,
                        borderRadius: BorderRadius.circular(Dimenstions.radius20),

                    ),
                    child: Center(child: bigText(text: 'Sign in' , color: Colors.white) ,),
                  ),
                )
              ],
              ),
            );
          }
        }
      ),
         

    );
  }
}
