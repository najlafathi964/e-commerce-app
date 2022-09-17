import 'package:flutter/material.dart';
import 'package:food_delivary_app/shared/app_colors.dart';
import 'package:food_delivary_app/shared/componants.dart';
import 'package:food_delivary_app/shared/dimenstion.dart';

class ExpandedTextWidget extends StatefulWidget{
  final String text ;
  const ExpandedTextWidget({Key? key , required this.text}):super(key: key);
  @override
  State<ExpandedTextWidget> createState() => _ExpandedTextWidget();
  }

  class _ExpandedTextWidget extends State<ExpandedTextWidget> {
  late String firstHalf ;
  late String seconedHalf ;
  bool hiddenText = true ;
  double textHight = Dimenstions.screenHeight/5.63 ;

  @override
  void initState(){
    super.initState();
    if(widget.text.length>textHight){
      firstHalf = widget.text.substring(0,textHight.toInt());
      seconedHalf = widget.text.substring(textHight.toInt()+1 , widget.text.length);
    }else{
      firstHalf =widget.text ;
      seconedHalf = '' ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  seconedHalf.isEmpty ? smallText(text: firstHalf, size: Dimenstions.font16)
      :Column(
        children: [
          smallText(hight: 1.8 ,color:AppColors.paraColor ,size: Dimenstions.font16 ,text: hiddenText? (firstHalf +'...'): (firstHalf+seconedHalf)),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText = !hiddenText ;
              });
            },
            child: Row(
              children: [
                smallText(size: Dimenstions.font16 , text: 'show more' , color:  AppColors.mainColor),
                Icon(hiddenText?Icons.arrow_drop_down: Icons.arrow_drop_up , color: AppColors.mainColor,)
              ],
            ),
          )
        ],
      ),
    );
  }

  }