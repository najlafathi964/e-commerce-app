import 'package:food_delivary_app/helper/route_helper.dart';
import 'package:food_delivary_app/shared/componants.dart';
import 'package:get/get.dart';
class ApiChecker{
  static void checkApi(Response response){
    //401 unauthorized عندما لا يمكن المستخدم الصلاحية بمعنى ليس لديه بيانات او غير مسجل للدخول
    if(response.statusCode == 401){
      Get.offAllNamed(RouteHelper.getSignInPage());
    }else{
      showCustomSnackBar(response.statusText!);
    }
  }
}