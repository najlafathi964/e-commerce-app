import 'package:flutter/material.dart';
import 'package:food_delivary_app/controllers/Popular_product_controller.dart';
import 'package:food_delivary_app/controllers/cart_controller.dart';
import 'package:food_delivary_app/helper/route_helper.dart';
import 'package:food_delivary_app/models/product_model.dart';
import 'package:food_delivary_app/shared/app_colors.dart';
import 'package:food_delivary_app/shared/app_constants.dart';
import 'package:food_delivary_app/shared/componants.dart';
import 'package:food_delivary_app/shared/dimenstion.dart';
import 'package:food_delivary_app/shared/expanded_text_widget.dart';
import 'package:get/get.dart';

class PopularFoodDetailsScreen extends StatelessWidget{
  final int pageId ;
  final String page ;
  PopularFoodDetailsScreen({Key? key , required this.pageId , required this.page}):super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductModel product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product ,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: Dimenstions.FoodDetailsImageSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(AppConstants.BASE_URI+'/uploads/'+product.img!)
                  )
                ),
              )
          ) ,
          Positioned(
            top: Dimenstions.height20,
            left: Dimenstions.width20,
              right: Dimenstions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      if(page == 'cartPage') {
                        Get.toNamed(RouteHelper.getCartPage());
                      }else{
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                      child: AppIcon(icon: Icons.arrow_back_ios)) ,
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getCartPage());

                      } ,
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                          Get.find<PopularProductController>().totalItems >=1
                          ? Positioned(
                            right:0,
                              top: 0 ,
                              child: AppIcon(icon: Icons.circle , size: 16 ,iconColor: Colors.transparent ,backgroundColor:  AppColors.mainColor))
                              :Container() ,
                          Get.find<PopularProductController>().totalItems >=1
                              ? Positioned(
                              right:4,
                              top: 2 ,
                              child: bigText(text: Get.find<PopularProductController>().totalItems.toString() ,
                              size: 12 , color: Colors.white) )
                              :Container()
                        ],
                      ),
                    ) ;
                  })
                ],
              )
          ) ,
          Container(
            margin: EdgeInsets.only(top: Dimenstions.FoodDetailsImageSize-20),
            padding: EdgeInsets.only(
          left: Dimenstions.width20 , right: Dimenstions.width20 , top: Dimenstions.height20
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimenstions.radius20),
                topRight: Radius.circular(Dimenstions.radius20)
              ) ,
              color: Colors.white
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppColumn(text: product.name!),
                SizedBox(height: Dimenstions.height20,) ,
                bigText(text: 'Indroduce') ,
                SizedBox(height: Dimenstions.height20,) ,
                Expanded(
                  child: SingleChildScrollView(
                    child: ExpandedTextWidget(text: product.description!),
                )
                )

              ],
            )
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProdect){
          return Container(
            height: Dimenstions.bottomHeightBar,
            padding: EdgeInsets.only(
                top: Dimenstions.height30 ,
                bottom: Dimenstions.height30 ,
                right: Dimenstions.width20 ,
                left: Dimenstions.width20
            ),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimenstions.radius20*2) ,
                    topLeft: Radius.circular(Dimenstions.radius20*2)
                )

            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(Dimenstions.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimenstions.radius20) ,
                      color: Colors.white
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap:(){
                          popularProdect.setQuantity(false);
                        },
                          child: Icon(Icons.remove , color: AppColors.signColor)) ,
                      SizedBox(width: Dimenstions.width10/2,) ,
                      bigText(text: popularProdect.inCartItem.toString()) ,
                      SizedBox(width: Dimenstions.width10/2,) ,
                      GestureDetector(
                          onTap: (){
                          popularProdect.setQuantity(true);
                          },
                          child: Icon(Icons.add , color: AppColors.signColor)) ,

                    ],
                  ),
                ) ,
                GestureDetector(
                  onTap: (){
                    popularProdect.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.all(Dimenstions.height20),
                    child: bigText(text: '\$ ${product.price!}|Add To Cart', color: Colors.white),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimenstions.radius20),
                        color: AppColors.mainColor
                    ),
                  ),
                )
              ],
            ),

          );
        }
      ),
    );
  }

}