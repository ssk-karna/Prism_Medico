import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prism_medico/Repo/forget_PassRepo.dart';
import 'package:prism_medico/Screens/otp.dart';
import 'package:prism_medico/model/latestProduct.dart';
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/Widgets/Custom_Bakground.dart';
import 'package:prism_medico/utills/Internet_Connection.dart';
import 'package:prism_medico/utills/Progress_Dialog.dart';

class ForgetPassword extends StatefulWidget {
  List<Latest_Product_model> cart;

  ForgetPassword({this.cart});
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState(this.cart);
}

class _ForgetPasswordState extends State<ForgetPassword> {
  _ForgetPasswordState(this.cart);
  List<Latest_Product_model> cart;
  String _emailID;
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        "We will send a one time Email.",
                        style: TextStyle(
                            fontFamily: "Poppins-Normal",
                            fontSize: 14,
                            color: Colors.grey),
                      ),
                    ),
                    //SizedBox(height: MediaQuery.of(context).size.height / 10),
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: Text(
                    //     "Carrier rates may apply.",
                    //     style: TextStyle(
                    //         fontFamily: "Poppins-Normal",
                    //         fontSize: 14,
                    //         color: Colors.grey),
                    //   ),
                    // ),
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
                          controller: email,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter Email.';
                            }
                            if (!value.contains("@")) {
                              return 'Please Enter Valid Email.';
                            }
                            if (!value.contains(".com")) {
                              return 'Please Enter Valid Email.';
                            }

                            return null;
                          },
                          onSaved: (val) {
                            _emailID = val;
                          },
                          decoration: InputDecoration(
                              labelText: 'Enter your E-mail',
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
                        onButtonClick();
                        setState(() {
                          _autoValidate = true;
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
      ),
    );
  }

  void onButtonClick() async {
    FocusScope.of(context).unfocus();
    String forgetpassword;
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('form is valid');

      var isInternetConnected = await InternetUtil.isInternetConnected();

      if (isInternetConnected) {
        //ProgressDialog.showProgressDialog(context);
        try {
          var response = await ForgetPass_repo.forgetPass(_emailID);
          print(response.data);

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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => otpVerify(
                          cart: cart,
                          email: _emailID,
                          isCommingFromregistration: false,
                        )));
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
