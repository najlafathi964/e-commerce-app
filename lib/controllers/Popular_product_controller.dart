import 'package:flutter/material.dart';
import 'package:food_delivary_app/controllers/cart_controller.dart';
import 'package:food_delivary_app/data/repositories/populor_product_repo.dart';
import 'package:food_delivary_app/models/cart_model.dart';
import 'package:food_delivary_app/models/product_model.dart';
import 'package:get/get.dart';

import '../shared/app_colors.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo ;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList =[];

  List<dynamic> get popularProductList => _popularProductList;

  bool _isLoaded = false ;
  bool get isLoaded => _isLoaded ;

  Future <void> getPopularProductList() async{
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode ==200){
      _popularProductList=[];
      _popularProductList.addAll(Product.fromJson(response.body).products) ;
      _isLoaded = true ;
      update();
    }else{
      print(response.statusCode) ;
      print('could not get product popular ');
    }
  }

  int _quantity =0;
  int get quantity => _quantity ;
  int _inCartItem =0;
  int get inCartItem => _inCartItem+_quantity ;
  late CartController _cart ;

  void  setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = checkQuantity(_quantity +1) ;
    }else{
      _quantity = checkQuantity(_quantity -1) ;
    }
    update();
  }

  int checkQuantity(int quantity){
    if((_inCartItem+quantity) <0){
      Get.snackbar('Item Count', 'you Cant reduce more !' ,
          backgroundColor: AppColors.mainColor ,
          colorText: Colors.white ) ;
      if(_inCartItem > 0){
        _quantity = -_inCartItem ;
        return _quantity ;
      }
      return 0 ;
    }else if((_inCartItem + quantity) >20){
      Get.snackbar('Item Count', 'you Cant add more !' ,
      backgroundColor: AppColors.mainColor ,
      colorText: Colors.white) ;
      return 20 ;
    }else{
      return quantity ;
    }
  }

  void initProduct(ProductModel product ,CartController cart){
    _quantity =0;
    _inCartItem=0;
    _cart = cart ;
    var exist = false ;
    exist =_cart.existInCart(product) ;
    if(exist){
      _inCartItem =_cart.getQuantity(product);
    }
  }
  void addItem(ProductModel product){

      _cart.addItem(product, _quantity);
      _quantity =0 ;
      _inCartItem =_cart.getQuantity(product);
      // _cart.items.forEach((key, value) {
      //
      // });
      update();

  }

  int  get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems ;
  }
}