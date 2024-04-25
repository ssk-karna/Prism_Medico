import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prism_medico/Repo/Registeration.dart';
import 'package:prism_medico/Repo/verfy_otpRepo.dart';
import 'package:prism_medico/Repo/verify_EmailRepo.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Screens/reset_Password.dart';
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/model/User.dart';
import 'package:prism_medico/model/latestProduct.dart';
import 'package:prism_medico/Widgets/Custom_Bakground.dart';
import 'package:prism_medico/Widgets/Custom_TextField_Shade.dart';
import 'package:prism_medico/utills/Constant.dart';
import 'package:prism_medico/utills/Internet_Connection.dart';
import 'package:prism_medico/utills/Session_Manager.dart';
import 'package:prism_medico/Repo/forget_PassRepo.dart';
import 'package:prism_medico/utills/Progress_Dialog.dart';

import 'login.dart';

class otpVerify extends StatefulWidget {
  List<Latest_Product_model> cart;
  final User_Registration? user;
  final email;
  bool isCommingFromregistration;
  otpVerify({required this.cart, this.email, this.user, required this.isCommingFromregistration});
  @override
  _otpVerifyState createState() => _otpVerifyState(this.cart);
}

class _otpVerifyState extends State<otpVerify> {
  _otpVerifyState(this.cart);
  List<Latest_Product_model> cart;
  late String otptext;
  late String registration;
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  void _refreshPage() {
    setState(() {
      // message = 'Message refreshed at ${DateTime.now()}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20),
        child: Text(
          "NOTE :- Please check your E-mail Inbox / Spam folder for OTP.!!!",
          style: TextStyle(
              fontFamily: "Poppins-semibold",
              fontSize: 12,
              color: Colors.black),
        ),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Container(
          child: Stack(
            children: [
              CustomBGWidget(),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3.5),
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Verify E-mail",
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
                        "Enter the OTP sent to on",
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
                          '${widget.email}',
                          style: TextStyle(
                              fontFamily: "Poppins-Regular",
                              fontSize: 14,
                              color: Colors.grey),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Change",
                            style: TextStyle(
                                fontFamily: "Poppins-Semibold",
                                fontSize: 14,
                                color: MyColors.themecolor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    CustomTextFieldShade(
                      height: MediaQuery.of(context).size.height / 12,
                      width: MediaQuery.of(context).size.width,
                      labelText: "Enter OTP",
                      keboardtype: TextInputType.number,
                      maxline: 6,
                      counter: "",
                      saved: (val) {
                        otptext = val;
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please Enter OTP.';
                        }
                        if (val.length < 6) {
                          return 'Please Enter Valid OTP.';
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 3.5),
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
                          InkWell(
                            onTap: () {
                              onResendBtnClick();
                              setState(() {
                                _refreshPage();
                              });
                            },
                            child: Text(
                              "Resend OTP",
                              style: TextStyle(
                                  fontFamily: "Poppins-Semibold",
                                  fontSize: 12,
                                  color: MyColors.themecolor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),

                    TextButton(
                      // height: ,
                      // minWidth: MediaQuery.of(context).size.width / 3,
                      // padding: EdgeInsets.all(10),
                      // shape: (RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(15),
                      //   //side: BorderSide(color: Colors.red)
                      // )),
                      // textColor: Colors.white,
                      // color: MyColors.themecolor,
                      style : ButtonStyle(
                          minimumSize:  MaterialStateProperty.all<Size>(
                            Size(MediaQuery.of(context).size.width / 3, 0),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.all(10),
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              // Adjust side if needed
                              // side: BorderSide(color: Colors.red),
                            ),
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(MyColors.themecolor)
                      ),
                      onPressed: () {
                        onButtonClick();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             ResetPassword(cart: cart)));
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
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onButtonClick() async {
    FocusScope.of(context).unfocus();
    if(_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        print('form is valid');

        var isInternetConnected = await InternetUtil.isInternetConnected();

        if (isInternetConnected) {
          ProgressDialog().showProgressDialog(context);
          try {
            var response = await VerifyOTP_repo.verifyotp(
                widget.email, otptext);
            print(response!.data);

            if (response.status == 200) {
              Fluttertoast.showToast(
                  msg: "OTP Verification Succesfull..!!!",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 10,
                  backgroundColor: MyColors.themecolor,
                  textColor: MyColors.textcolor,
                  fontSize: 12.0);

              if (widget.isCommingFromregistration == true) {
                onRegisterButtonClick();
              } else {
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ResetPassword(
                                cart: cart,
                                email: widget.email,
                              )));
                });
              }
            } else {
              Fluttertoast.showToast(
                  msg: "Wrong OTP...",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 10,
                  backgroundColor: MyColors.themecolor,
                  textColor: MyColors.textcolor,
                  fontSize: 12.0);
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
      }
      else {
        setState(() {
          _autoValidate = true;
        });
      }
    }
    else
      {
        // _formkey isn null
      }
  }

  void onRegisterButtonClick() async {

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('form is valid');
      // userDetails.name = widget.user.name;
      // userDetails.email = widget.user.email;
      // userDetails.password = _password;
      // userDetails.phone = _mobileNumber;
      // userDetails.address = _address;
      // userDetails.city = _City;
      // userDetails.state = _selectedstates;
      // userDetails.district = _selectedDist;
      // userDetails.pharmacyname = _pharmacyName;
      // userDetails.pincode = _pincode;
      // userDetails.fullname = "abc";
      var isInternetConnected = await InternetUtil.isInternetConnected();

      if (isInternetConnected && widget.user != null) {
        ProgressDialog().showProgressDialog(context);
        var response = await RegistrationRepo.registeUserr(
          widget.user!.name,
          "abc",
          widget.user!.pharmacyname,
          widget.user!.address,
          widget.user!.city,
          widget.user!.district,
          widget.user!.pincode,
          widget.user!.state,
          widget.user!.phone,
          widget.user!.email,
          widget.user!.password,
        );

        if (response.status == 201) {
          Fluttertoast.showToast(
              msg: "Registeration Succesfull",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 10,
              backgroundColor: MyColors.themecolor,
              textColor: MyColors.textcolor,
              fontSize: 12.0);

          _goToHomePage(response.data);
        } else {
          Fluttertoast.showToast(
              msg: "Something wrong...",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 10,
              backgroundColor: MyColors.themecolor,
              textColor: MyColors.textcolor,
              fontSize: 12.0);
        }
      }


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
  }

  void _goToHomePage(User_Registration user) {
    SessionManager.saveUserObject(user);
    // userDetails = user;
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                cart: cart,
              )));
    });
  }

  void onResendBtnClick() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('form is valid');

      var isInternetConnected = await InternetUtil.isInternetConnected();

      if (isInternetConnected) {
        ProgressDialog().showProgressDialog(context);
        try {
          var response = null;

          if(widget.isCommingFromregistration){
            response = await VerifyEmail_repo.verifyEmail(
                widget.email, userDetails.name, userDetails.phone);
          }
          else {
            response = await ForgetPass_repo.forgetPass(widget.email);
            print(response.data);
          }

          if (response.status == 201) {
            // Fluttertoast.showToast(
            //     msg: "Login Succesfull",
            //     toastLength: Toast.LENGTH_LONG,
            //     gravity: ToastGravity.CENTER,
            //     timeInSecForIosWeb: 10,
            //     backgroundColor: MyColors.themecolor,
            //     textColor: MyColors.textcolor,
            //     fontSize: 12.0);
            print("1234546");
            print(response.data);
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => otpVerify(
            //               cart: cart,
            //               email: _emailID,
            //               isCommingFromregistration: false,
            //             )));
          } else {
            Fluttertoast.showToast(
                msg: "Wrong Email...",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 10,
                backgroundColor: MyColors.themecolor,
                textColor: MyColors.textcolor,
                fontSize: 12.0);
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
        setState(() {
          ProgressDialog().hideProgressDialog(context);
        });
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
        _autoValidate = true;
      });
    }
  }
}
