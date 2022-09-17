import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivary_app/helper/route_helper.dart';
import 'package:food_delivary_app/models/sign_up_model.dart';
import 'package:food_delivary_app/shared/componants.dart';
import 'package:food_delivary_app/shared/app_colors.dart';
import 'package:food_delivary_app/shared/dimenstion.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    var signupImages=['t.png', 'f.png' , 'g.png'];

    void _registration(AuthController authController){
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();

      if(name.isEmpty){
        showCustomSnackBar('Type in Your Name ' , title : 'Name');

      }else if(phone.isEmpty){
        showCustomSnackBar('Type in Your Phone Number ' , title : 'Phone Number');

      }else if(email.isEmpty){
        showCustomSnackBar('Type in Your Email Address' , title : 'Email Address');

      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar('Type in a valid Email Address ' , title : 'Valid Email Address');

      }else if(password.isEmpty){
        showCustomSnackBar('Type in Your Password ' , title : 'Password');

      }else if(password.length < 6){
        showCustomSnackBar('Password can\'t be less than six characters  ' , title : 'Password');

      }else{
        showCustomSnackBar('All went well ' , title : 'Perfect' , isError: false);
        SignUpModel signUpModel = SignUpModel(name: name, email: email, phone: phone, password: password) ;
        authController.registration(signUpModel).then((status){
          if(status.isSuccess){
              Get.offNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (_authController){
          return !_authController.isLoading
              ? SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
                children:[
                  SizedBox(height: Dimenstions.screenHeight*0.05,) ,
                  Container(
                      height: Dimenstions.screenHeight*0.25,
                      child: Center(
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: Dimenstions.radius20*4,
                            backgroundImage:AssetImage('assets/images/logo1.png')
                        ),
                      )
                  ) ,
                  AppTextFeild(
                      hintText: "Email" ,
                      icon: Icons.email ,
                      controller: emailController
                  ) ,
                  SizedBox(height: Dimenstions.height20) ,
                  AppTextFeild(
                      hintText: "Password" ,
                      icon: Icons.remove_red_eye_sharp ,
                      controller: passwordController ,
                    isObscure: true
                  ) ,
                  SizedBox(height: Dimenstions.height20) ,
                  AppTextFeild(
                      hintText: "Name" ,
                      icon: Icons.person ,
                      controller: nameController
                  ) ,
                  SizedBox(height: Dimenstions.height20) ,
                  AppTextFeild(
                      hintText: "Phone" ,
                      icon: Icons.phone ,
                      controller: phoneController
                  ) ,
                  SizedBox(height: Dimenstions.height20) ,

                  GestureDetector(
                    onTap:(){
                      _registration(_authController);
                    } ,
                    child: Container(
                      width: Dimenstions.screenWidth/2,
                      height: Dimenstions.screenWidth/13,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimenstions.radius30) ,
                          color: AppColors.mainColor
                      ),
                      child: Center(
                        child: bigText(
                            text: "Sign up" ,
                            size: Dimenstions.font20 + Dimenstions.font20/2 ,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ) ,
                  SizedBox(height: Dimenstions.height10,) ,
                  RichText(
                    text: TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.back() ,
                        text:"Have an account already?" ,
                        style:TextStyle(
                            color: Colors.grey[500] ,
                            fontSize: Dimenstions.font20
                        )
                    ),
                  ) ,
                  SizedBox(height: Dimenstions.screenHeight*0.05,) ,
                  RichText(
                    text: TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.back() ,
                        text:"Sign Up using one of the following methods" ,
                        style:TextStyle(
                            color: Colors.grey[500] ,
                            fontSize: Dimenstions.font16
                        )
                    ),
                  ) ,
                  Wrap(
                    children: List.generate(3, (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: Dimenstions.radius30,
                        backgroundImage: AssetImage(
                            'assets/images/'+signupImages[index]
                        ),
                      ),
                    )),
                  )
                ]
            ),
          )
          : CustomLoader();
        },
      )
    );
  }


}
