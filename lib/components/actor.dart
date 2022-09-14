import 'package:cinema_application/models/cast_model.dart';
import 'package:flutter/material.dart';

Widget cast({
  required MovieCastModel cast,
}) {

  return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        width: 150,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: 130,
                width: 130,
                decoration:  const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [Color(0xffff5983),Colors.deepOrangeAccent,Colors.orangeAccent]),
                      //Colors.pinkAccent
                ),
              ),
              top: 0,
              left: 0,
            ),

            Positioned(
              left: 5,
              top: 5,
              child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(cast.image),
                      minRadius: 60,
                    ),
                    /*
                    Image(image: NetworkImage(address),height: 150,width: 120,
                    fit: BoxFit.cover,),*/
                    const SizedBox(height: 10,),
                    Text(cast.name , style: const TextStyle(color: Colors.white),)
                  ]
              ),
            ),
          ],
        ),
      )
  );
}