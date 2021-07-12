import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:triple_s_project/screens/auth/login_screen.dart';

class MainSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Student System',
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Image.asset('images/hend3.jpg'),
        nextScreen: LoginScreen(),
        splashIconSize: 250,
        backgroundColor: Colors.white,
        splashTransition: SplashTransition.scaleTransition,
        duration: 2000,
      ),
    );
  }
}
