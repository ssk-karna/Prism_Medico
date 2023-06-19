import 'package:flutter/material.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/Widgets/Custom_AlertDialog.dart';
import 'package:prism_medico/Widgets/Custom_Bakground.dart';

class ResetPassword extends StatefulWidget {
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _newpasswordVisible = false;
  bool _cinformpasswordVisible = false;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confiPass = TextEditingController();

  @override
  void initState() {
    _newpasswordVisible = false;
    _cinformpasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _form,
        child: Container(
          child: Stack(
            children: [
              CustomBGWidget(),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3),
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
                            fontFamily: "Poppins-Normal",
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
                            if (val.isEmpty) return 'Empty';
                            return null;
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
                            // if (val.isEmpty) return '';
                            // if (val != _pass.text) return 'Not Match';
                            // return null;
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
                        //_form.currentState.validate();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Homepage()));

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
    _form.currentState.validate();
  }
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    // height: ,
    minWidth: MediaQuery.of(context).size.width / 5,
    padding: EdgeInsets.all(10),
    shape: (RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
      //side: BorderSide(color: Colors.red)
    )),
    textColor: Colors.white,
    color: Colors.blue.shade200,
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
