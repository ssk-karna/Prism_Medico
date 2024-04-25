import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prism_medico/Repo/Registeration.dart';
import 'package:prism_medico/Repo/getDistRepo.dart';
import 'package:prism_medico/Repo/getStateRepo.dart';
import 'package:prism_medico/Repo/verify_EmailRepo.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Screens/login.dart';
import 'package:prism_medico/Screens/otp.dart';
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/Widgets/CustomTextFormField.dart';
import 'package:prism_medico/Widgets/Custom_Bakground.dart';
import 'package:prism_medico/model/User.dart';
import 'package:prism_medico/model/districtModel.dart';
import 'package:prism_medico/model/latestProduct.dart';
import 'package:prism_medico/model/order_Model.dart';
import 'package:prism_medico/model/statesModel.dart';
import 'package:prism_medico/utills/Constant.dart';
import 'package:prism_medico/utills/Internet_Connection.dart';
import 'package:prism_medico/utills/Session_Manager.dart';
import 'package:prism_medico/utills/Super_Responce.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  final List<Latest_Product_model> cart;
  RegisterScreen({required this.cart});
  @override
  _RegisterScreenState createState() => _RegisterScreenState(this.cart);
}

class _RegisterScreenState extends State<RegisterScreen> {
  _RegisterScreenState(this.cart);
  List<Latest_Product_model> cart;
  final _focusNode = FocusNode();

  late SharedPreferences sharedPreferences;
  bool _passwordVisible = true;
  bool isButtonDisabled = false;

  late String? _selectedstates = '';
  late String? _selectedDist = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  late String _UserName= '';
  var _emailID;
  late String _mobileNumber= '';
  late String _password= '';
  late String _pharmacyName= '';
  late String _City= '';
  late String _Disct= '';
  late String _address= '';
  late String _state= '';
  late String _pincode= '';
  late String _fullname= '';
  var stateId;
  var distrId;

  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();

  late FocusNode addressNode;
  late FocusNode pincodeNode;
  @override
  void initState() {
    _passwordVisible = false;
    addressNode = FocusNode();
    pincodeNode = FocusNode();
    setState(() {
      stateId;
      isButtonDisabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      //appBar: AppBar(elevation: 0, backgroundColor: Colors.lightBlue.shade100),
      body: SingleChildScrollView(
        child: Container(
            // height: MediaQuery.of(context).size.height,
            child: Stack(
          children: [
            CustomBGWidget(),
            Form(
              // autovalidate: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Container(
                // height: MediaQuery.of(context).size.height,
                //  color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 12,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontFamily: "Poppins-SemiBold",
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Create your new account",
                          style: TextStyle(
                            fontFamily: "Poppins-Regular",
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 5,
                      ),
                      SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 50),
                          child: Column(
                            children: [
                              CustomTextFieldWidget(
                                labelText: "Name",
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Name';
                                  }
                                  return null;
                                },
                                saved: (val) {
                                  _UserName = val;
                                },
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 80),
                              CustomTextFieldWidget(
                                labelText: "Pharmacy Name",
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Pharmacy Name';
                                  }
                                  return null;
                                },
                                saved: (val) {
                                  _pharmacyName = val;
                                },
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 80),
                              CustomTextFieldWidget(
                                labelText: "Address",
                                focusNode: addressNode,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Address';
                                  }
                                  return null;
                                },
                                saved: (val) {
                                  _address = val;
                                },
                                action: TextInputAction.next,
                                change: (value) {
                                  if (value.length == 10) {
                                    addressNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(pincodeNode);
                                  }
                                },
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 80),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 15,
                                    width:
                                        MediaQuery.of(context).size.width / 2.2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.grey)),
                                    child: FutureBuilder<
                                        SuperResponse<
                                            List<State_Model>>?>(
                                        future: GetStateListRepo.getStateList(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<
                                                    SuperResponse<
                                                        List<State_Model>>?>
                                                snap) {
                                          if (snap.hasData) {
                                            var list = snap.data!.data;

                                            return DropdownButton(
                                              hint: Container(
                                                margin: EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: Text(
                                                  "State",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontFamily:
                                                          "Poppins-Regular"),
                                                ),
                                              ),
                                              value: _selectedstates == ""
                                                  ? ""
                                                  : _selectedstates,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  if (newValue != null) {
                                                    _selectedstates = newValue.toString(); // Explicitly convert to String
                                                  } else {
                                                    _selectedstates = null; // Handle null case
                                                  }

                                                  _selectedDist = null;
                                                  //  stateId = newValue.id;
                                                });
                                              },
                                              underline: SizedBox.shrink(),
                                              items: list.map((State) {
                                                return DropdownMenuItem(
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.6,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: new Text(
                                                            State.state_name,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins-Regular",
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12)),
                                                      ),
                                                    ),
                                                    value: State.id);
                                              }).toList(),
                                            );
                                          }
                                          if (snap.hasError) {
                                            return Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    15,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.2,
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: ListTile(
                                                      trailing: Icon(Icons
                                                          .arrow_drop_down),
                                                      title: Text("State",
                                                          softWrap: true,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Poppins-Regular",
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12)),
                                                    )));
                                          } else {
                                            return Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    15,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.2,
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: ListTile(
                                                      trailing: Icon(Icons
                                                          .arrow_drop_down),
                                                      title: Text("State",
                                                          softWrap: true,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Poppins-Regular",
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12)),
                                                    )));
                                          }
                                        }),
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 15,
                                    width:
                                        MediaQuery.of(context).size.width / 2.2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.grey)),
                                    child: FutureBuilder<
                                        SuperResponse<
                                            List<District_Model>>?>(
                                        future: GetDistListRepo.getDistList(
                                            _selectedstates!),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<
                                                    SuperResponse<
                                                        List<District_Model>>?>
                                                snap) {
                                          if (snap.hasData) {
                                            var list = snap.data!.data;
                                            return DropdownButton(
                                              underline: SizedBox.shrink(),
                                              hint: Container(
                                                margin: EdgeInsets.only(
                                                    left: 10, right: 5),
                                                child: Text(
                                                  "District",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontFamily:
                                                          "Poppins-Regular"),
                                                ),
                                              ),
                                              isExpanded: true,
                                              value: _selectedDist == ''
                                                  ? 'Disc'
                                                  : _selectedDist,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  if (newValue != null) {
                                                    _selectedDist = newValue.toString(); // Explicitly convert to String
                                                  } else {
                                                    _selectedDist = null; // Handle null case
                                                  }
                                                });
                                              },
                                              items: list.map((Disct) {
                                                return DropdownMenuItem(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(Disct.dist_name,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Poppins-Regular",
                                                            color: Colors.black,
                                                            fontSize: 12)),
                                                  ),
                                                  value: Disct.id,
                                                );
                                              }).toList(),
                                            );
                                          }
                                          if (snap.hasError) {
                                            return Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    15,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.2,
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: ListTile(
                                                      trailing: Icon(Icons
                                                          .arrow_drop_down),
                                                      title: Text("District",
                                                          softWrap: true,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Poppins-Regular",
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12)),
                                                    )));
                                          } else {
                                            return Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    15,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.2,
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: ListTile(
                                                      trailing: Icon(Icons
                                                          .arrow_drop_down),
                                                      title: Text("District",
                                                          softWrap: true,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Poppins-Regular",
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12)),
                                                    )));
                                          }
                                        }),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 80),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.2,
                                    child: CustomTextFieldWidget(
                                      labelText: "Pincode",
                                      controller: pincode,
                                      focusNode: pincodeNode,
                                      maxline: 6,
                                      counter: "",
                                      keboardtype: TextInputType.number,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter Pincode';
                                        }
                                        if (value.length < 6) {
                                          return 'Please Enter valid Pincode';
                                        }
                                        if (value.length > 6) {
                                          return 'Please Enter valid Pincode';
                                        }
                                        return null;
                                      },
                                      saved: (val) {
                                        _pincode = val;
                                      },
                                    ),
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 15,
                                    width:
                                        MediaQuery.of(context).size.width / 2.2,
                                    // decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(10),
                                    //     border: Border.all(color: Colors.grey)),
                                    child: CustomTextFieldWidget(
                                      labelText: "City",
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter City';
                                        }
                                        return null;
                                      },
                                      saved: (val) {
                                        _City = val;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 80),
                              CustomTextFieldWidget(
                                labelText: "Email ",
                                validator: (String? value) {
                                  if (value!.isEmpty) {
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
                                saved: (val) {
                                  _emailID = val;
                                },
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 80),
                              CustomTextFieldWidget(
                                labelText: "Phone ",
                                maxline: 10,
                                counter: "",
                                keboardtype: TextInputType.number,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Mobile no.';
                                  }
                                  if (value.length < 10) {
                                    return 'Please Enter Valid Mobile No.';
                                  }
                                  if (value.length > 10) {
                                    return 'Please Enter Valid Mobile No.';
                                  }
                                  return null;
                                },
                                saved: (val) {
                                  _mobileNumber = val;
                                },
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 80),
                              Container(
                                height: MediaQuery.of(context).size.height / 15,
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Password';
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {
                                    _password = val!;
                                  },
                                  obscureText:
                                      !_passwordVisible, //This will obscure text dynamically
                                  decoration: InputDecoration(
                                    labelText: 'Enter Password',
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
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
                                        Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              SizedBox(
                                height: 50,
                                child: TextButton(
                                  //height: 50,
                                  // padding: EdgeInsets.all(10),
                                  // shape: (RoundedRectangleBorder(
                                  //   borderRadius: BorderRadius.circular(15),
                                  //   //side: BorderSide(color: Colors.red)
                                  // )),
                                  // textColor: Colors.white,
                                  // color: MyColors.themecolor,
                                  style : ButtonStyle(
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
                                  onPressed: !isButtonDisabled ? () {
                                    onButtonClick();
                                    setState(() {
                                      // istapped = 'Button tapped';
                                    });
                                  } : null,
                                  child: Center(
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Semibold",
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 55,
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                width: MediaQuery.of(context).size.width / 1,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "By Signing up, you're agree to our",
                                          style: TextStyle(
                                            fontFamily: "Poppins-Medium",
                                            fontSize: 11,
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
                                              fontSize: 11,
                                            ),
                                          ),
                                          onTap: () {},
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          Text(
                                            "and",
                                            style: TextStyle(
                                              fontFamily: "Poppins-Medium",
                                              fontSize: 11,
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
                                                fontSize: 11,
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
                                height: MediaQuery.of(context).size.height / 70,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already Have An Account ?",
                                    style: TextStyle(
                                      fontFamily: "Poppins-Medium",
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 15,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => LoginScreen(
                                                    cart: cart,
                                                  )));
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //child: Image.asset("assets/Images/E1.png"),
              ),
            ),
          ],
        )),
      ),
    );
  }

  void onButtonClick() async {
    FocusScope.of(context).unfocus();
    String registration;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('form is valid');
      userDetails.name = _UserName;
      userDetails.email = _emailID;
      userDetails.password = _password;
      userDetails.phone = _mobileNumber;
      userDetails.address = _address;
      userDetails.city = _City;
      userDetails.state = _selectedstates;

      userDetails.district = _selectedDist;
      userDetails.pharmacyname = _pharmacyName;
      userDetails.pincode = _pincode;
      userDetails.fullname = "abc";

      var isInternetConnected = await InternetUtil.isInternetConnected();

      if (isInternetConnected) {
        // ProgressDialog.showProgressDialog(context);
        try {
          setState(() {
            isButtonDisabled = true;
          });
          var response = await VerifyEmail_repo.verifyEmail(
              _emailID, _UserName, _mobileNumber);
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
            setState(() {
              isButtonDisabled = false;
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => otpVerify(
                          cart: cart,
                          email: _emailID,
                          user: userDetails,
                          isCommingFromregistration: true,
                        )));
          } else {
            // Fluttertoast.showToast(
            //     msg: "Something Wrong...",
            //     toastLength: Toast.LENGTH_LONG,
            //     gravity: ToastGravity.CENTER,
            //     timeInSecForIosWeb: 10,
            //     backgroundColor: MyColors.themecolor,
            //     textColor: MyColors.textcolor,
            //     fontSize: 12.0);
            isButtonDisabled = false;

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
            isButtonDisabled = false;

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
        setState(() {
          isButtonDisabled = false;

        });

      }

      //  Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryList()),);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  // RegisterButtonClick() async {
  //   if (_formKey.currentState.validate()) {
  //     _formKey.currentState.save();
  //     print('form is valid');
  //     userDetails.name = _UserName;
  //     userDetails.email = _emailID;
  //     userDetails.password = _password;
  //     userDetails.phone = _mobileNumber;
  //     userDetails.address = _address;
  //     userDetails.city = _City;
  //     userDetails.state = _selectedstates;
  //     userDetails.district = _selectedDist;
  //     userDetails.pharmacyname = _pharmacyName;
  //     userDetails.pincode = _pincode;
  //     userDetails.fullname = "abc";
  //     var isInternetConnected = await InternetUtil.isInternetConnected();

  //     if (isInternetConnected) {
  //       var response = await RegistrationRepo.registeUserr(
  //         _UserName,
  //         "abc",
  //         _pharmacyName,
  //         _address,
  //         _City,
  //         _selectedDist,
  //         _pincode,
  //         _selectedstates,
  //         _mobileNumber,
  //         _emailID,
  //         _password,
  //       );

  //       if (response.status == 201) {
  //         Fluttertoast.showToast(
  //             msg: "Registeration Succesfull",
  //             toastLength: Toast.LENGTH_LONG,
  //             gravity: ToastGravity.CENTER,
  //             timeInSecForIosWeb: 10,
  //             backgroundColor: MyColors.themecolor,
  //             textColor: MyColors.textcolor,
  //             fontSize: 12.0);

  //         _goToHomePage(response.data);
  //       } else {
  //         Fluttertoast.showToast(
  //             msg: "Something wronge...",
  //             toastLength: Toast.LENGTH_LONG,
  //             gravity: ToastGravity.CENTER,
  //             timeInSecForIosWeb: 10,
  //             backgroundColor: MyColors.themecolor,
  //             textColor: MyColors.textcolor,
  //             fontSize: 12.0);
  //       }
  //     }
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: "No Internet Connection....!!!",
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 10,
  //         backgroundColor: MyColors.themecolor,
  //         textColor: MyColors.textcolor,
  //         fontSize: 12.0);
  //   }
  // }

  // void _goToHomePage(User_Registration user) {
  //   SessionManager.saveUserObject(user);
  //   userDetails = user;

  //   Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => Homepage(
  //                 user: user,
  //                 cart: cart,
  //               )));
  // }
}

class StateItem {
  var id;
  var value;

  StateItem({this.id, this.value});
}
