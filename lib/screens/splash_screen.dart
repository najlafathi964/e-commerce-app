import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivary_app/helper/route_helper.dart';
import 'package:food_delivary_app/shared/dimenstion.dart';
import 'package:get/get.dart';

import '../controllers/Popular_product_controller.dart';
import '../controllers/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late Animation<double> animation ;
  late AnimationController controller ;

   Future<void> getResources () async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();
    getResources();
    controller = AnimationController(vsync: this ,duration:  Duration(seconds: 2))..forward() ;
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(
        const Duration ( seconds:  3) ,
        () => Get.offNamed(RouteHelper.getInitial())
    ) ;
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
              child: Center(child: Column(
                children: [
                  Image.asset('assets/images/logo1.png' , width: Dimenstions.splashScreenImage,),
                  SizedBox(height: Dimenstions.height15,) ,
                  Image.asset('assets/images/logo2.png' , width: Dimenstions.splashScreenImage,),

                ],
              ))) //250
        ],
      ),
    );
  }
}