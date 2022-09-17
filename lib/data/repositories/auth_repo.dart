import 'package:food_delivary_app/data/api/api_client.dart';
import 'package:food_delivary_app/models/sign_up_model.dart';
import 'package:food_delivary_app/shared/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient ;
  final SharedPreferences sharedPreferences ;
  AuthRepo({required this.apiClient , required this.sharedPreferences}) ;

  Future<Response> registration(SignUpModel signUpModel) async {
    return await apiClient.postData(AppConstants.REGISTRATION_URI, signUpModel.toJson());
  }

  bool userLoggedIn()  {
    return  sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<Response> login(String email , String password) async {
    return await apiClient.postData(AppConstants.LOGIN_URI, {'email':email , 'password':password});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token=token ;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }
  Future<void> saveUserNumberAndPassword(String number , String password) async {
    try{
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }catch(e){
      throw e ;
    }
  }

  bool cleanSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClient.token='';
    apiClient.updateHeader('');
    return true ;
  }
}