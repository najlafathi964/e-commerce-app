import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivary_app/controllers/order_controller.dart';
import 'package:food_delivary_app/models/order_model.dart';
import 'package:food_delivary_app/shared/app_colors.dart';
import 'package:food_delivary_app/shared/componants.dart';
import 'package:food_delivary_app/shared/dimenstion.dart';
import 'package:food_delivary_app/shared/style.dart';
import 'package:get/get.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;
  const ViewOrder({Key? key , required this.isCurrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(
        builder: (orderController){
          if(orderController.isLoading==false){
            late List<OrderModel> orderList;
            if(orderController.currentOrderList.isNotEmpty){
              orderList=isCurrent?orderList=orderController.currentOrderList.reversed.toList():
               orderController.historyOrderList.reversed.toList();
            }
            return SizedBox(
              width: Dimenstions.screenWidth,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: Dimenstions.width10/2 , vertical:  Dimenstions.height10/2),
                child: ListView.builder(
                  itemCount: orderList.length,
                    itemBuilder: (context,index){
                      return InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text('order Id', style: robotoRegular.copyWith(
                                        fontSize: Dimenstions.font12
                                      ),),
                                      SizedBox(width: Dimenstions.width10/2,),
                                      Text('#${orderList[index].id.toString()}'),
                                    ],
                                  ) ,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.mainColor ,
                                          borderRadius: BorderRadius.circular(Dimenstions.radius20/4)
                                        ),
                                          padding: EdgeInsets.symmetric(horizontal: Dimenstions.width10,
                                          vertical: Dimenstions.width10/2),
                                          child: Text('${orderList[index].orderStatus}' ,
                                          style: robotoMedium.copyWith(
                                            fontSize: Dimenstions.font12,
                                            color: Theme.of(context).cardColor
                                          )
                                            ,)),
                                      SizedBox(height: Dimenstions.height10/2,),
                                      InkWell(
                                        onTap: (){},
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: Dimenstions.width10,
                                          vertical: Dimenstions.width10/2),
                                            decoration: BoxDecoration(
                                                color:Colors.white ,
                                                borderRadius: BorderRadius.circular(Dimenstions.radius20/4),
                                              border: Border.all(width: 1,color: Theme.of(context).primaryColor)
                                            ),
                                            child: Container(
                                                margin: EdgeInsets.all(Dimenstions.height10/2) ,
                                                child: Text('Track Order', style: robotoMedium.copyWith(
                                                  fontSize: Dimenstions.font12 ,
                                                  color:Theme.of(context).primaryColor
                                                ),))),

                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: Dimenstions.height10,)
                          ],
                        ),
                      );
                    }),
              ),
            );
          }else{
            return CustomLoader();
          }
        },
      ),
    );
  }
}
