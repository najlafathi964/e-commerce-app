import 'package:food_delivary_app/controllers/Popular_product_controller.dart';
import 'package:food_delivary_app/controllers/auth_controller.dart';
import 'package:food_delivary_app/controllers/order_controller.dart';
import 'package:food_delivary_app/controllers/user_controller.dart';
import 'package:food_delivary_app/data/api/api_client.dart';
import 'package:food_delivary_app/data/repositories/auth_repo.dart';
import 'package:food_delivary_app/data/repositories/location_repo.dart';
import 'package:food_delivary_app/data/repositories/order_repo.dart';
import 'package:food_delivary_app/data/repositories/populor_product_repo.dart';
import 'package:food_delivary_app/data/repositories/user_repo.dart';
import 'package:food_delivary_app/shared/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/cart_controller.dart';
import '../controllers/location_controller.dart';
import '../controllers/recommended_product_controller.dart';
import '../data/repositories/cart_repo.dart';
import '../data/repositories/recommended_product_repo.dart';

Future <void> init() async{
  SharedPreferences.setMockInitialValues({});
  var sharedPreference = await SharedPreferences.getInstance() ;

  Get.lazyPut(() => sharedPreference);

  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URI , sharedPreferences:Get.find()));
  //repositories
  Get.lazyPut(()=>AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));

  //controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));



}