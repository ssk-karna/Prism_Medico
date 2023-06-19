import 'package:flutter/material.dart';
import 'package:prism_medico/Screens/otp.dart';
import 'package:prism_medico/Screens/reset_Password.dart';
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/Widgets/Custom_Bakground.dart';
import 'package:prism_medico/Widgets/Custom_TextField_Shade.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            CustomBGWidget(),
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                          fontFamily: "Poppins-SemiBold",
                          fontSize: 24,
                          color: MyColors.textcolor),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "We will send a one time SMS message.",
                      style: TextStyle(
                          fontFamily: "Poppins-Normal",
                          fontSize: 14,
                          color: Colors.grey),
                    ),
                  ),
                  //SizedBox(height: MediaQuery.of(context).size.height / 10),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Carrier rates may apply.",
                      style: TextStyle(
                          fontFamily: "Poppins-Normal",
                          fontSize: 14,
                          color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 17,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 8.0,
                          color: Colors.grey.withOpacity(0.7),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        // controller: _userPasswordController,

                        decoration: InputDecoration(
                            labelText: 'Enter your phone',
                            labelStyle: new TextStyle(
                              color: Colors.grey,
                              fontFamily: "Poppins-Regular",
                              fontSize: 12,
                            ),
                            border: InputBorder.none),
                      ),
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
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => otpVerify()));
                      setState(() {
                        // istapped = 'Button tapped';
                      });
                    },
                    child: Text(
                      'Next',
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
