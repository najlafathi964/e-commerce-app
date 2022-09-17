import 'package:flutter/material.dart';
import 'package:food_delivary_app/controllers/cart_controller.dart';
import 'package:food_delivary_app/controllers/recommended_product_controller.dart';
import 'package:food_delivary_app/helper/route_helper.dart';
import 'package:food_delivary_app/models/product_model.dart';
import 'package:food_delivary_app/shared/app_colors.dart';
import 'package:food_delivary_app/shared/app_constants.dart';
import 'package:food_delivary_app/shared/componants.dart';
import 'package:food_delivary_app/shared/dimenstion.dart';
import 'package:food_delivary_app/shared/expanded_text_widget.dart';
import 'package:get/get.dart';

import '../controllers/Popular_product_controller.dart';

class RecommenedFoodDetails extends StatelessWidget {
  final int pageId;
  final String page ;

  RecommenedFoodDetails({Key? key, required this.pageId , required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductModel product = Get
        .find<RecommendedProductController>()
        .recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product ,Get.find<CartController>());

    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        if(page == 'cartPage') {
                          Get.toNamed(RouteHelper.getCartPage());
                        }else{
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(icon: Icons.clear)),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                          controller.totalItems >=1
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
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(Dimenstions.height20),
                child: Container(
                  child: Center(
                      child:
                      bigText(text: product.name!, size: Dimenstions.font26)),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(
                      top: 5, bottom: Dimenstions.height10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimenstions.radius20),
                          topRight: Radius.circular(Dimenstions.radius20))),
                ),
              ),
              pinned: true,
              backgroundColor: AppColors.yellowColor,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConstants.BASE_URI + '/uploads/' + product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    child: ExpandedTextWidget(
                        text: product.description!),
                    margin: EdgeInsets.only(
                        left: Dimenstions.width20, right: Dimenstions.width20),
                  )
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
            builder: (controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimenstions.width20 * 2.5,
                        right: Dimenstions.width20 * 2.5,
                        top: Dimenstions.height10,
                        bottom: Dimenstions.height10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.setQuantity(false);
                          },
                          child: AppIcon(
                              iconSize: Dimenstions.iconSize24,
                              iconColor: Colors.white,
                              backgroundColor: AppColors.mainColor,
                              icon: Icons.remove),
                        ),
                        bigText(
                            text: ' \$ ${product.price!}  X ${controller.inCartItem} ',
                            color: AppColors.mainBlackColor,
                            size: Dimenstions.font26),
                        GestureDetector(
                          onTap: () {
                            controller.setQuantity(true);
                          },
                          child: AppIcon(
                              iconSize: Dimenstions.iconSize24,
                              iconColor: Colors.white,
                              backgroundColor: AppColors.mainColor,
                              icon: Icons.add),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: Dimenstions.bottomHeightBar,
                    padding: EdgeInsets.only(
                        top: Dimenstions.height30,
                        bottom: Dimenstions.height30,
                        right: Dimenstions.width20,
                        left: Dimenstions.width20),
                    decoration: BoxDecoration(
                        color: AppColors.buttonBackgroundColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(Dimenstions.radius20 * 2),
                            topLeft: Radius.circular(
                                Dimenstions.radius20 * 2))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(Dimenstions.height20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimenstions.radius20),
                              color: Colors.white),
                          child: Icon(
                            Icons.favorite,
                            color: AppColors.mainColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            controller.addItem(product);
                          },
                          child: Container(
                            padding: EdgeInsets.all(Dimenstions.height20),
                            child: bigText(
                                text: '\$ ${product.price!}|Add To Cart', color: Colors.white),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimenstions.radius20),
                                color: AppColors.mainColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
        )
    );
  }
}
