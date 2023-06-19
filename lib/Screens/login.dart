import 'package:flutter/material.dart';
import 'package:prism_medico/Screens/forget_pass.dart';
import 'package:prism_medico/Screens/register.dart';
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/Utilities/size_Confige.dart';
import 'package:prism_medico/Widgets/CustomTextFormField.dart';
import 'package:prism_medico/Widgets/Custom_Bakground.dart';
import 'dart:math';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = true;

  @override
  void initState() {
    _passwordVisible = false;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          CustomBGWidget(),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3,
                  ),
                  child: Image.asset(
                    "assets/images/Prism logo 1.png",
                    height: 80,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                CustomTextFieldWidget(
                  labelText: "Enter Email / Phone no",
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 80),
                Container(
                  height: 55,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    // controller: _userPasswordController,
                    obscureText:
                        !_passwordVisible, //This will obscure text dynamically
                    decoration: InputDecoration(
                      labelText: 'Enter Password',

                      // Here is key idea
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      labelStyle: new TextStyle(
                        color: Colors.grey,
                        fontFamily: "Poppins-Regular",
                        fontSize: 12,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    child: Text(
                      "Forget Password ?",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins-Regular",
                        fontSize: 12,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPassword()));
                    },
                  ),
                ),
                SizedBox(height: 20),
                FlatButton(
                  height: 60,
                  minWidth: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsets.all(10),
                  shape: (RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    //side: BorderSide(color: Colors.red)
                  )),
                  textColor: Colors.white,
                  color: MyColors.themecolor,
                  onPressed: () {
                    setState(() {
                      // istapped = 'Button tapped';
                    });
                  },
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins-Semibold",
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 80),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "By Signing up, you're agree to our",
                              style: TextStyle(
                                fontFamily: "Poppins-Medium",
                                fontSize: 10,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              child: Text(
                                "Terms & Conditions",
                                style: TextStyle(
                                  color: Colors.blue.shade300,
                                  fontFamily: "Poppins-Medium",
                                  fontSize: 10,
                                ),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Text(
                              "and",
                              style: TextStyle(
                                fontFamily: "Poppins-Medium",
                                fontSize: 10,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              child: Text(
                                "Privacy Policy",
                                style: TextStyle(
                                  color: Colors.blue.shade300,
                                  fontFamily: "Poppins-Medium",
                                  fontSize: 10,
                                ),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't Have An Account ?",
                      style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontFamily: "Poppins-Bold",
                          fontSize: 14,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
