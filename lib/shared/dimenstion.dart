import 'package:get/get.dart';

class Dimenstions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;
  // screenHeight/pageViewContainerHeight  لنجيب عامل التغير  844/320= 2.64
  static double pageView = screenHeight/2.64;
  // screenHeight/pageViewContainerHeight  لنجيب عامل التغير  844/220= 3.84
  static double pageViewContainer = screenHeight/3.84;
  // screeneHight/pageViewTextContainerHeight  لنجيب عامل التغير  844/120= 7.03
  static double pageViewTextContainer = screenHeight/7.03;

  static double ListTextContainerHeight = screenHeight/8.44;  //100

  static double ListImageContainer = screenHeight/7.03;  //120

  static double FoodDetailsImageSize = screenHeight/2.41;  //350




  static double height10 =screenHeight/84.4 ;
  static double height15 =screenHeight/56.27 ;
  static double height20 =screenHeight/42.2 ;
  static double height30 =screenHeight/28.13 ;
  static double height45 =screenHeight/18.76 ;

  static double width10 =screenHeight/84.4 ;
  static double width15 =screenHeight/56.27 ;
  static double width20 =screenHeight/42.2 ;
  static double width30 =screenHeight/28.13 ;
  static double width45 =screenHeight/18.76 ;

  static double font12 =screenHeight/70.33 ;
  static double font16 =screenHeight/52.75 ;
  static double font20 =screenHeight/42.2 ;
  static double font26 =screenHeight/32.46 ;

  static double radius15 =screenHeight/56.27 ;
  static double radius20 =screenHeight/42.2 ;
  static double radius30 =screenHeight/28.13 ;

  static double iconSize24 =screenHeight/35.17;
  static double iconSize16 =screenHeight/52.75;

  static double bottomHeightBar =screenHeight/7.03;

  static double splashScreenImage =screenHeight/3.38; //250







}