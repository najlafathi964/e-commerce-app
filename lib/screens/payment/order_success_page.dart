import 'package:flutter/material.dart';
import 'package:food_delivary_app/helper/route_helper.dart';
import 'package:food_delivary_app/shared/app_colors.dart';
import 'package:food_delivary_app/shared/componants.dart';
import 'package:food_delivary_app/shared/dimenstion.dart';
import 'package:get/get.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderId;
  final int status ;
   OrderSuccessPage({Key? key, required this.orderId , required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(status == 0){
      Future.delayed(Duration(seconds: 1),(){
      //  Get.dialog(PaymentFailedDialog(orderId:orderId), barrierDismissible: false);
      });
    }
    return Scaffold(
      body: Center(child: SizedBox(width: Dimenstions.screenWidth,child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(status==1?Icons.check_circle_outline:
            Icons.warning_amber_outlined , size: 100,color: AppColors.mainColor,),
            SizedBox(height: Dimenstions.height45,),
            Text(
              status==1?'You placed the order successfully':'your order failed',
              style: TextStyle(fontSize: Dimenstions.font20),
            ),
            SizedBox(height: Dimenstions.height20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimenstions.height10 , vertical: Dimenstions.width20),
              child: Text(
                status==1?'Successful Order':'Failed Order',
                style: TextStyle(fontSize: Dimenstions.font20 , color: Theme.of(context).disabledColor),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: Dimenstions.height10,) ,
            Padding(
              padding: EdgeInsets.all(Dimenstions.height10),
              child: CustomButton(context: context, buttonText: 'Back to Home' , onPressed: ()=>
              Get.offNamed(RouteHelper.getInitial())),
            )
          ],
        )
        ,),),
    );
  }
}
