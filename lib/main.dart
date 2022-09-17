import 'package:flutter/material.dart';
import 'package:food_delivary_app/controllers/Popular_product_controller.dart';
import 'package:food_delivary_app/controllers/cart_controller.dart';
import 'package:food_delivary_app/controllers/recommended_product_controller.dart';
import 'package:food_delivary_app/helper/route_helper.dart';
import 'package:food_delivary_app/shared/app_colors.dart';
import 'package:food_delivary_app/shared/app_constants.dart';
import 'package:get/get.dart';
import 'package:food_delivary_app/helper/depentancies.dart' as dep;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  print('token ${AppConstants.TOKEN}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();

    return GetBuilder<PopularProductController>(
      builder  : (_){
        return GetBuilder<RecommendedProductController>(builder: (_){
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: RouteHelper.getSplash(),
            getPages: RouteHelper.routes,
            theme: ThemeData(
              primaryColor: AppColors.mainColor ,
              fontFamily: 'Lato'
            ),
            // home: MainScreen(),
          );
        });
      }
    );
  }
}
