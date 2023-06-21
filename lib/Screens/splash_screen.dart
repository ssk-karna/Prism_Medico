import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prism_medico/Screens/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset("assets/images/Doodle 1.png", fit: BoxFit.fill),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/images/Doodle 2.png",
            ),
          ),
          Center(
            child: Image.asset(
              "assets/images/Prism-logo.png",
            ),
          ),
        ],
      ),
    );
  }
}
