import 'package:flutter/material.dart';
import 'package:food_delivary_app/shared/app_colors.dart';
import 'package:food_delivary_app/shared/dimenstion.dart';
import 'package:get/get.dart';

Widget bigText({
  Color color = const Color(0xFF332d2b) ,
  required String text ,
  double size =0 ,
  TextOverflow textOverflow = TextOverflow.ellipsis
}) => Text( '$text' ,
  overflow: textOverflow,
  maxLines: 1,
  style: TextStyle (
    fontFamily: 'Roboto',
    color: color ,
    fontSize: size==0?Dimenstions.font20 :size,
    fontWeight: FontWeight.w400
  ),
);

Widget smallText({
  Color color = const Color(0xFFccc7c5) ,
  required String text ,
  double hight =1.2 ,
  double size =12 ,
}) => Text( '$text' ,
  style: TextStyle (
    fontFamily: 'Roboto',
    color: color ,
    fontSize: size ,
    height: hight
  ),
);

Widget IconAndText ({
  required IconData icon ,
  required String text ,
  required Color iconColor}) => Row(
  children: [
    Icon(icon, color: iconColor, size: Dimenstions.iconSize24,) ,
    SizedBox(width: 5,) ,
    smallText(text: text )

  ],
);

Widget AppIcon({
  required IconData icon ,
  double size = 40,
  double  iconSize = 16 ,
  Color backgroundColor = const Color(0xFFfcf4e4) ,
  Color iconColor = const Color(0xFF756d54)
}) => Container(
  width: size,
  height: size,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(size/2) ,
    color: backgroundColor
  ),
  child:   Icon(
    icon ,
    color: iconColor,
    size: iconSize,

  ),
);

Widget AppColumn ({required String text }) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    bigText(text: text , size: Dimenstions.font26),
    SizedBox(
      height: Dimenstions.height10,
    ),
    Row(
      children: [
        Wrap(
          children: List.generate(
              5,
                  (index) => Icon(
                Icons.star,
                color: AppColors.mainColor,
                size: 15,
              )),
        ),
        SizedBox(
          width: Dimenstions.width10,
        ),
        smallText(text: '4.5'),
        SizedBox(
          width: Dimenstions.width10,
        ),
        smallText(text: '1289'),
        SizedBox(
          width: Dimenstions.width10,
        ),
        smallText(text: 'comments'),
      ],
    ),
    SizedBox(
      height: Dimenstions.height20, //20
    ),
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
);

Widget AccountWidget({required IconData icon , required Color color ,String text = 'none' }){
  return Container(
   // color : Colors.white,
  padding: EdgeInsets.only(
  top:Dimenstions.height10 ,
   bottom: Dimenstions.height10 ,
left: Dimenstions.width20

  ),
    child: Row(
      children: [
        AppIcon(icon: icon , backgroundColor :color ,
        iconColor:Colors.white ,
        iconSize: Dimenstions.height10*5/2 ,
        size: Dimenstions.height10*5) ,
        SizedBox(width: Dimenstions.width20) ,
        bigText(text: text)

      ],
    ),
    decoration: BoxDecoration(
      color:Colors.white ,
      boxShadow: [
        BoxShadow(
          blurRadius: 1,
        offset: Offset(0,2) ,
        color: Colors.grey.withOpacity(0.2)
      )
  ]
    ),
  ) ;
}

Widget AppTextFeild({
  required String hintText ,
  required TextEditingController controller ,
  required IconData icon ,
  bool isObscure = false ,
  bool maxLines=false
}){
  return Container(
    margin: EdgeInsets.only(left: Dimenstions.height20 , right: Dimenstions.height20),
    decoration: BoxDecoration(
        color: Colors.white ,
        borderRadius: BorderRadius.circular(Dimenstions.radius15),
        boxShadow: [
          BoxShadow(
              blurRadius: 3 ,
              spreadRadius: 1 ,
              offset: Offset(1,1) ,
              color: Colors.grey.withOpacity(0.2)
          )
        ]
    ),
    child: TextField(
      obscureText: isObscure ,
      controller: controller,
      maxLines: maxLines?3:1,
      decoration: InputDecoration(
          hintText: '$hintText' ,

          prefixIcon: Icon(icon, color:AppColors.yellowColor),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimenstions.radius15),
              borderSide: BorderSide(
                  width: 1 ,
                  color: Colors.white
              )
          ) ,
          enabledBorder : OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimenstions.radius15),
              borderSide: BorderSide(
                  width: 1 ,
                  color: Colors.white
              )
          ) ,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimenstions.radius15),

          )
      ),
    ),
  ) ;
}

void showCustomSnackBar(String message , {bool isError =true , String title ="Error"}) {
  Get.snackbar(title, message,
      titleText: bigText(text: title, color: Colors.white),
      messageText: Text(message, style: TextStyle(
          color: Colors.white
      ),),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      backgroundColor: isError ? Colors.redAccent : Colors.lightGreen
  );
}

  Widget CustomLoader(){
    return Center(
      child: Container(
        height: Dimenstions.height20*5,
        width: Dimenstions.height20*5 ,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimenstions.height20*5/2),
            color: AppColors.mainColor
          ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }

  Widget CustomButton({
    required BuildContext context ,
    VoidCallback? onPressed ,
    required String buttonText ,
     bool transparent = false ,
    EdgeInsets? margin ,
    double? height ,
    double? width ,
    double? fontSize ,
    double radius =5 ,
    IconData? icon
}){
  final ButtonStyle _flatButton =TextButton.styleFrom(
    backgroundColor: onPressed == null ?Theme.of(context).disabledColor:transparent?Colors.transparent:Theme.of(context).primaryColor ,
    minimumSize: Size(width == null ? Dimenstions.screenWidth : width , height !=null ? height : 50),
    padding: EdgeInsets.zero ,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius)
    )

  );
  return Center(
    child: SizedBox(
      width: width ?? Dimenstions.screenWidth,
      height: height ?? 50,
      child: TextButton(
        onPressed:onPressed,
        style:_flatButton,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon!=null ? Padding(
              padding: EdgeInsets.only(right: Dimenstions.width10/2),
              child: Icon(icon , color: transparent ? Theme.of(context).primaryColor : Theme.of(context).cardColor),
            )
                :SizedBox()
            ,
            Text(buttonText ,
            style: TextStyle(
              fontSize:  fontSize != null ? fontSize : Dimenstions.font16 ,
              color: transparent ? Theme.of(context).primaryColor : Theme.of(context).cardColor
            ),)
          ],
        ),
      ),

    ),
  );
  }
  
  PreferredSizeWidget CustomAppBar({required BuildContext context ,required String title , bool backButtonExist =true , Function? onBackPressed}){
  return AppBar(
    backgroundColor: AppColors.mainColor,
    elevation: 0,
    title: bigText(text: title ,color: Colors.white),
    centerTitle: true,
    leading: backButtonExist? IconButton(onPressed: ()=>onBackPressed!=null ? onBackPressed() : Navigator.pushReplacementNamed(context, '/initial'),
        icon: Icon(Icons.arrow_back_ios)) : SizedBox()
    
  );
  }

  Widget CommonTextButton({required String text}){
  return Container(
    padding: EdgeInsets.all(Dimenstions.height20),
    child: Center(child: bigText(text: text, color: Colors.white)),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          offset: Offset(0,5),
          blurRadius: 10,
          color: AppColors.mainColor.withOpacity(0.3)
        )
      ],
        borderRadius: BorderRadius.circular(Dimenstions.radius20),
        color: AppColors.mainColor
    ),
  );
  }