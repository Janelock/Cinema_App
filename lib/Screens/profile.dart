import 'package:cinema_application/Screens/change_password.dart';
import 'package:cinema_application/components/default_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/profileData.dart';
import 'Login_screen.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50,),
              Container(
                child: const Center(
                  child: Icon(Icons.person, color: Colors.white, size: 50,),),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [ Color(0xffff5983), Colors.orangeAccent])
                ),
                height: 180,
                width: 180,
              ),
              const SizedBox(height: 20,),
              Text(username, style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10,),
              Text(emailAddress, style: const TextStyle(
                  fontSize: 20,
                  color: Colors.grey
              ),
              ),
              const SizedBox(height: 40,),
              /*Container(
                width: 350,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),

                *//*child: Row(
                  children: [
                    Expanded(child: const Icon(Icons.stars_outlined, size: 25,
                        color: Colors.orangeAccent), flex: 1,),
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: Text(points.toString() + " Points",
                          style: const TextStyle(color: Colors.orangeAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Expanded(child: Icon(Icons.stars_outlined, size: 25,
                      color: Colors.orangeAccent,), flex: 1,),
                  ],
                ),*//*
              ),*/
              Container(
                height: 50,
                width: 350,
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  gradient: LinearGradient(colors: [Color(0xffff5983),Colors.orangeAccent])
                ),
                child:  Row(
                  children: [
                    const SizedBox(width: 15,),
                    const Icon(TablerIcons.gift,color: Colors.white),
                    const SizedBox(width: 10,),
                    Text(points.toString() + " Points",
                      style: const TextStyle(color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              const SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePasswordScreen()));
                },
                  child: defaultContainer(
                    iconData: Icons.privacy_tip, text: "Change Password",),),

              InkWell(
                  onTap: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      print("logged out");
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    });
                  },
                  child: defaultContainer(
                      iconData: Icons.logout, text: 'LogOut')
              ),
            ],
          ),
        ),
      ),
    );
  }
}