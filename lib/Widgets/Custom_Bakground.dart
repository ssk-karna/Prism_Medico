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
          alignment: Alignment.topCenter,
          child: Image.asset(
            "assets/images/Group 1344.png",
            fit: BoxFit.fill,
            //height: MediaQuery.of(context).size.height / 3,
          ),
        ),
      ],
    );
  }
}
