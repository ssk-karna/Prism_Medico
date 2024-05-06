import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prism_medico/Screens/splash_screen.dart';
import 'package:prism_medico/utills/MyHttp_Overrides.dart';

void main() async {

 // WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp();
  AwesomeNotifications().initialize("assets/images/Prism-logo.png", [
    NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Prism_medico',
        channelDescription: 'For tws')
  ]);
 // HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

