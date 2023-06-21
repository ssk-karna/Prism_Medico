import 'package:flutter/material.dart';
import 'package:prism_medico/Screens/reset_Password.dart';
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/Utilities/size_Confige.dart';
import 'package:prism_medico/Widgets/CustomTextFormField.dart';
import 'package:prism_medico/Widgets/Custom_Bakground.dart';
import 'package:prism_medico/Widgets/Custom_TextField_Shade.dart';

class otpVerify extends StatefulWidget {
  @override
  _otpVerifyState createState() => _otpVerifyState();
}

class _otpVerifyState extends State<otpVerify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            CustomBGWidget(),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 3.3),
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Verify Phone Number",
                      style: TextStyle(
                        fontFamily: "Poppins-SemiBold",
                        fontSize: 24,
                        color: MyColors.textcolor,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Enter  the OTP sent to on",
                      style: TextStyle(
                          fontFamily: "Poppins-REgular",
                          fontSize: 14,
                          color: Colors.grey),
                    ),
                  ),
                  // SizedBox(height: MediaQuery.of(context).size.height / 120),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "+91 00000 00000",
                        style: TextStyle(
                            fontFamily: "Poppins-Regular",
                            fontSize: 14,
                            color: Colors.grey),
                      ),
                      Text(
                        "Change",
                        style: TextStyle(
                            fontFamily: "Poppins-Semibold",
                            fontSize: 14,
                            color: MyColors.themecolor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextFieldShade(
                        height: MediaQuery.of(context).size.height / 12,
                        width: MediaQuery.of(context).size.width / 6,
                        labelText: "1",
                      ),
                      CustomTextFieldShade(
                        height: MediaQuery.of(context).size.height / 12,
                        width: MediaQuery.of(context).size.width / 6,
                        labelText: "2",
                      ),
                      CustomTextFieldShade(
                        height: MediaQuery.of(context).size.height / 12,
                        width: MediaQuery.of(context).size.width / 6,
                        labelText: "3",
                      ),
                      CustomTextFieldShade(
                        height: MediaQuery.of(context).size.height / 12,
                        width: MediaQuery.of(context).size.width / 6,
                        labelText: "4",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 3.1),
                    width: MediaQuery.of(context).size.width / 1,
                    child: Row(
                      children: [
                        Text(
                          "Didn't receive the OTP ?",
                          style: TextStyle(
                              fontFamily: "Poppins-semibold",
                              fontSize: 12,
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Resend SMS",
                          style: TextStyle(
                              fontFamily: "Poppins-Semibold",
                              fontSize: 12,
                              color: MyColors.themecolor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  FlatButton(
                    // height: ,
                    minWidth: MediaQuery.of(context).size.width / 3,
                    padding: EdgeInsets.all(10),
                    shape: (RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      //side: BorderSide(color: Colors.red)
                    )),
                    textColor: Colors.white,
                    color: MyColors.themecolor,
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResetPassword()));
                      setState(() {
                        // istapped = 'Button tapped';
                      });
                    },
                    child: Text(
                      'Verify',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins-Semibold",
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
