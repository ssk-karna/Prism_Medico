import 'package:flutter/material.dart';
import 'package:prism_medico/Screens/login.dart';
import 'package:prism_medico/Screens/otp.dart';
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/Widgets/CustomTextFormField.dart';
import 'package:prism_medico/Widgets/Custom_Bakground.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _passwordVisible = true;
  List<String> _city = ['Pune', 'Bangluru', 'ahmedabad', 'Mumbai']; // Option 2
  String _selectedcity;
  List<String> _disct = [
    'Pune',
    'Mumbai',
  ]; // Option 2
  String _selectedDist;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(elevation: 0, backgroundColor: Colors.lightBlue.shade100),
      body: SingleChildScrollView(
        child: Container(
            // height: MediaQuery.of(context).size.height,
            child: Stack(
          children: [
            CustomBGWidget(),
            Form(
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
                        height: MediaQuery.of(context).size.height / 8,
                      ),
                      SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 50),
                          child: Column(
                            children: [
                              CustomTextFieldWidget(
                                labelText: "Name",
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 80),
                              CustomTextFieldWidget(
                                labelText: "Pharmacy Name",
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 80),
                              CustomTextFieldWidget(
                                labelText: "Address",
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
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.2,
                                    child: CustomTextFieldWidget(
                                      labelText: "State",
                                    ),
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
                                    height:
                                        MediaQuery.of(context).size.height / 15,
                                    width:
                                        MediaQuery.of(context).size.width / 2.2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.grey)),
                                    child: DropdownButton(
                                      hint: Center(
                                        child: Text(
                                          "City",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                              fontFamily: "Poppins-Regular"),
                                        ),
                                      ),
                                      value: _selectedcity,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedcity = newValue;
                                        });
                                      },
                                      items: _city.map((location) {
                                        return DropdownMenuItem(
                                          child: new Text(location),
                                          value: location,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 15,
                                    width:
                                        MediaQuery.of(context).size.width / 2.2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.grey)),
                                    child: DropdownButton(
                                      hint: Text(
                                        "Disctrict",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontFamily: "Poppins-Regular"),
                                      ),
                                      value: _selectedDist,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedDist = newValue;
                                        });
                                      },
                                      items: _disct.map((location) {
                                        return DropdownMenuItem(
                                          child: new Text(location),
                                          value: location,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 80),
                              CustomTextFieldWidget(
                                labelText: "Email ",
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 80),
                              CustomTextFieldWidget(
                                labelText: "Phone ",
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 80),
                              Container(
                                height: MediaQuery.of(context).size.height / 15,
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  // controller: _userPasswordController,
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
                              FlatButton(
                                height: 50,
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
                                          builder: (context) => otpVerify()));
                                  setState(() {
                                    // istapped = 'Button tapped';
                                  });
                                },
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
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
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
}
