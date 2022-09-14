import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cinema_application/Screens/Register_screen.dart';
import 'package:flutter/material.dart';

class startSplashScreen extends StatelessWidget {
  const startSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 3000,
        splash: Center(child: Image.asset('assets/image/startLogo.png')),
        nextScreen: (RegisterScreen()),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.grey.shade900,
      splashIconSize: 700,
    );
  }
}
