import 'package:food_delivary_app/models/order_model.dart';
import 'package:food_delivary_app/screens/address/add_address_screen.dart';
import 'package:food_delivary_app/screens/address/pick_address_map.dart';
import 'package:food_delivary_app/screens/cart/cart_screen.dart';
import 'package:food_delivary_app/screens/payment/payment_screen.dart';
import 'package:food_delivary_app/screens/popular_food_details_screen.dart';
import 'package:food_delivary_app/screens/recommened_food_details.dart';
import 'package:food_delivary_app/screens/auth/sign_in_screen.dart';
import 'package:food_delivary_app/screens/splash_screen.dart';
import 'package:get/get.dart';

import '../screens/home_page.dart';
import '../screens/payment/order_success_page.dart';

class RouteHelper {
  static const String splash ='/splash_screen';
  static const String initial ='/';
  static const String popularFood ='/popular-food';
  static const String recommendedFood ='/recommended-food';
  static const String cartPage ='/cart-page';
  static const String signInPage ='/sign-in_page';
  static const String addAddressPage ='/add_address_page';
  static const String pickAddressMap ='/pik_address_map';
  static const String payment ='/payment';
  static const String orderSuccess ='/order_successful';

  static String getSplash() => splash ;
  static String getInitial() => initial ;
  static String getPopularFood(int pageId , String page) => '$popularFood?pageId=$pageId&page=$page' ;
  static String getRecommendedFood(int pageId , String page) => '$recommendedFood?pageId=$pageId&page=$page' ;
  static String getCartPage() => cartPage ;
  static String getSignInPage() => signInPage ;
  static String getAddAddressPage() => addAddressPage ;
  static String getPickAddressMap() => pickAddressMap ;
  static String getPaymentPage(String id , int userId) => '$payment?id=$id&userID=$userId' ;
  static String getOrderSuccessPage(String orderId ,String status) => '$orderSuccess?id=$orderId&status=$status' ;


  static  List<GetPage> routes =[
    GetPage(name: splash, page: ()=> SplashScreen()) ,
    GetPage(name: initial, page: ()=> HomePage() , transition: Transition.fade) ,
    GetPage(name: popularFood , page: (){
      var pageId =Get.parameters['pageId'];
      var page =Get.parameters['page'];

      return PopularFoodDetailsScreen(pageId: int.parse(pageId!) , page:page!);
  } ,
      transition: Transition.fadeIn
    ) ,
    GetPage(name: recommendedFood , page: (){
      var pageId =Get.parameters['pageId'];
      var page = Get.parameters['page'] ;
      return RecommenedFoodDetails(pageId: int.parse(pageId!) , page:page!);
    } ,
        transition: Transition.fadeIn
    ) ,
    GetPage(name: cartPage , page: (){
      return CartScreen();
    } ,
        transition: Transition.fadeIn
    ) ,
    GetPage(name: signInPage , page: (){
      return SignInScreen();
    } ,
        transition: Transition.fade
    ) ,
    GetPage(name: addAddressPage , page: (){
      return AddAddressScreen();
    } ,
        transition: Transition.fade
    ) ,
    GetPage(name: pickAddressMap , page: (){
       PickAddressMap _pickAddressMap = Get.arguments;
       return _pickAddressMap ;
    } ,
        transition: Transition.fade
    ),
    GetPage(name: payment , page: (){
      OrderModel orderModel = OrderModel(
          id: int.parse(Get.parameters['id']!),
          userId: int.parse(Get.parameters['userID']!));
      return PaymentScreen(orderModel: orderModel) ;
    }
    ),
    GetPage(name: orderSuccess , page: (){
      return OrderSuccessPage(orderId: Get.parameters['id']! , status: Get.parameters['status'].toString().contains('success')?1:0) ;
    } )

  ];
}