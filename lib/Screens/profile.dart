import 'package:flutter/material.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/Widgets/CustomTextFormField.dart';
import 'package:prism_medico/Widgets/Custom_Bakground.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  _Profilestate createState() => _Profilestate();
}

class _Profilestate extends State<Profile> {
  bool _passwordVisible = true;

  File imageFile;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Row(
          children: [
            Text(
              "Edit Profile",
              style: TextStyle(
                  fontFamily: "Poppins-Semibold",
                  fontSize: 20,
                  color: MyColors.textcolor),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            CustomBGWidget(),
            Form(
                child: Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 11),
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      maxRadius: 90,
                      minRadius: 90,
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/profile.png",
                            height: 500,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                                onPressed: () {
                                  showAlertDialog(context);
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 80),
                  CustomTextFieldWidget(
                    labelText: "Name",
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 80),
                  CustomTextFieldWidget(
                    labelText: "Pharmacy Name",
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 80),
                  CustomTextFieldWidget(
                    labelText: "Address",
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: CustomTextFieldWidget(
                          labelText: "City",
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: CustomTextFieldWidget(
                          labelText: "District",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: CustomTextFieldWidget(
                          labelText: "Pincode",
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: CustomTextFieldWidget(
                          labelText: "State",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 80),
                  CustomTextFieldWidget(
                    labelText: "Email ",
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 80),
                  CustomTextFieldWidget(
                    labelText: "Phone ",
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
                        labelText: 'Password',
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
                    height: 55,
                    padding: EdgeInsets.all(10),
                    shape: (RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      //side: BorderSide(color: Colors.red)
                    )),
                    textColor: Colors.white,
                    color: MyColors.themecolor,
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Homepage()));
                      setState(() {
                        // istapped = 'Button tapped';
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Text(
                        'Save Changes',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins-Semibold",
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
    }
  }

  getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
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
        'Cancel',
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Poppins-Semibold",
          fontSize: 14,
        ),
      ),
    );

    Widget okButton = FlatButton(
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
      title: Center(
        child: Text(
          "Image Choose From",
          style: TextStyle(
            fontFamily: "Poppins-semibold",
            fontSize: 16,
          ),
        ),
      ),
      content: Container(
          height: 80,
          child: imageFile == null
              ? Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              getFromGallery();
                            },
                            icon: Icon(
                              Icons.photo,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "Gallary",
                            style: TextStyle(
                                fontFamily: "Poppins-semibold",
                                fontSize: 12,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              getFromCamera();
                            },
                            icon: Icon(
                              Icons.camera,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "Camera",
                            style: TextStyle(
                                fontFamily: "Poppins-semibold",
                                fontSize: 12,
                                color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : Container(
                  child: Image.file(
                    imageFile,
                    fit: BoxFit.cover,
                  ),
                )),
      actions: [
        Container(
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              okButton,
              cancelButton,
            ],
          ),
        ),
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
}
