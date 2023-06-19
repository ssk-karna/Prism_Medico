import 'package:flutter/material.dart';

class CustomBGWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            "assets/images/Doodle 1.png",
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Image.asset(
            "assets/images/E2.png",
            //height: MediaQuery.of(context).size.height / 3,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Image.asset(
            "assets/images/E1.png",
          ),
        ),
      ],
    );
  }
}
