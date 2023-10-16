import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prism_medico/Repo/Login.dart';
import 'package:prism_medico/Screens/forget_pass.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Screens/register.dart';
import 'package:prism_medico/Utilities/myColor.dart';

import 'package:prism_medico/Widgets/CustomTextFormField.dart';
import 'package:prism_medico/Widgets/Custom_Bakground.dart';

import 'package:prism_medico/utills/Constant.dart';
import 'package:prism_medico/model/User.dart';
import 'package:prism_medico/model/latestProduct.dart';
import 'package:prism_medico/utills/Internet_Connection.dart';
import 'package:prism_medico/utills/Progress_Dialog.dart';
import 'package:prism_medico/utills/Session_Manager.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  final User;
  final List<Latest_Product_model> cart;
  LoginScreen({Key key, this.User, this.cart}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState(this.cart);
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //SharedPreferences sharedPreferences;

  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _passwordVisible = true;
  String _mobileNo;
  String _password;
  String email;
  String loginData;
  _LoginScreenState(this.cart);
  List<Latest_Product_model> cart;
  bool _isUserInteracted = false;

  @override
  void initState() {
    _passwordVisible = false;
  }

  void _onTextChanged(String value) {
    setState(() {
      _isUserInteracted = true;
      _autoValidate = false;
    });
  }

  String _validateInput(String value) {
    if (!_isUserInteracted) {
      return null; // No validation error until the user interacts
    }

    if (value.isEmpty) {
      return 'Please enter a value.';
    }

    // Additional custom validation logic if needed

    return null; // No validation error
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
          body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Container(
          child: Stack(
            children: [
              CustomBGWidget(),
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        Container(
                          // color: Colors.yellow,
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 4,
                          ),
                          child: Image.asset(
                            "assets/images/Prism-logo.png",
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                        CustomTextFieldWidget(
                            labelText: "Enter Email / Phone no",
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please Enter Mobile no';
                              }
                              if (value == _mobileNo) {
                                if (value.length < 10) {
                                  return 'Please Enter valid Mobile no';
                                }
                                if (value.length > 10) {
                                  return 'Please Enter valid Mobile no';
                                }
                              }
                              if (value == email) {
                                if (!value.contains("@")) {
                                  return 'Please Enter valid Email';
                                }
                                if (!value.contains(".com")) {
                                  return 'Please Enter valid Email';
                                }
                              }

                              return null;
                            },
                            saved: (value) {
                              loginData = value;
                              // value.contains('@')
                              //     ? email = value
                              //     : _mobileNo = value;
                              // if (value.contains("@")) {
                              //   email = value;
                              // } else {
                              //   _mobileNo = value;
                              // }
                            }),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 80),
                        Container(
                          height: MediaQuery.of(context).size.height / 15,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please Enter Password';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _password = value;
                            },
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgetPassword(
                                            cart: cart,
                                          )));
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        FlatButton(
                          height: 45,
                          minWidth: MediaQuery.of(context).size.width / 2,
                          padding: EdgeInsets.all(10),
                          shape: (RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            //side: BorderSide(color: Colors.red)
                          )),
                          textColor: Colors.white,
                          color: MyColors.themecolor,
                          onPressed: () {
                            onLoginButtonClick();
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
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 80),
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
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't Have An Account ?",
                              style: TextStyle(
                                fontFamily: "Poppins-Medium",
                                color: Colors.grey,
                                fontSize: 15,
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
                                  fontSize: 15,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterScreen(
                                              cart: cart,
                                            )));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  void onLoginButtonClick() async {
    FocusScope.of(context).unfocus();

    String loginemailorph;

    if (email == null) {
      loginemailorph = _mobileNo;
    } else {
      loginemailorph = email;
    }

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('form is valid');

      var isInternetConnected = await InternetUtil.isInternetConnected();

      if (isInternetConnected) {
        // ProgressDialog.showProgressDialog(context);
        try {
          var response = await Login_repo.Login(loginData, _password);
          print(response);
          if (response == null) {
            print("Data is NULL.....1");
          }

          if (response.status == 200) {
            Fluttertoast.showToast(
                msg: "Login Succesfull",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 10,
                backgroundColor: MyColors.themecolor,
                textColor: MyColors.textcolor,
                fontSize: 12.0);

            _goToHomePage(response.data);
          } else {
            Fluttertoast.showToast(
                msg: "Mobile & Password Wrong...",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 10,
                backgroundColor: MyColors.themecolor,
                textColor: MyColors.textcolor,
                fontSize: 12.0);
            Navigator.pop(context);
          }
        } catch (e) {
          print(e);
          setState(() {
            Fluttertoast.showToast(
                msg: "Something Wrong, Please Try Again....!!!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 10,
                backgroundColor: MyColors.themecolor,
                textColor: MyColors.textcolor,
                fontSize: 12.0);
          });
        }
        // if (response.status == 404) {
        //   //TODO show error

        //   if (response.data == null) {
        //     Fluttertoast.showToast(
        //         msg: "You are not register User.Please Register First.",
        //         toastLength: Toast.LENGTH_LONG,
        //         gravity: ToastGravity.CENTER,
        //         timeInSecForIosWeb: 10,
        //         backgroundColor: MyColors.themecolor,
        //         textColor: MyColors.textcolor,
        //         fontSize: 12.0);

        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => RegisterScreen()),
        //     );
        //   } else {}
        // }
      } else {
        Fluttertoast.showToast(
            msg: "No Internet Connection....!!!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 10,
            backgroundColor: MyColors.themecolor,
            textColor: MyColors.textcolor,
            fontSize: 12.0);
      }

      //  Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryList()),);
    } else {
      setState(() {
        // FocusScope.of(context).unfocus();
        _autoValidate = true;
      });
    }
  }

  void _goToHomePage(User_Registration user) {
    SessionManager.saveUserObject(user);
    userDetails = user;
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Homepage(
                    cart: cart,
                    user: userDetails,
                  ))).then((value) {
        userDetails = value;
      });
    });

//    Navigator.pushReplacement(context,
//        MaterialPageRoute(
//            builder: (context) => HomePage(title: 'Habib Store')));
  }
}
