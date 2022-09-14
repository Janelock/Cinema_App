import 'package:flutter/material.dart';
Widget gradientButton({
  double width=130.0,
  required Color first,second,
  required String text,
  Color textColor=Colors.black,
  double radius=18.0,
  double height=50,
  double fontSize=20,
  FontWeight fontWeight=FontWeight.normal,
  required Function function,
}) {
  return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        child: Center(child: Text(text,textAlign: TextAlign.center,style: TextStyle(color:textColor,fontSize: fontSize),)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          gradient: LinearGradient(colors:[first,second]),
        ),
        height: height,
        width: width,
      ));
}