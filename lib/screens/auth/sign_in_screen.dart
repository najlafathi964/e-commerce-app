import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivary_app/screens/auth/sign_up_screen.dart';
import 'package:food_delivary_app/shared/componants.dart';
import 'package:food_delivary_app/shared/app_colors.dart';
import 'package:food_delivary_app/shared/dimenstion.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../helper/route_helper.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();


      if (email.isEmpty) {
        showCustomSnackBar(
            'Type in Your Email Address', title: 'Email Address');
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar(
            'Type in a valid Email Address ', title: 'Valid Email Address');
      } else if (password.isEmpty) {
        showCustomSnackBar('Type in Your Password ', title: 'Password');
      } else if (password.length < 6) {
        showCustomSnackBar(
            'Password can\'t be less than six characters  ', title: 'Password');
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (authController) {
            return !authController.isLoading
                ? SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                  children: [
                    SizedBox(height: Dimenstions.screenHeight * 0.05,),
                    Container(
                        height: Dimenstions.screenHeight * 0.25,
                        child: Center(
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: Dimenstions.radius20 * 4,
                              backgroundImage: AssetImage(
                                  'assets/images/logo1.png')
                          ),
                        )
                    ),
                    Container(
                      margin: EdgeInsets.only(left: Dimenstions.width20),
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello',
                            style: TextStyle(
                                fontSize: Dimenstions.font20 * 3 +
                                    Dimenstions.font20 / 2,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            ' sign in into account',
                            style: TextStyle(
                                fontSize: Dimenstions.font20,
                                color: Colors.grey[500]
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: Dimenstions.height20),
                    AppTextFeild(
                        hintText: "Email",
                        icon: Icons.email,
                        controller: emailController
                    ),
                    SizedBox(height: Dimenstions.height20),
                    AppTextFeild(
                        hintText: "Password",
                        icon: Icons.remove_red_eye_sharp,
                        controller: passwordController,
                        isObscure: true
                    ),

                    SizedBox(height: Dimenstions.height20),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        RichText(
                          text: TextSpan(
                              text: "sign into your account",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimenstions.font20
                              )
                          ),
                        ),
                        SizedBox(height: Dimenstions.width20),

                      ],
                    ),
                    SizedBox(height: Dimenstions.screenHeight * 0.05,),

                    GestureDetector(
                      onTap: () {
                        _login(authController);
                      },
                      child: Container(
                        width: Dimenstions.screenWidth / 2,
                        height: Dimenstions.screenWidth / 13,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimenstions.radius30),
                            color: AppColors.mainColor
                        ),
                        child: Center(
                          child: bigText(
                              text: "Sign In",
                              size: Dimenstions.font20 + Dimenstions.font20 / 2,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: Dimenstions.screenHeight * 0.05,),
                    RichText(
                      text: TextSpan(
                          text: "Don\'t have an account",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimenstions.font20
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () =>
                                    Get.to(() => SignUpScreen(),
                                        transition: Transition.fade),
                              text: "Create",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.mainBlackColor,
                                  fontSize: Dimenstions.font20
                              ),)
                          ]
                      ),

                    ),

                  ]
              ),
            )
                : CustomLoader();
          },
        )
    );
  }
}
