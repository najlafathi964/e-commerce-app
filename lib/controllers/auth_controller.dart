import 'package:food_delivary_app/data/repositories/auth_repo.dart';
import 'package:food_delivary_app/models/response_model.dart';
import 'package:food_delivary_app/models/sign_up_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo ;
  AuthController({required this.authRepo});

  bool _isLoading = false ;
  bool get isLoading => _isLoading ;

  Future<ResponseModel> registration(SignUpModel signUpModel) async {
    _isLoading = true ;
    update();
    Response response = await authRepo.registration(signUpModel);
    late ResponseModel responseModel ;
    if(response.statusCode == 200){
      authRepo.saveUserToken(response.body['token']);
      responseModel =ResponseModel(true ,response.body['token']);
    }else{
      responseModel =ResponseModel(true ,response.statusText!);

    }
    _isLoading = false ;
    update();
    return responseModel ;
  }

  Future<ResponseModel> login(String email , String password) async {
    _isLoading = true ;
    update();
    Response response = await authRepo.login(email, password);
    late ResponseModel responseModel ;
    if(response.statusCode == 200){
      authRepo.saveUserToken(response.body['token']);
      responseModel =ResponseModel(true ,response.body['token']);
    }else{
      responseModel =ResponseModel(true ,response.statusText!);

    }
    _isLoading = false ;
    update();
    return responseModel ;
  }


  void saveUserNumberAndPassword(String number , String password){
    authRepo.saveUserNumberAndPassword(number, password) ;
  }

  bool userLoggedIn()  {
    return authRepo.userLoggedIn();
  }
  bool cleanSharedData(){
    return authRepo.cleanSharedData();
  }

  }

