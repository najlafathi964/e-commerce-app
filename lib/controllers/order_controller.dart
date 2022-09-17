import 'package:food_delivary_app/models/order_model.dart';
import 'package:get/get.dart';
import 'package:food_delivary_app/data/repositories/order_repo.dart';

import '../models/place_order_model.dart';

class OrderController extends GetxController implements GetxService{
  OrderRepo orderRepo ;

  OrderController({required this.orderRepo});

  bool _isLoading = false ;
  bool get isLoading => _isLoading;
  late List<OrderModel> _currentOrderList;
  List<OrderModel> get currentOrderList => _currentOrderList;
  late List<OrderModel> _historyOrderList;
  List<OrderModel> get historyOrderList => _historyOrderList;

  int _paymentIndex=0;
  int get paymentIndex => _paymentIndex;

  String _orderType='delivery';
  String get orderType=>_orderType;

  String _foodNote=' ';
  String get foodNote=>_foodNote;

  Future<void> placeOrder(PlaceOrderModel placeOrder ,Function callback) async{
    _isLoading = true ;
    Response response = await orderRepo.placeOrder(placeOrder);
    if(response.statusCode == 200){
      _isLoading = false ;
      String message = response.body['message'];
      String orderId = response.body['order_id'].toString();
      callback(true,message,orderId);
    }else{
      callback(false,response.statusText!,'-1');
    }
  }

  Future<void> getOrderList()async{
    _isLoading =true ;
    Response response = await orderRepo.getOrderList();
    if(response.statusCode ==200){
      _historyOrderList=[];
      _currentOrderList=[];
      response.body.forEach((order){
        OrderModel orderModel = OrderModel.fromJson(order);
        if(orderModel.orderStatus =='pending'||
            orderModel.orderStatus =='accepted'||
            orderModel.orderStatus =='processing'||
            orderModel.orderStatus =='handover'||
            orderModel.orderStatus =='picked_up'){
          _currentOrderList.add(orderModel);
        }else{
          _historyOrderList.add(orderModel);
        }
      });
    }else{
      _historyOrderList=[];
      _currentOrderList=[];
    }
    _isLoading=false;
    update();
  }

  void setPaymentIndex(int index){
    _paymentIndex = index;
    update();
  }

  void setDeliveryType(String type){
    _orderType=type;
    update();
  }

  void setFoodNote(String note){
    _foodNote=note;
  }
}