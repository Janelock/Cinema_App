import 'package:flutter/material.dart';
Widget defaultButton({
  double fontSize=20,
  double width=130.0,
  double height=40.0,
  Color background =Colors.black,
  Color textColor=Colors.black87,
  required String text,
  double radius=18.0,
  FontWeight fontWeight=FontWeight.normal,
  required Function function
}){
  return ElevatedButton(
      onPressed: (){
        function();
      },
      child: Text(text,style: TextStyle(fontSize: fontSize,color: textColor,fontWeight: fontWeight),),
      style: ElevatedButton.styleFrom(
          backgroundColor:background,
          minimumSize: Size(width,height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          )
      )
  );
}