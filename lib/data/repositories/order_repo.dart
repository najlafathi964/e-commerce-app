import 'package:food_delivary_app/data/api/api_client.dart';
import 'package:food_delivary_app/models/place_order_model.dart';
import 'package:food_delivary_app/shared/app_constants.dart';
import 'package:get/get.dart';

class OrderRepo{
  final ApiClient apiClient;
  OrderRepo({required this.apiClient});

  Future<Response> placeOrder(PlaceOrderModel placeOrder) async{
    return await apiClient.postData(AppConstants.PLACE_ORDER_URI, placeOrder.toJson());
  }

  Future<Response> getOrderList() async{
    return await apiClient.getData(AppConstants.ORDER_LIST_URI);
  }
}