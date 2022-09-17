import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivary_app/base/no_data_screen.dart';
import 'package:food_delivary_app/controllers/cart_controller.dart';
import 'package:food_delivary_app/helper/route_helper.dart';
import 'package:food_delivary_app/shared/app_constants.dart';
import 'package:food_delivary_app/shared/componants.dart';
import 'package:food_delivary_app/shared/dimenstion.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../models/cart_model.dart';
import '../../shared/app_colors.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get
        .find<CartController>()
        .getCartHistoryList()
        .reversed
        .toList();
    Map<String, int> cartItemPerOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemPerOrderToList() {
      return cartItemPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemPerOrder = cartItemPerOrderToList();
    var listCounter = 0;
    return Scaffold(

      body: Column(
        children: [
          Container(
            height: Dimenstions.height10 * 10,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimenstions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                bigText(text: 'Cart History', color: Colors.white),
                AppIcon(icon: Icons.shopping_cart,
                    iconColor: AppColors.mainColor,
                    backgroundColor: AppColors.yellowColor)
              ],
            ),
          ),
          GetBuilder<CartController>(
            builder: (_cartControlloer) {
              return _cartControlloer.getCartHistoryList().length >0 
              ?Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: Dimenstions.height20,
                      left: Dimenstions.width20,
                      right: Dimenstions.width20),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(
                      children: [
                        for(int i = 0; i < itemPerOrder.length; i++)
                          Container(
                            height: Dimenstions.ListImageContainer,
                            margin: EdgeInsets.only(
                                bottom: Dimenstions.height20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (() {
                                  DateTime parseDate = DateFormat(
                                      "yyyy-MM-dd hh:mm:ss")
                                      .parse(
                                      getCartHistoryList[listCounter].time!);
                                  var inputDate = DateTime.parse(
                                      parseDate.toString());
                                  var outputFormate = DateFormat(
                                      "MM/dd/yyyy hh:mm a");
                                  var outputDate = outputFormate.format(
                                      inputDate);
                                  return bigText(text: outputDate);
                                }()),
                                SizedBox(height: Dimenstions.height10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Wrap(
                                      direction: Axis.horizontal,
                                      children: List.generate(
                                          itemPerOrder[i], (index) {
                                        if (listCounter <
                                            getCartHistoryList.length) {
                                          listCounter++;
                                        }
                                        return index <= 2
                                            ? Container(
                                          height: Dimenstions.height20 * 4,
                                          width: Dimenstions.height20 * 4,
                                          margin: EdgeInsets.only(
                                              right: Dimenstions.width10 / 2),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  Dimenstions.radius15 / 2),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      AppConstants.BASE_URI +
                                                          '/upload/' +
                                                          getCartHistoryList[listCounter -
                                                              1].img!
                                                  )
                                              )
                                          ),

                                        )
                                            : Container();
                                      }),
                                    ),
                                    Container(
                                      height: Dimenstions.height20 * 4,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .end,
                                        children: [
                                          smallText(text: 'Total',
                                              color: AppColors.titelColor),
                                          bigText(
                                              text: itemPerOrder[i].toString() +
                                                  ' Items',
                                              color: AppColors.titelColor),
                                          GestureDetector(
                                            onTap: () {
                                              var orderTime = cartOrderTimeToList();
                                              Map<int, CartModel> moreOrder = {
                                              };
                                              for (int j = 0; j <
                                                  getCartHistoryList
                                                      .length; j++) {
                                                if (getCartHistoryList[j]
                                                    .time ==
                                                    orderTime[i]) {
                                                  moreOrder.putIfAbsent(
                                                      getCartHistoryList[j]
                                                          .id!, () =>
                                                      CartModel.fromJson(
                                                          jsonDecode(
                                                              jsonEncode(
                                                                  getCartHistoryList[j])))
                                                  );
                                                }
                                              }
                                              Get
                                                  .find<CartController>()
                                                  .setItems = moreOrder;
                                              Get.find<CartController>()
                                                  .addToCartList();
                                              Get.toNamed(
                                                  RouteHelper.getCartPage());
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: Dimenstions
                                                      .width10,
                                                  vertical: Dimenstions
                                                      .height10 / 2),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(
                                                      Dimenstions.radius15 / 3),
                                                  border: Border.all(width: 1,
                                                      color: AppColors
                                                          .mainColor)
                                              ),
                                              child: smallText(text: 'one more',
                                                  color: AppColors.mainColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              )
              :SizedBox(
                height: MediaQuery.of(context).size.height/1.5,
                  child: Center(child: NoDataScreen(text: 'You didnt buy anything so far !!' , imgPath: 'assets/images/empty_box.png',)));
            }
            ,
          )

        ],
      ),
    );
  }
}
