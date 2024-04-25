import 'dart:async';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:prism_medico/Screens/login.dart';
import 'package:prism_medico/utills/Session_Manager.dart';
import 'package:prism_medico/utills/Constant.dart';
import 'package:prism_medico/model/latestProduct.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences sharedPreferences;
  List<Latest_Product_model> cart = [];

  void initState() {
    SessionManager.isUserLogin().then((value) => {
          if (value == true)
            {
              SessionManager.isUserId().then((id) => {
                    if (userDetails.id == id)
                      {
                        SessionManager.getcartList().then((data) {
                          setState(() {
                            cart = data;
                          });
                        }),
                        Future.delayed(Duration(seconds: 3), () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Homepage(
                                        cart: cart,
                                      )));
                        })
                      }
                  }),
            }
          else
            {
              Future.delayed(Duration(seconds: 3), () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen(
                              cart: cart,
                            )));
              })
            }
        });
    super.initState();
    // Timer(
    //     Duration(seconds: 5),
    //     () => Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (context) => LoginScreen())));
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
