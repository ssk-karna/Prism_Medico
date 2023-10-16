import 'dart:typed_data';
import 'package:prism_medico/utills/Progress_Dialog.dart';
import 'package:flutter/material.dart';
import 'package:prism_medico/Repo/getUserbyId.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/Widgets/CustomTextFormField.dart';
import 'package:prism_medico/Widgets/Custom_Bakground.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prism_medico/Repo/updateUser.dart';
import 'package:prism_medico/model/User.dart';
import 'package:prism_medico/model/latestProduct.dart';
import 'package:prism_medico/utills/Super_Responce.dart';
import 'package:prism_medico/utills/Constant.dart';
import 'package:prism_medico/utills/Session_Manager.dart';
import 'dart:io' as Io;
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'package:prism_medico/model/statesModel.dart';
import 'package:prism_medico/model/districtModel.dart';
import 'package:prism_medico/Repo/getDistRepo.dart';
import 'package:prism_medico/Repo/getStateRepo.dart';
import 'package:prism_medico/utills/Internet_Connection.dart';

class Profile extends StatefulWidget {
  final List<Latest_Product_model> cart;
  Profile({this.cart});
  _Profilestate createState() => _Profilestate(this.cart);
}

class _Profilestate extends State<Profile> {
  _Profilestate(this.cart);
  List<Latest_Product_model> cart;
  User_Registration user;
  final _imagePicker = ImagePicker();
  bool _passwordVisible = true;
  final _formKey = GlobalKey<FormState>();
  File imageFile;
  String _UserName;
  var _emailID;
  var _mobileNumber;
  var _password;
  var _pharmacyName;
  var _City;
  var _Disct;
  var _address;
  var _state;
  var _pincode;
  var _fullname;
  var _pickedFile;
  var statename;
  var discName;
  File _imageFilePicked;
  String _imageFilePicked1;
  String imageName;
  String img64;
  String image64;
  Uint8List profileImage_Name;
  Image image;
  String stateId;

  TextEditingController _name = TextEditingController();
  TextEditingController _pharmacy = TextEditingController();
  TextEditingController _add = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _sta = TextEditingController();
  TextEditingController _pin = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _disc = TextEditingController();

  @override
  void initState() {
    super.initState();

    GetbyUserID.getByuserId(userDetails.id).then((value) {
      setState(() {
        userDetails = value.data;
      });
    });

    _passwordVisible = false;

    // SessionManager.getUser().then((value) {
    //   setState(() {
    //     userDetails = value;
    //   });
    // });
    _name = new TextEditingController(text: userDetails.name);
    _pharmacy = new TextEditingController(text: userDetails.pharmacyname);
    _add = new TextEditingController(text: userDetails.address);
    _city = new TextEditingController(text: userDetails.city);
    _sta = new TextEditingController(text: userDetails.state);
    _pin = new TextEditingController(text: userDetails.pincode);
    _mobile = new TextEditingController(text: userDetails.phone);
    _email = new TextEditingController(text: userDetails.email);
    _disc = new TextEditingController(text: userDetails.district);
  }

  Future<void> requestPermission() async {
    PermissionStatus status = await Permission.photos.request();

    if (status.isGranted) {
      // Permission granted, proceed to pick image
      await getFromGallery();
    } else {
      // Permission denied
      print("not granted");
    }
  }

  _pickImage({
    @required ImageSource imageSource,
  }) async {
    try {
      var _pickedFile = await _imagePicker.getImage(source: imageSource);

      // _imageFilePicked = _pickedFile.path == null
      //     ? Text("No Image select")
      //     : File(_pickedFile.path);
      if (_pickedFile != null) {
        _imageFilePicked = File(_pickedFile.path);
        print(_imageFilePicked);
        final bytes = Io.File(_imageFilePicked.path).readAsBytesSync();
        img64 = base64Encode(bytes);
        profileImage_Name = base64.decode(img64);
        print(img64);
        image = Image.memory(profileImage_Name);
        Fluttertoast.showToast(
            msg: "Image Selected..",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 10,
            backgroundColor: MyColors.themecolor,
            textColor: MyColors.textcolor,
            fontSize: 12.0);
      } else {
        Fluttertoast.showToast(
            msg: "No Image Selected..",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 10,
            backgroundColor: MyColors.themecolor,
            textColor: MyColors.textcolor,
            fontSize: 12.0);
      }
      setState(() {});
      Navigator.pop(context);
    } catch (e) {
      setState(() {});
      Fluttertoast.showToast(
          msg: "Permission Denied...Please Try Again...",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 10,
          backgroundColor: MyColors.themecolor,
          textColor: MyColors.textcolor,
          fontSize: 12.0);
      Navigator.pop(context);
    }
  }

  Future<void> _getImageFromGallery() async {
    PermissionStatus status = await Permission.storage.status;

    if (status.isGranted) {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _pickedFile = pickedFile;
        // Handle the picked file
        // For example, display the image or upload it to a server
      } else {
        print('No image selected.');
      }
    } else {
      // Request permission if not granted
      await Permission.storage.request();
      print("no permission");
    }
  }

  @override
  Widget build(BuildContext context) {
    // _imageFilePicked = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: MyColors.themecolor,
        elevation: 0.0,
        title: Row(
          children: [
            Text(
              "Edit Profile",
              style: TextStyle(
                  fontFamily: "Poppins-Semibold",
                  fontSize: 20,
                  color: Colors.white),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            CustomBGWidget(),
            Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Container(
                  //  margin: EdgeInsets.only(top: ),
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      userDetails.user_image == null
                          ? Container(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                maxRadius: 90,
                                minRadius: 90,
                                child: Stack(
                                  children: [
                                    // Align(
                                    //   alignment: Alignment.bottomRight,
                                    //   child: IconButton(
                                    //       icon: Icon(
                                    //         Icons.camera_alt,
                                    //         color: Colors.grey,
                                    //         size: 30,
                                    //       ),
                                    //       onPressed: () {
                                    //         showAlertDialog(context);
                                    //       }),
                                    // )
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              child: _imageFilePicked == null
                                  ? CircleAvatar(
                                      backgroundColor: Colors.white,
                                      maxRadius: 90,
                                      minRadius: 90,
                                      backgroundImage: NetworkImage(
                                        'https://www.prismapp.in/prism/images/user/${userDetails.user_image}',
                                      ),
                                      child: Stack(
                                        children: [
                                          // Align(
                                          //   alignment: Alignment.bottomRight,
                                          //   child: IconButton(
                                          //       icon: Icon(
                                          //         Icons.camera_alt,
                                          //         color: Colors.grey,
                                          //         size: 30,
                                          //       ),
                                          //       onPressed: () {
                                          //         showAlertDialog(context);
                                          //       }),
                                          // )
                                        ],
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: Colors.white,
                                      maxRadius: 90,
                                      minRadius: 90,
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Image.file(
                                                _imageFilePicked,
                                                height: 180,
                                                width: 180,
                                              ),
                                            ),
                                          ),
                                          // Align(
                                          //   alignment: Alignment.bottomRight,
                                          //   child: IconButton(
                                          //       icon: Icon(
                                          //         Icons.camera_alt,
                                          //         color: Colors.grey,
                                          //         size: 30,
                                          //       ),
                                          //       onPressed: () {
                                          //         showAlertDialog(context);
                                          //       }),
                                          // )
                                        ],
                                      ),
                                    )),

                      SizedBox(height: MediaQuery.of(context).size.height / 80),
                      CustomTextFieldWidget(
                        inialValue: userDetails.name,
                        controller: _name,
                        saved: (String value) {
                          if (value.isEmpty) {
                            _UserName = userDetails.name;
                          } else {
                            _UserName = value;
                          }
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 80),
                      CustomTextFieldWidget(
                        inialValue: userDetails.pharmacyname,
                        controller: _pharmacy,
                        saved: (String value) {
                          if (value.isEmpty) {
                            _pharmacyName = userDetails.pharmacyname;
                          } else {
                            _pharmacyName = value;
                          }
                        },
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height / 80),
                      CustomTextFieldWidget(
                        inialValue: userDetails.address,
                        controller: _add,
                        saved: (String value) {
                          if (value.isEmpty) {
                            _address = userDetails.address;
                          } else {
                            _address = value;
                          }
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 80),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 15,
                            width: MediaQuery.of(context).size.width / 2.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey)),
                            child: FutureBuilder(
                                future: GetStateListRepo.getStateList(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<
                                            SuperResponse<List<State_Model>>>
                                        snap) {
                                  if (snap.hasData) {
                                    var list = snap.data.data;
                                    return DropdownButton(
                                      hint: Container(
                                          margin: EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: userDetails.state == null
                                              ? Text(
                                                  "State",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily:
                                                          "Poppins-Regular"),
                                                )
                                              : Text(
                                                  "${userDetails.stateName}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily:
                                                          "Poppins-Regular"),
                                                )),
                                      value: _state,
                                      onChanged: (newValue) {
                                        setState(() {
                                          if (newValue == null) {
                                            setState(() {
                                              _state = newValue;
                                              _Disct = null;
                                            });
                                          } else {
                                            setState(() {
                                              _state = newValue;
                                              _Disct = null;
                                            });
                                          }
                                        });
                                      },
                                      underline: SizedBox.shrink(),
                                      items: list.map((State) {
                                        return DropdownMenuItem(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.6,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: new Text(
                                                    State.state_name,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Poppins-Regular",
                                                        color: Colors.black,
                                                        fontSize: 14)),
                                              ),
                                            ),
                                            value: State.id);
                                      }).toList(),
                                    );
                                  }
                                  if (snap.hasError) {
                                    return Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                15,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.2,
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: ListTile(
                                              trailing:
                                                  Icon(Icons.arrow_drop_down),
                                              title: Text(userDetails.stateName,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "Poppins-Regular",
                                                      color: Colors.black,
                                                      fontSize: 14)),
                                            )));
                                  } else {
                                    return Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                15,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.2,
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: ListTile(
                                              trailing:
                                                  Icon(Icons.arrow_drop_down),
                                              title: Text("State",
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "Poppins-Regular",
                                                      color: Colors.grey,
                                                      fontSize: 12)),
                                            )));
                                  }
                                }),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 15,
                            width: MediaQuery.of(context).size.width / 2.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey)),
                            child: _state == null
                                ? FutureBuilder(
                                    future: GetDistListRepo.getDistList(
                                        userDetails.state),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<
                                                SuperResponse<
                                                    List<District_Model>>>
                                            snap) {
                                      if (snap.hasData) {
                                        var list = snap.data.data;
                                        return DropdownButton(
                                          underline: SizedBox.shrink(),
                                          hint: Container(
                                            margin: EdgeInsets.only(
                                                left: 10, right: 5),
                                            child: Text(
                                              "${userDetails.disName}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily:
                                                      "Poppins-Regular"),
                                            ),
                                            // userDetails.district == null
                                            //     ? Text(
                                            //         "District",
                                            //         style: TextStyle(
                                            //             color: Colors.black,
                                            //             fontSize: 14,
                                            //             fontFamily:
                                            //                 "Poppins-Regular"),
                                            //       )
                                            //     : Text(
                                            //         "${userDetails.disName}",
                                            //         style: TextStyle(
                                            //             color: Colors.black,
                                            //             fontSize: 14,
                                            //             fontFamily:
                                            //                 "Poppins-Regular"),
                                            //       ),
                                          ),
                                          isExpanded: true,
                                          value: _Disct,
                                          onChanged: (newValue) {
                                            setState(() {
                                              if (userDetails.district ==
                                                  null) {
                                                setState(() {
                                                  _Disct = newValue;
                                                  //_disc = null;
                                                });
                                              } else {
                                                setState(() {
                                                  _Disct = newValue;
                                                  //_disc = null;
                                                });
                                              }
                                            });
                                          },
                                          items: list.map((Disct) {
                                            return DropdownMenuItem(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
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
                                                alignment: Alignment.centerLeft,
                                                child: ListTile(
                                                  trailing: Icon(
                                                      Icons.arrow_drop_down),
                                                  title: Text(
                                                      "${userDetails.disName}",
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Poppins-Regular",
                                                          color: Colors.grey,
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
                                                alignment: Alignment.centerLeft,
                                                child: ListTile(
                                                  trailing: Icon(
                                                      Icons.arrow_drop_down),
                                                  title: Text("District",
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Poppins-Regular",
                                                          color: Colors.grey,
                                                          fontSize: 12)),
                                                )));
                                      }
                                    })
                                : FutureBuilder(
                                    future: GetDistListRepo.getDistList(_state),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<
                                                SuperResponse<
                                                    List<District_Model>>>
                                            snap) {
                                      if (snap.hasData) {
                                        var list = snap.data.data;
                                        return DropdownButton(
                                          underline: SizedBox.shrink(),
                                          hint: Container(
                                            margin: EdgeInsets.only(
                                                left: 10, right: 5),
                                            child: Text(
                                              "${userDetails.disName}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily:
                                                      "Poppins-Regular"),
                                            ),
                                            // userDetails.district == null
                                            //     ? Text(
                                            //         "District",
                                            //         style: TextStyle(
                                            //             color: Colors.black,
                                            //             fontSize: 14,
                                            //             fontFamily:
                                            //                 "Poppins-Regular"),
                                            //       )
                                            //     : Text(
                                            //         "${userDetails.disName}",
                                            //         style: TextStyle(
                                            //             color: Colors.black,
                                            //             fontSize: 14,
                                            //             fontFamily:
                                            //                 "Poppins-Regular"),
                                            //       ),
                                          ),
                                          isExpanded: true,
                                          value: _Disct,
                                          onChanged: (newValue) {
                                            setState(() {
                                              if (userDetails.district ==
                                                  null) {
                                                setState(() {
                                                  _Disct = newValue;
                                                  //_disc = null;
                                                });
                                              } else {
                                                setState(() {
                                                  _Disct = newValue;
                                                  //_disc = null;
                                                });
                                              }
                                            });
                                          },
                                          items: list.map((Disct) {
                                            return DropdownMenuItem(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
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
                                                alignment: Alignment.centerLeft,
                                                child: ListTile(
                                                  trailing: Icon(
                                                      Icons.arrow_drop_down),
                                                  title: Text(
                                                      "${userDetails.disName}",
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Poppins-Regular",
                                                          color: Colors.grey,
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
                                                alignment: Alignment.centerLeft,
                                                child: ListTile(
                                                  trailing: Icon(
                                                      Icons.arrow_drop_down),
                                                  title: Text("District",
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Poppins-Regular",
                                                          color: Colors.grey,
                                                          fontSize: 12)),
                                                )));
                                      }
                                    }),
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Container(
                      //       width: MediaQuery.of(context).size.width / 2.2,
                      //       child: CustomTextFieldWidget(
                      //         controller: _city,
                      //         inialValue: userDetails.city,
                      //         saved: (String value) {
                      //           if (value.isEmpty) {
                      //             _City = userDetails.city;
                      //           } else {
                      //             _City = value;
                      //           }
                      //         },
                      //       ),
                      //     ),
                      //     Container(
                      //       width: MediaQuery.of(context).size.width / 2.2,
                      //       child: CustomTextFieldWidget(
                      //         inialValue: userDetails.district,
                      //         controller: _disc,
                      //         saved: (String value) {
                      //           if (value.isEmpty) {
                      //             _Disct = userDetails.district;
                      //           } else {
                      //             _Disct = value;
                      //           }
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: MediaQuery.of(context).size.height / 80),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            child: CustomTextFieldWidget(
                              controller: _pin,
                              maxline: 6,
                              counter: "",
                              keboardtype: TextInputType.number,
                              inialValue: userDetails.pincode,
                              saved: (String value) {
                                if (value.isEmpty) {
                                  _pincode = userDetails.pincode;
                                } else {
                                  _pincode = value;
                                }
                              },
                              validator: (String value) {
                                if (value.isEmpty) {
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
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            child: CustomTextFieldWidget(
                              controller: _city,
                              inialValue: userDetails.city,
                              saved: (String value) {
                                if (value.isEmpty) {
                                  _city = userDetails.city;
                                } else {
                                  _City = value;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 80),
                      Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)),
                          child: Padding(
                              padding: EdgeInsets.only(top: 15, left: 10),
                              child: Text(
                                "${userDetails.email}",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ))),
                      // CustomTextFieldWidget(
                      //   inialValue: userDetails.email,
                      //   // controller: _email,
                      //   saved: (String value) {
                      //     if (value.isEmpty) {
                      //       _emailID = userDetails.email;
                      //     } else {
                      //       _emailID = value;
                      //     }
                      //   },
                      //   validator: (String value) {
                      //     if (value.isEmpty) {
                      //       return 'Please Enter Email.';
                      //     }
                      //     if (!value.contains("@")) {
                      //       return 'Please Enter Valid Email.';
                      //     }

                      //     return null;
                      //   },
                      // ),
                      SizedBox(height: MediaQuery.of(context).size.height / 80),
                      Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)),
                          child: Padding(
                              padding: EdgeInsets.only(top: 15, left: 10),
                              child: Text(
                                "${userDetails.phone}",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ))),
                      // CustomTextFieldWidget(
                      //   controller: _mobile,
                      //   maxline: 10,
                      //   counter: "",
                      //   keboardtype: TextInputType.number,
                      //   inialValue: userDetails.phone,
                      //   saved: (String value) {
                      //     if (value.isEmpty) {
                      //       _mobileNumber = userDetails.phone;
                      //     } else {
                      //       _mobileNumber = value;
                      //     }
                      //   },
                      //   validator: (String value) {
                      //     if (value.isEmpty) {
                      //       return 'Please Enter Mobile no.';
                      //     }
                      //     if (value.length < 10) {
                      //       return 'Please Enter Valid Mobile No.';
                      //     }
                      //     if (value.length > 10) {
                      //       return 'Please Enter Valid Mobile No.';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      SizedBox(height: MediaQuery.of(context).size.height / 80),
                      // Container(
                      //   height: 55,
                      //   child: TextFormField(
                      //     keyboardType: TextInputType.text,
                      //     // controller: _userPasswordController,
                      //     obscureText:
                      //         !_passwordVisible, //This will obscure text dynamically
                      //     decoration: InputDecoration(
                      //       labelText: 'Password',
                      //       suffixIcon: IconButton(
                      //         icon: Icon(
                      //           _passwordVisible
                      //               ? Icons.visibility
                      //               : Icons.visibility_off,
                      //           color: Colors.grey,
                      //         ),
                      //         onPressed: () {
                      //           setState(() {
                      //             _passwordVisible = !_passwordVisible;
                      //           });
                      //         },
                      //       ),
                      //       labelStyle: new TextStyle(
                      //         color: Colors.grey,
                      //         fontFamily: "Poppins-Regular",
                      //         fontSize: 12,
                      //       ),
                      //       border: const OutlineInputBorder(
                      //         borderRadius: BorderRadius.all(
                      //           Radius.circular(10.0),
                      //         ),
                      //         borderSide: BorderSide(
                      //           color: Colors.grey,
                      //           width: 2.0,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 15),
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
                          onButtonClick();
                          setState(() {});
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

  void _goToHomePage(User_Registration user) {
    SessionManager.saveUserObject(user);
    userDetails = user;

    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => Homepage(
    //               user: user,
    //               cart: cart,
    //             )));.....
  }

  void onButtonClick() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('form is valid');
      print(_UserName);
      // print(_imageFilePicked);
      // print(_imageFilePicked.toString().substring(72, 131).trim());

      if (_imageFilePicked == null) {
        _imageFilePicked1 = userDetails.user_image;
      } else {
        _imageFilePicked1 = _imageFilePicked.toString().substring(72, 131);
      }
      if (_imageFilePicked == null) {
        imageName = userDetails.image_name;
      } else {
        imageName = _imageFilePicked.toString().substring(72, 131);
      }
      if (img64 == null) {
        image64 = userDetails.img_url;
      } else {
        image64 = img64;
      }
      if (_state == null) {
        statename = userDetails.state;
      } else {
        statename = _state;
      }
      if (_Disct == null) {
        discName = userDetails.district;
      } else {
        discName = _Disct;
      }
      var isInternetConnected = await InternetUtil.isInternetConnected();
      if (isInternetConnected) {
        ProgressDialog.showProgressDialog(context);
        try {
          var response = await UpdateUserRepo.updateUserr(
            userDetails.id,
            _UserName,
            "abc",
            _pharmacyName,
            _address,
            _City,
            discName,
            _pincode,
            statename,
            _mobileNumber,
            _emailID,
            imageName,
            _imageFilePicked1,
            image64,
          );
          print(response.data);
          if (response.status == 201) {
            Fluttertoast.showToast(
                msg: "Detail Update Succesfull",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 10,
                backgroundColor: MyColors.themecolor,
                textColor: MyColors.textcolor,
                fontSize: 12.0);

            goToHomePage(response.data);
          } else if (response.status == 402) {
            Fluttertoast.showToast(
                msg: response.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 10,
                backgroundColor: MyColors.themecolor,
                textColor: MyColors.textcolor,
                fontSize: 12.0);
          } else {
            Fluttertoast.showToast(
                msg: "Something wronge...",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 10,
                backgroundColor: MyColors.themecolor,
                textColor: MyColors.textcolor,
                fontSize: 12.0);
          }
        } catch (error) {
          //Navigator.of(context).pop();
          print(
            'API Fail',
          );
          print(error);
        }
      } else {
        print(
          'No Internet Connection!!',
        );
      }
    }
  }

  void goToHomePage(User_Registration user) {
    SessionManager.saveUserObject(user);

    setState(() {
      userDetails = user;
    });

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Homepage(
          cart: cart,
          user: user,
        ),
      ),
    );
  }

  getFromGallery() async {
    _pickImage(imageSource: ImageSource.gallery);
  }

  getFromCamera() async {
    _pickImage(imageSource: ImageSource.camera);
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
