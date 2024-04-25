import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prism_medico/Repo/newPasswordRepo.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Screens/login.dart';
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/model/latestProduct.dart';
import 'package:prism_medico/Widgets/Custom_Bakground.dart';
import 'package:prism_medico/utills/Internet_Connection.dart';

class ResetPassword extends StatefulWidget {
  List<Latest_Product_model> cart;
  final email;
  ResetPassword({required this.cart, this.email});
  _ResetPasswordState createState() => _ResetPasswordState(this.cart);
}

class _ResetPasswordState extends State<ResetPassword> {
  _ResetPasswordState(this.cart);
  List<Latest_Product_model> cart;
  bool _newpasswordVisible = false;
  bool _cinformpasswordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confiPass = TextEditingController();
  late String newPass;
  late String confirmPass;
  bool _autoValidate = false;

  @override
  void initState() {
    _newpasswordVisible = false;
    _cinformpasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
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
                    Center(
                      child: Text(
                        "Reset your Password",
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
                        "Create your new password to login",
                        style: TextStyle(
                            fontFamily: "Poppins-Regular",
                            fontSize: 14,
                            color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 17,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 5),
                            blurRadius: 10.0,
                            color: Colors.grey.withOpacity(0.8),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: TextFormField(
                          controller: _pass,
                          validator: (val) {
                            if (val!.isEmpty) return 'Enter Password..';
                            return null;
                          },
                          onSaved: (val) {
                            newPass = val!;
                          },
                          keyboardType: TextInputType.text,
                          // controller: _userPasswordController,
                          obscureText:
                              !_newpasswordVisible, //This will obscure text dynamically
                          decoration: InputDecoration(
                              labelText: 'Create New Password',

                              // Here is key idea
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _newpasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _newpasswordVisible = !_newpasswordVisible;
                                  });
                                },
                              ),
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
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 17,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 5),
                            blurRadius: 10.0,
                            color: Colors.grey.withOpacity(0.6),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: TextFormField(
                          controller: _confiPass,
                          validator: (val) {
                            if (val!.isEmpty) return 'Enter confirm Password..';
                            if (val != _pass.text) return 'Not Match';
                            return null;
                          },
                          onSaved: (val) {
                            confirmPass = val!;
                          },
                          keyboardType: TextInputType.text,
                          // controller: _userPasswordController,
                          obscureText:
                              !_cinformpasswordVisible, //This will obscure text dynamically
                          decoration: InputDecoration(
                              labelText: 'Confirm New Password',

                              // Here is key idea
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _cinformpasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _cinformpasswordVisible =
                                        !_cinformpasswordVisible;
                                  });
                                },
                              ),
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
                        //_form.currentState.validate();
                        onButtonClick();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Homepage(
                        //               cart: cart,
                        //             )));

                        /* if (_pass == _confiPass) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Homepage()));
                        } else {
                          //showAlertDialog(context);
                        }*/
                      },
                      child: Text(
                        'Submit',
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
    if(_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        print('form is valid');

        var isInternetConnected = await InternetUtil.isInternetConnected();

        if (isInternetConnected) {
          // ProgressDialog.showProgressDialog(context);
          try {
            var response = await ResetPass_repo.resetPass(
                widget.email, newPass, confirmPass);
            print(response!.data);

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
              Future.delayed(Duration(seconds: 1), () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LoginScreen(
                              cart: cart,
                            )));
              });
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
    else{
      // _formkey is null
    }
  }
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    // height: ,
    // minWidth: MediaQuery.of(context).size.width / 5,
    // padding: EdgeInsets.all(10),
    // shape: (RoundedRectangleBorder(
    //   borderRadius: BorderRadius.circular(15),
    //   //side: BorderSide(color: Colors.red)
    // )),
    // textColor: Colors.white,
    // color: Colors.blue.shade200,
    style : ButtonStyle(
        minimumSize:  MaterialStateProperty.all<Size>(
          Size(MediaQuery.of(context).size.width / 5, 0),
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
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade200)
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
    child: Text(
      'OKEY',
      style: TextStyle(
        color: Colors.white,
        fontFamily: "Poppins-Semibold",
        fontSize: 14,
      ),
    ),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: Text(
      "Your Password Not Match",
      style: TextStyle(
        fontFamily: "Poppins-semibold",
        fontSize: 14,
      ),
    ),
    actions: [
      Center(child: cancelButton),
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
