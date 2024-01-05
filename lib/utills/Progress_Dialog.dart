import 'package:flutter/material.dart';

class ProgressDialog {

  static final ProgressDialog _instance = ProgressDialog._internal();
  factory ProgressDialog() {
    return _instance;
  }

 ProgressDialog._internal();

   void showProgressDialog(BuildContext context) {
    _showDialog(context);
  }

  bool _isDialogVisible = false;

   _showDialog(BuildContext context) {

  //  if (!_isDialogVisible) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
 //   }
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
  void hideProgressDialog(BuildContext context) {
    _hideDialog(context);
  }

  void _hideDialog(BuildContext context) {
    //if (_isDialogVisible) {
      _isDialogVisible = false;
      Navigator.of(context).pop();
    //}
  }
}
