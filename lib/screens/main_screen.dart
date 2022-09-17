import 'package:flutter/material.dart';
import 'package:food_delivary_app/controllers/Popular_product_controller.dart';
import 'package:food_delivary_app/controllers/recommended_product_controller.dart';
import 'package:food_delivary_app/helper/route_helper.dart';
import 'package:food_delivary_app/models/product_model.dart';
import 'package:food_delivary_app/shared/app_colors.dart';
import 'package:food_delivary_app/shared/app_constants.dart';
import 'package:food_delivary_app/shared/componants.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:food_delivary_app/shared/dimenstion.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  double _scaleFactory = 0.8;

  double _hight = Dimenstions.pageViewContainer; //220

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      /*
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white24,
        title: Container(
          margin: EdgeInsetsDirectional.only(top:Dimenstions.height10 , ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            bigText(text: 'city', color: AppColors.mainColor, size: 30),
            Row(
              children: [
                smallText(text: 'City', color: Colors.black54),
                Icon(Icons.arrow_drop_down_rounded , color: Colors.black54,)
              ],
            ) ,
                SizedBox(height: Dimenstions.height10,)
          ]),
        ),
        actions: [
          Center(
            child: Container(
              margin: EdgeInsetsDirectional.only(end: Dimenstions.width20 ),
              width: Dimenstions.width45,
              height: Dimenstions.height45,
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: Dimenstions.iconSize24,
              ),
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(Dimenstions.radius15),
                  color: AppColors.mainColor),
            ),
          )
        ],
      ),

       */
       RefreshIndicator(
        child: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                margin: EdgeInsets.only(
                    top: Dimenstions.height45, bottom: Dimenstions.height15),
                padding: EdgeInsets.only(
                    left: Dimenstions.width20, right: Dimenstions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      bigText(text: 'city', color: AppColors.mainColor, size: 30),
                      Row(
                        children: [
                          smallText(text: 'City', color: Colors.black54),
                          Icon(Icons.arrow_drop_down_rounded)
                        ],
                      )
                    ]),
                    Center(
                      child: Container(
                        width: Dimenstions.width45,
                        height: Dimenstions.height45,
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: Dimenstions.iconSize24,
                        ),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimenstions.radius15),
                            color: AppColors.mainColor),
                      ),
                    )
                  ],
                ),
              ),
             // SizedBox(height: Dimenstions.height10,) ,
             GetBuilder<PopularProductController>(builder: (popularProducts){
               return popularProducts.isLoaded
                   ?Container(
                 height: Dimenstions.pageView, //320
                 child: PageView.builder(
                     itemCount: popularProducts.popularProductList.length,
                     controller: pageController,
                     itemBuilder: (context, index) {
                       return BuildPageViewItem(index , popularProducts.popularProductList[index]);
                     }),
               )
               :CircularProgressIndicator(color: AppColors.mainColor,);
             }),
              GetBuilder<PopularProductController>(builder: (popularProducts){
                return DotsIndicator(
                    dotsCount: popularProducts.popularProductList.isEmpty ?1 :popularProducts.popularProductList.length,
                    position: _currentPageValue,
                    decorator: DotsDecorator(
                        activeColor: AppColors.mainColor,
                        size: Size.square(9),
                        activeSize: Size(18, 9),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)))) ;
              }) ,
              SizedBox(height: Dimenstions.height30,) ,
              Container(
                margin: EdgeInsets.only(left: Dimenstions.width30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    bigText(text: 'Recommended') ,
                    SizedBox(width: Dimenstions.width10,) ,
                    Container(
                      margin: EdgeInsets.only(bottom: 3),
                      child: bigText(text: '.' ,color:Colors.black26),
                    ) ,
                    SizedBox(width: Dimenstions.width10,) ,
                    Container(
                      margin: EdgeInsets.only(bottom: 2),
                      child: smallText(text: 'Food Pairing' ),
                    )
                  ],
                ),
              ) ,
              GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
                return recommendedProduct.isLoaded
               ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: recommendedProduct.recommendedProductList.isEmpty ?1:recommendedProduct.recommendedProductList.length,
                    itemBuilder: (context , index) =>BuildRcommendedListItem(index , recommendedProduct.recommendedProductList[index])
                )
                    : CircularProgressIndicator(
                  color: AppColors.mainColor,
                ) ;
              })
            ],
          ),
        ),
        onRefresh: getResources,

    );
  }
  Future<void> getResources () async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  Widget BuildPageViewItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactory);
      var currentTrans = _hight * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currentScale =
          _scaleFactory + (_currentPageValue - index + 1) * (1 - _scaleFactory);
      var currentTrans = _hight * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactory);
      var currentTrans = _hight * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currentScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, _hight * (1 - _scaleFactory) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getPopularFood(index , 'home'));
            },
            child: Container(
              height: Dimenstions.pageViewContainer, //220
              margin: EdgeInsets.only(
                  left: Dimenstions.width10, right: Dimenstions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimenstions.radius30),
                  color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.BASE_URI+'/uploads/'+ popularProduct.img!))),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimenstions.pageViewTextContainer, //120
              margin: EdgeInsets.only(
                  left: Dimenstions.width30,
                  right: Dimenstions.width30,
                  bottom: Dimenstions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimenstions.radius20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0))
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimenstions.height15,
                    left: Dimenstions.width15,
                    right: Dimenstions.width15),
                child: AppColumn(text: popularProduct.name!)
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget BuildRcommendedListItem(index, ProductModel recommendedProduct) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(RouteHelper.getRecommendedFood(index , 'home')) ;
      },
      child: Container(
        margin: EdgeInsets.only(left: Dimenstions.width20 , right: Dimenstions.width20 , bottom: Dimenstions.height10),
        child: Row(
          children: [
            Container(
              width: Dimenstions.ListImageContainer,
              height: Dimenstions.ListImageContainer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimenstions.radius20),
                color: Colors.white38 ,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConstants.BASE_URI+'/uploads/'+ recommendedProduct.img!)
                )
              ),

            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: Dimenstions.height10, right: Dimenstions.height10),
                height: Dimenstions.ListTextContainerHeight,
               // width: Dimenstions.ListTextContainerWidth ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(Dimenstions.radius20) ,
                    bottomEnd: Radius.circular(Dimenstions.radius20)
                  ) ,
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    bigText(text: recommendedProduct.name!, color: AppColors.mainBlackColor),
                    SizedBox(height: Dimenstions.height10,) ,
                    smallText(text: recommendedProduct.name!) ,
                    SizedBox(height: Dimenstions.height10,) ,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndText(
                            icon: Icons.circle_sharp,
                            iconColor: AppColors.iconColor1,
                            text: 'Normal'),
                        SizedBox(
                          width: Dimenstions.width10,
                        ),
                        IconAndText(
                            icon: Icons.location_on,
                            iconColor: AppColors.mainColor,
                            text: '1.7km'),
                        SizedBox(
                          width: Dimenstions.width10,
                        ),
                        IconAndText(
                            icon: Icons.access_time_rounded,
                            iconColor: AppColors.iconcolor2,
                            text: '32min'),
                        SizedBox(
                          width: Dimenstions.width10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
