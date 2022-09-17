import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivary_app/base/no_data_screen.dart';
import 'package:food_delivary_app/controllers/Popular_product_controller.dart';
import 'package:food_delivary_app/controllers/auth_controller.dart';
import 'package:food_delivary_app/controllers/cart_controller.dart';
import 'package:food_delivary_app/controllers/location_controller.dart';
import 'package:food_delivary_app/controllers/order_controller.dart';
import 'package:food_delivary_app/controllers/user_controller.dart';
import 'package:food_delivary_app/helper/route_helper.dart';
import 'package:food_delivary_app/models/cart_model.dart';
import 'package:food_delivary_app/models/place_order_model.dart';
import 'package:food_delivary_app/shared/app_colors.dart';
import 'package:food_delivary_app/shared/componants.dart';
import 'package:food_delivary_app/shared/dimenstion.dart';
import 'package:food_delivary_app/shared/style.dart';
import 'package:get/get.dart';

import '../../controllers/recommended_product_controller.dart';
import '../../shared/app_constants.dart';

class CartScreen extends StatelessWidget {
  TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: Dimenstions.height20 * 3,
                left: Dimenstions.width20,
                right: Dimenstions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIcon(
                        icon: Icons.arrow_back_ios,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimenstions.iconSize24),
                    SizedBox(
                      width: Dimenstions.width20 * 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(
                          icon: Icons.home_outlined,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.mainColor,
                          iconSize: Dimenstions.iconSize24),
                    ),
                    AppIcon(
                        icon: Icons.shopping_cart_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimenstions.iconSize24),
                  ],
                )),
            GetBuilder<CartController>(builder: (_cartController) {
              return _cartController.getItems.length > 0
                  ? Positioned(
                  top: Dimenstions.height20 * 5,
                  left: Dimenstions.width20,
                  right: Dimenstions.width20,
                  bottom: 0,
                  child: Container(
                    margin: EdgeInsets.only(top: Dimenstions.height15),
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: GetBuilder<CartController>(
                        builder: (cartController) {
                          return ListView.builder(
                              itemCount: cartController.getItems.length,
                              itemBuilder: (_, index) =>
                                  builtCartListItem(
                                      index,
                                      cartController.getItems[index],
                                      cartController));
                        },
                      ),
                    ),
                  ))
                  : NoDataScreen(text: 'Your Cart Is Empty');
            })
          ],
        ),
        bottomNavigationBar:
        GetBuilder<OrderController>(
          builder: (orderController) {
            _noteController.text = orderController.foodNote;
            return GetBuilder<CartController>(builder: (cartController) {
              return Container(
                height: Dimenstions.bottomHeightBar + 50,
                padding: EdgeInsets.only(
                    top: Dimenstions.height10,
                    bottom: Dimenstions.height10,
                    right: Dimenstions.width20,
                    left: Dimenstions.width20),
                decoration: BoxDecoration(
                    color: AppColors.buttonBackgroundColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimenstions.radius20 * 2),
                        topLeft: Radius.circular(Dimenstions.radius20 * 2))),
                child: cartController.getItems.length > 0
                    ? Column(
                  children: [
                    InkWell(
                      onTap: () =>
                          showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (_) {
                                return Column(
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Container(
                                          height: MediaQuery.of(context).size.height * 0.9,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(
                                                      Dimenstions.radius20),
                                                  topRight: Radius.circular(
                                                      Dimenstions.radius20))),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 520,
                                                padding: EdgeInsets.only(
                                                    left: Dimenstions.width20,
                                                    right: Dimenstions.width20,
                                                    top: Dimenstions.width20),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    builtPaymentOptionButton(
                                                        context: context,
                                                        icon: Icons.money,
                                                        title: 'cash on delivery',
                                                        subtitle:
                                                        'you pay after getting the delivery',
                                                        index: 0),
                                                    SizedBox(height: Dimenstions
                                                        .height10),
                                                    builtPaymentOptionButton(
                                                        context: context,
                                                        icon: Icons
                                                            .paypal_outlined,
                                                        title: 'digital payment',
                                                        subtitle:
                                                        'safer and faster way of payment',
                                                        index: 1),
                                                    SizedBox(height: Dimenstions
                                                        .height30,),
                                                    Text('Delivery option',
                                                      style: robotoMedium,),
                                                    SizedBox(height: Dimenstions
                                                        .height10 / 2,),
                                                    builtDeliveryOptions(
                                                        context: context,
                                                        value: 'delivery',
                                                        title: 'Home delivery',
                                                        amount: Get
                                                            .find<
                                                            CartController>()
                                                            .totalAmount
                                                            .toDouble(),
                                                        isFree: false),
                                                    SizedBox(height: Dimenstions
                                                        .height10 / 2,),
                                                    builtDeliveryOptions(
                                                        context: context,
                                                        value: 'take away',
                                                        title: 'Take away',
                                                        amount: Get
                                                            .find<
                                                            CartController>()
                                                            .totalAmount
                                                            .toDouble(),
                                                        isFree: true),
                                                    SizedBox(height: Dimenstions
                                                        .height20,),
                                                    Text('Additional info',
                                                      style: robotoMedium,),
                                                    AppTextFeild(
                                                        hintText: 'note',
                                                        controller: _noteController,
                                                        icon: Icons.note,
                                                        maxLines: true
                                                    )

                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).whenComplete(() =>
                              orderController.setFoodNote(
                                  _noteController.text.trim())),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: CommonTextButton(text: 'Payment Options'),
                      ),
                    ),
                    SizedBox(
                      height: Dimenstions.height10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(Dimenstions.height20),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(Dimenstions.radius20),
                              color: Colors.white),
                          child: Row(
                            children: [
                              SizedBox(
                                width: Dimenstions.width10 / 2,
                              ),
                              bigText(
                                  text: '\$ ' +
                                      cartController.totalAmount.toString()),
                              SizedBox(
                                width: Dimenstions.width10 / 2,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (Get.find<AuthController>().userLoggedIn()) {
                              if (Get
                                  .find<LocationController>()
                                  .addressList
                                  .isEmpty) {
                                Get.toNamed(RouteHelper.getAddAddressPage());
                              } else {
                                var location = Get.find<LocationController>()
                                    .getUserAddress();
                                var cart = Get
                                    .find<CartController>()
                                    .getItems;
                                var user = Get
                                    .find<UserController>()
                                    .userModel;
                                PlaceOrderModel placeOrder = PlaceOrderModel(
                                    cart: cart,
                                    orderAmount: 100.0,
                                    orderNote: orderController.foodNote,
                                    distance: 10.0,
                                    scheduleAt: '',
                                    address: location.address,
                                    latitude: location.latitude,
                                    longitude: location.longitude!,
                                    contactPersonName: user.name,
                                    contactPersonNumber: user.phone,
                                    orderType: orderController.orderType,
                                    paymentMethod: orderController
                                        .paymentIndex == 0
                                        ? 'cash_on_delivery'
                                        : 'digital_payment');
                                Get.find<OrderController>()
                                    .placeOrder(placeOrder, _callback);
                              }
                            } else {
                              Get.toNamed(RouteHelper.getSignInPage());
                            }
                          },
                          child: CommonTextButton(text: 'Check Out'),
                        )
                      ],
                    ),
                  ],
                )
                    : Container(),
              );
            });
          },
        )
    );
  }

  Widget builtCartListItem(int index, CartModel cartModel,
      CartController cartController) {
    return Container(
      height: 100,
      width: double.maxFinite,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              var popularIndex = Get
                  .find<PopularProductController>()
                  .popularProductList
                  .indexOf(cartModel.product!);
              if (popularIndex >= 0) {
                Get.toNamed(
                    RouteHelper.getPopularFood(popularIndex, 'cartPage'));
              } else {
                var recommendedIndex = Get
                    .find<RecommendedProductController>()
                    .recommendedProductList
                    .indexOf(cartModel.product!);
                if (recommendedIndex > 0) {
                  Get.snackbar('History Product ',
                      'Product review is not available for history product',
                      backgroundColor: AppColors.mainColor,
                      colorText: Colors.white);
                } else {
                  Get.toNamed(RouteHelper.getRecommendedFood(
                      recommendedIndex, 'cartPage'));
                }
              }
            },
            child: Container(
              width: Dimenstions.height20 * 5,
              height: Dimenstions.height20 * 5,
              margin: EdgeInsets.only(bottom: Dimenstions.height10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimenstions.radius20),
                  color: Colors.white,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        AppConstants.BASE_URI + '/uploads/' + cartModel.img!,
                      ))),
            ),
          ),
          SizedBox(
            width: Dimenstions.width10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                bigText(text: cartModel.name!, color: Colors.black54),
                smallText(text: 'spicy'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    bigText(
                        text: '\$ ${cartModel.price}', color: Colors.redAccent),
                    Container(
                      padding: EdgeInsets.all(Dimenstions.height10),
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(Dimenstions.radius20),
                          color: Colors.white),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                cartController.addItem(cartModel.product!, -1);
                              },
                              child: Icon(Icons.remove,
                                  color: AppColors.signColor)),
                          SizedBox(
                            width: Dimenstions.width10 / 2,
                          ),
                          bigText(text: cartModel.quantity!.toString()),
                          SizedBox(
                            width: Dimenstions.width10 / 2,
                          ),
                          GestureDetector(
                              onTap: () {
                                cartController.addItem(cartModel.product!, 1);
                              },
                              child:
                              Icon(Icons.add, color: AppColors.signColor)),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget builtPaymentOptionButton({required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required int index}) {
    return GetBuilder<OrderController>(builder: (orderController) {
      bool _selected = orderController.paymentIndex == index;
      return InkWell(
        onTap: () {
          orderController.setPaymentIndex(index);
        },
        child: Container(
          padding: EdgeInsets.only(bottom: Dimenstions.height10 / 2),
          child: ListTile(
            leading: Icon(
              icon,
              size: 40,
              color: _selected ? AppColors.mainColor : Theme
                  .of(context)
                  .disabledColor,
            ),
            title: Text(
              title,
              style: robotoMedium.copyWith(fontSize: Dimenstions.font20),
            ),
            subtitle: Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: robotoRegular.copyWith(
                  color: Theme
                      .of(context)
                      .disabledColor,
                  fontSize: Dimenstions.font16),
            ),
            trailing: _selected ? Icon(Icons.check_circle, color: Theme
                .of(context)
                .primaryColor) : null,
          ),
        ),
      );
    });
  }

  Widget builtDeliveryOptions(
      {required BuildContext context, required String value, required String title, required double amount, required bool isFree}) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return Row(
        children: [
          Radio(
            onChanged: (String? value) =>
                orderController.setDeliveryType(value!),
            groupValue: orderController.orderType,
            value: value,
            activeColor: Theme
                .of(context)
                .primaryColor,
          ),
          SizedBox(width: Dimenstions.width10 / 2,),
          Text(title,
            style: robotoRegular.copyWith(fontSize: Dimenstions.font20),),
          SizedBox(width: Dimenstions.width10 / 2,),
          Text('(${(value == 'take away' || isFree) ? 'free' : '\$${amount /
              10}'})',
            style: robotoMedium.copyWith(fontSize: Dimenstions.font20),)
        ],
      );
    });
  }

  void _callback(bool isSuccess, String message, String orderId) {
    if (isSuccess) {
       Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreference();
      Get.find<CartController>().addToHistory();
      if(Get.find<OrderController>().paymentIndex==0){
        Get.offNamed(RouteHelper.getOrderSuccessPage(orderId, 'success'));
      }
      Get.offNamed(RouteHelper.getPaymentPage(
          orderId, Get
          .find<UserController>()
          .userModel
          .id));
    } else {
      showCustomSnackBar(message);
    }
  }
}
