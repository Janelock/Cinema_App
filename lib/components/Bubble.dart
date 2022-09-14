import 'package:flutter/material.dart';

Widget Bubble(String text,double width) {
  return Container(
    child: Center(child: Text(text,
      style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),)),
    height: 35,
    width: width,
    decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.grey),
        borderRadius: BorderRadius.circular(30)
    ),
  );
}