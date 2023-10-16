import 'package:flutter/material.dart';

class ProgressDialog {
  static showProgressDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  static showProgressDialogWithMessage(BuildContext context, String message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 16,
                  ),
                  Text(message,
                      style: TextStyle(fontSize: 16, color: Colors.white))
                ],
              ),
            ),
          );
        });
  }
}
