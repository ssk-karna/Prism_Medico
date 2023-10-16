import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prism_medico/model/latestProduct.dart';
import 'package:prism_medico/Screens/cart.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Screens/notification.dart';
import 'package:prism_medico/Screens/order_History.dart';
import 'package:prism_medico/utills/Super_Responce.dart';
import 'package:prism_medico/utills/Constant.dart';
import 'package:prism_medico/Screens/profile.dart';
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/Widgets/CustomTextFormField.dart';
import 'package:prism_medico/Repo/allProductRepo.dart';
import 'package:prism_medico/Repo/searchProductRepo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prism_medico/utills/Session_Manager.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AllProduct extends StatefulWidget {
  final List<Latest_Product_model> cart;
  AllProduct({this.cart});
  _AllProductState createState() => _AllProductState(this.cart);
}

class _AllProductState extends State<AllProduct> {
  _AllProductState(this.cart);
  List<Latest_Product_model> cart;
  bool _autoValidate = false;
  bool stockavailable = true;
  List<String> added = [];
  String currentText = "";
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  List<Latest_Product_model> categoryArr = [];
  List<String> pro = [];
  List<String> proname = [];
  List<String> proId = [];
  List<String> proDetails = [];
  List<String> stock = [];
  List<String> matches = <String>[];
  TextEditingController controller = TextEditingController();
  List suggestionList = [];
  String search;
  String hint = "";
  String _qnty;
  String searchProName;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _quntyController = TextEditingController();
  var list;
  var productData;

  @override
  void initState() {
    super.initState();
    setState(() {
      _quntyController.clear();
    });
    allProductListRepo.getallProduct().then((value) {
      productData = value.data;
      for (int i = 0; i < value.data.length; i++) {
        var list = Latest_Product_model(name: value.data[i].name);
        var idlist = Latest_Product_model(id: value.data[i].id);
        print(list.name);
        print(idlist.id);
        proname.add(list.name);
        proId.add(idlist.id);
      }
    });

    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  void serachProduct(String proName) {}

  void typeAheadFilter(String value) {
    suggestionList.clear();

    if (value.isEmpty) {
      setState(() {});
      return;
    }

    for (String n in proname) {
      if (n.toLowerCase().contains(value)) {
        suggestionList.add(n);
      } else {}
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(cart);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.themecolor,
          //bottomOpacity: 1.0,
          elevation: 1,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // width: MediaQuery.of(context).size.width / 1,
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "All Products",
                            style: TextStyle(
                              fontFamily: "Poppins-Semibold",
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //width: MediaQuery.of(context).size.width / 6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          child: SvgPicture.asset(
                            "assets/images/notification.svg",
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Notificationscreen(
                                      cart: cart,
                                    )));
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            height: 50,
                            width: 40,
                            child: Stack(
                              children: [
                                cart.length == 0
                                    ? InkWell(
                                        onTap: () {
                                          Fluttertoast.showToast(
                                              msg: "Cart is Empty...",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.SNACKBAR,
                                              timeInSecForIosWeb: 10,
                                              backgroundColor:
                                                  MyColors.themecolor,
                                              textColor: MyColors.textcolor,
                                              fontSize: 12.0);
                                        },
                                        child: Center(
                                          child: SvgPicture.asset(
                                            "assets/images/cart.svg",
                                          ),
                                        ),
                                      )
                                    : Stack(
                                        children: [
                                          Center(
                                            child: SvgPicture.asset(
                                              "assets/images/cart.svg",
                                            ),
                                          ),
                                          Positioned(
                                            right: 0.5,
                                            top: 5,
                                            child: CircleAvatar(
                                              radius: 9.5,
                                              backgroundColor:
                                                  MyColors.textcolor,
                                              foregroundColor: Colors.white,
                                              child: Text(
                                                cart.length.toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                              ],
                            ),
                          ),
                          onTap: () {
                            if (cart.isNotEmpty)
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Cart(cart: cart),
                                ),
                              );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 50,
          decoration: BoxDecoration(
            color: MyColors.themecolor,
          ),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: SvgPicture.asset(
                      "assets/images/Home.svg",
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Homepage(
                                    cart: cart,
                                  ))).then((value) {});
                    },
                  ),
                  InkWell(
                    child: SvgPicture.asset(
                      "assets/images/account.svg",
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Profile(
                                    cart: cart,
                                  )));
                    },
                  ),
                  InkWell(
                    child: Image.asset(
                      "assets/images/order.png",
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderHistory(
                                    cart: cart,
                                  )));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              // height: MediaQuery.of(context).size.height / 1.5,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.3,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    // TypeAheadField(
                    //   animationStart: 0,
                    //   animationDuration: Duration.zero,
                    //   textFieldConfiguration: TextFieldConfiguration(
                    //       autofocus: false,
                    //       style: TextStyle(fontSize: 15),
                    //       decoration:
                    //           InputDecoration(border: OutlineInputBorder())),
                    //   suggestionsBoxDecoration: SuggestionsBoxDecoration(),
                    //   suggestionsCallback: (pattern) {
                    //     matches.addAll(proname);

                    //     matches.retainWhere((s) {
                    //       return s
                    //           .toLowerCase()
                    //           .contains(pattern.toLowerCase());
                    //     });
                    //     return matches;
                    //   },
                    //   itemBuilder: (context, index) {
                    //     return InkWell(
                    //       onTap: () {
                    //         print(index.toString());
                    //       },
                    //       child: Card(
                    //           child: Container(
                    //               padding: EdgeInsets.all(10),
                    //               child: Padding(
                    //                 padding: const EdgeInsets.all(4.0),
                    //                 child: Row(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.spaceBetween,
                    //                   children: [
                    //                     Text(
                    //                       (index.toString()),
                    //                       style: TextStyle(
                    //                           fontFamily: "Poppins-semibold",
                    //                           fontSize: 14),
                    //                     ),
                    //                     if (matches.isNotEmpty) ...[
                    //                       Expanded(child: Text(proname[0]))
                    //                     ] else
                    //                       ...[]
                    //                   ],
                    //                 ),
                    //               ))),
                    //     );
                    //   },
                    //   onSuggestionSelected: (suggestion) {
                    //     return Text('$suggestion');
                    //   },
                    // ),
                    Container(
                      child: RawKeyboardListener(
                        focusNode: FocusNode(),
                        onKey: (RawKeyEvent event) {
                          print(event.data.logicalKey.keyId);
                          if (event.runtimeType == runtimeType) {
                            print("key presss");
                          }
                        },
                        child: TextFormField(
                            controller: controller,
                            onSaved: (newValue) {
                              search = newValue;
                            },
                            autofillHints: proname,
                            onFieldSubmitted: (value) {
                              search = value;
                            },
                            onTap: () {},
                            onChanged: (value) {
                              typeAheadFilter(value);
                              if (value.contains(value)) {
                                typeAheadFilter(value);
                              } else {
                                print("not data");
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              //hintText: hint,
                              labelText: "Search",
                              alignLabelWithHint: false,
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2.0,
                                ),
                              ),
                              //   hintTextDirection: TextDirection.rtl),
                            )),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (suggestionList.isNotEmpty ||
                        controller.text.isNotEmpty) ...[
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(10),
                          shrinkWrap: true,
                          itemCount: suggestionList.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                AlertDialog alert = AlertDialog(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ('${productData[index].name}'),
                                        style: TextStyle(
                                            fontFamily: "Poppins-semibold",
                                            fontSize: 16,
                                            color: MyColors.textcolor),
                                      ),
                                      IconButton(
                                          icon: Icon(
                                            Icons.cancel_outlined,
                                            color: MyColors.textcolor,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          })
                                    ],
                                  ),
                                  content: Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 40,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Text(
                                            ('${productData[index].composition}'),
                                            softWrap: true,
                                            style: TextStyle(
                                                fontFamily: "Poppins-Regular",
                                                fontSize: 12,
                                                color: MyColors.textcolor),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Case:",
                                              style: TextStyle(
                                                  fontFamily: "Poppins-Regular",
                                                  fontSize: 12,
                                                  color: MyColors.textcolor),
                                            ),
                                            Container(
                                              width: 100,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Qty:",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Poppins-semibold",
                                                        fontSize: 14,
                                                        color:
                                                            MyColors.textcolor),
                                                  ),
                                                  Container(
                                                    width: 60,
                                                    child: TextFormField(
                                                      controller:
                                                          _quntyController,
                                                      onSaved: (newValue) {
                                                        _qnty = newValue;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    Center(
                                        child: FlatButton(
                                      // height: ,
                                      // minWidth: MediaQuery.of(context).size.width / 3,
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      shape: (RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        //side: BorderSide(color: Colors.red)
                                      )),
                                      textColor: Colors.white,
                                      color: MyColors.themecolor,
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();

                                          print('form is valid');

                                          _qnty =
                                              _quntyController.text.toString();

                                          productData[index].quntity =
                                              int.parse(_qnty);
                                          if (cart.length != 0) {
                                            if (cart.contains(
                                                productData[index].id)) {
                                              setState(() {
                                                cart[cart.indexWhere(
                                                        (element) =>
                                                            element.id ==
                                                            cart[index].id)] =
                                                    cart[index];
                                              });
                                              _quntyController.clear();
                                              Navigator.of(context).pop();
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "${productData[index].name} updated into cart...",
                                                  gravity: ToastGravity.CENTER,
                                                  backgroundColor:
                                                      Colors.lightBlue,
                                                  textColor: MyColors.textcolor,
                                                  toastLength:
                                                      Toast.LENGTH_LONG);
                                            } else {
                                              if (productData[index].quntity ==
                                                  0) {
                                                _quntyController.clear();
                                                Navigator.of(context).pop();
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Please enter quntity...",
                                                    gravity:
                                                        ToastGravity.CENTER,
                                                    backgroundColor:
                                                        Colors.lightBlue[200],
                                                    textColor:
                                                        MyColors.textcolor,
                                                    toastLength:
                                                        Toast.LENGTH_LONG);
                                              } else {
                                                setState(() {
                                                  cart.add(productData[index]);
                                                  _quntyController.clear();
                                                  SessionManager.saveCartObject(
                                                      cart);
                                                });
                                                Navigator.of(context).pop();
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "${productData[index].name} added into cart...",
                                                    gravity:
                                                        ToastGravity.CENTER,
                                                    backgroundColor:
                                                        Colors.lightBlue[200],
                                                    textColor:
                                                        MyColors.textcolor,
                                                    toastLength:
                                                        Toast.LENGTH_LONG);
                                                SessionManager.saveCartObject(
                                                    cart);
                                              }
                                            }
                                          } else {
                                            print("something wronge");
                                            if (productData[index].quntity ==
                                                0) {
                                              _quntyController.clear();
                                              Navigator.of(context).pop();
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Please enter quntity...",
                                                  gravity: ToastGravity.CENTER,
                                                  backgroundColor:
                                                      Colors.lightBlue[200],
                                                  textColor: MyColors.textcolor,
                                                  toastLength:
                                                      Toast.LENGTH_LONG);
                                            } else {
                                              setState(() {
                                                cart.add(productData[index]);
                                                _quntyController.clear();
                                                SessionManager.saveCartObject(
                                                    cart);
                                              });
                                              Navigator.of(context).pop();
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "${productData[index].name} added into cart...",
                                                  gravity: ToastGravity.CENTER,
                                                  backgroundColor:
                                                      Colors.lightBlue[200],
                                                  textColor: MyColors.textcolor,
                                                  toastLength:
                                                      Toast.LENGTH_LONG);
                                              SessionManager.saveCartObject(
                                                  cart);
                                            }
                                          }
                                        } else {
                                          setState(() {
                                            print("Try again later....");
                                          });
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: Text(
                                        'ADD',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins-Semibold",
                                          fontSize: 12,
                                        ),
                                      ),
                                    )),
                                  ],
                                );

                                // show the dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                );

                                // show the dialog
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 2),
                                          blurRadius: 5.0,
                                          color: Colors.grey.withOpacity(0.6),
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              (productData[index].name),
                                              style: TextStyle(
                                                  fontFamily:
                                                      "Poppins-semibold",
                                                  fontSize: 14),
                                            ),
                                            Text(
                                              "Pack: ${productData[index].stock}",
                                              style: TextStyle(
                                                  fontFamily: "Poppins-regular",
                                                  fontSize: 11,
                                                  color: Colors.grey),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 20,
                                                // width: MediaQuery.of(context)
                                                //         .size
                                                //         .width /
                                                //     1.6,
                                                child: Text(
                                                  "${productData[index].composition}",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "Poppins-regular",
                                                      fontSize: 11,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              // width: MediaQuery.of(context)
                                              //         .size
                                              //         .width /
                                              //     6,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Stock :",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Poppins-semibold",
                                                        fontSize: 12,
                                                        color:
                                                            MyColors.textcolor),
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  productData[index].stock != 0
                                                      ? Icon(
                                                          Icons.check_circle,
                                                          color: Colors.green,
                                                          size: 20,
                                                        )
                                                      : Icon(
                                                          Icons.cancel,
                                                          color: Colors.red,
                                                          size: 20,
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            );
                          },
                        ),
                      )
                    ] else ...[
                      FutureBuilder(
                        future: searchProductListRepo.searchProduct(search),
                        builder: (BuildContext context,
                            AsyncSnapshot<
                                    SuperResponse<List<Latest_Product_model>>>
                                snap) {
                          if (snap.hasData) {
                            list = snap.data.data;

                            return Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.all(5),
                                shrinkWrap: true,
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: <Widget>[
                                      ...list
                                          .map((e) => InkWell(
                                                onTap: () {
                                                  cart.add(e);
                                                  //showOrderplaced(context);
                                                  AlertDialog alert =
                                                      AlertDialog(
                                                    title: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          ('${e.name}'),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Poppins-semibold",
                                                              fontSize: 16),
                                                        ),
                                                        IconButton(
                                                            icon: Icon(
                                                              Icons.cancel,
                                                              color: MyColors
                                                                  .textcolor,
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            })
                                                      ],
                                                    ),
                                                    content: Container(
                                                      height: 80,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                ('${e.packingSpecification}'),
                                                                softWrap: true,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Poppins-Regular",
                                                                    fontSize:
                                                                        12,
                                                                    color: MyColors
                                                                        .textcolor),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Case:",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Poppins-Regular",
                                                                    fontSize:
                                                                        12,
                                                                    color: MyColors
                                                                        .textcolor),
                                                              ),
                                                              Container(
                                                                width: 100,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      "Qty:",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Poppins-semibold",
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              MyColors.textcolor),
                                                                    ),
                                                                    Container(
                                                                        width:
                                                                            60,
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              _quntyController,
                                                                          validator:
                                                                              (value) {
                                                                            if (value.isEmpty) {
                                                                              return 'Enter Quntity';
                                                                            }
                                                                            if (value ==
                                                                                '0') {
                                                                              return 'Enter Quntity';
                                                                            }
                                                                            return null;
                                                                          },
                                                                          onSaved:
                                                                              (value) {
                                                                            _qnty =
                                                                                value;
                                                                          },
                                                                          keyboardType:
                                                                              TextInputType.number,
                                                                        )),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      Center(
                                                          child: FlatButton(
                                                        // height: ,
                                                        // minWidth: MediaQuery.of(context).size.width / 3,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 15,
                                                                right: 15),
                                                        shape:
                                                            (RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          //side: BorderSide(color: Colors.red)
                                                        )),
                                                        textColor: Colors.white,
                                                        color:
                                                            MyColors.themecolor,
                                                        onPressed: () async {
                                                          if (_formKey
                                                              .currentState
                                                              .validate()) {
                                                            _formKey
                                                                .currentState
                                                                .save();

                                                            print(
                                                                'form is valid');

                                                            _qnty =
                                                                _quntyController
                                                                    .text
                                                                    .toString();

                                                            e.quntity =
                                                                int.parse(
                                                                    _qnty);
                                                            if (cart.length !=
                                                                0) {
                                                              if (cart[index]
                                                                  .id
                                                                  .contains(
                                                                      e.id)) {
                                                                setState(() {
                                                                  cart[cart.indexWhere(
                                                                      (element) =>
                                                                          element
                                                                              .id ==
                                                                          e.id)] = cart[
                                                                      index];
                                                                });
                                                                _quntyController
                                                                    .clear();
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                Fluttertoast.showToast(
                                                                    msg:
                                                                        "${e.name} updated into cart...",
                                                                    gravity:
                                                                        ToastGravity
                                                                            .CENTER,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .lightBlue,
                                                                    textColor:
                                                                        MyColors
                                                                            .textcolor,
                                                                    toastLength:
                                                                        Toast
                                                                            .LENGTH_LONG);
                                                              } else {
                                                                if (e.quntity ==
                                                                    0) {
                                                                  _quntyController
                                                                      .clear();
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  Fluttertoast.showToast(
                                                                      msg:
                                                                          "Please enter quntity...",
                                                                      gravity:
                                                                          ToastGravity
                                                                              .CENTER,
                                                                      backgroundColor:
                                                                          Colors.lightBlue[
                                                                              200],
                                                                      textColor:
                                                                          MyColors
                                                                              .textcolor,
                                                                      toastLength:
                                                                          Toast
                                                                              .LENGTH_LONG);
                                                                } else {
                                                                  setState(() {
                                                                    cart.add(e);
                                                                    _quntyController
                                                                        .clear();
                                                                    SessionManager
                                                                        .saveCartObject(
                                                                            cart);
                                                                  });
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  Fluttertoast.showToast(
                                                                      msg:
                                                                          "${e.name} added into cart...",
                                                                      gravity:
                                                                          ToastGravity
                                                                              .CENTER,
                                                                      backgroundColor:
                                                                          Colors.lightBlue[
                                                                              200],
                                                                      textColor:
                                                                          MyColors
                                                                              .textcolor,
                                                                      toastLength:
                                                                          Toast
                                                                              .LENGTH_LONG);
                                                                  SessionManager
                                                                      .saveCartObject(
                                                                          cart);
                                                                }
                                                              }
                                                            } else {
                                                              print(
                                                                  "something wronge");
                                                              if (e.quntity ==
                                                                  0) {
                                                                _quntyController
                                                                    .clear();
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                Fluttertoast.showToast(
                                                                    msg:
                                                                        "Please enter quntity...",
                                                                    gravity:
                                                                        ToastGravity
                                                                            .CENTER,
                                                                    backgroundColor:
                                                                        Colors.lightBlue[
                                                                            200],
                                                                    textColor:
                                                                        MyColors
                                                                            .textcolor,
                                                                    toastLength:
                                                                        Toast
                                                                            .LENGTH_LONG);
                                                              } else {
                                                                setState(() {
                                                                  cart.add(e);
                                                                  _quntyController
                                                                      .clear();
                                                                  SessionManager
                                                                      .saveCartObject(
                                                                          cart);
                                                                });
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                Fluttertoast.showToast(
                                                                    msg:
                                                                        "${e.name} added into cart...",
                                                                    gravity:
                                                                        ToastGravity
                                                                            .CENTER,
                                                                    backgroundColor:
                                                                        Colors.lightBlue[
                                                                            200],
                                                                    textColor:
                                                                        MyColors
                                                                            .textcolor,
                                                                    toastLength:
                                                                        Toast
                                                                            .LENGTH_LONG);
                                                                SessionManager
                                                                    .saveCartObject(
                                                                        cart);
                                                              }
                                                            }
                                                          } else {
                                                            setState(() {
                                                              print(
                                                                  "Try again later....");
                                                            });
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }
                                                        },
                                                        child: Text(
                                                          'ADD',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                "Poppins-Semibold",
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      )),
                                                    ],
                                                  );

                                                  // show the dialog
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return alert;
                                                    },
                                                  );
                                                },

                                                // show the dialog

                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 10),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            offset:
                                                                Offset(0, 2),
                                                            blurRadius: 5.0,
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.6),
                                                          ),
                                                        ]),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                ('${e.name}'),
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Poppins-semibold",
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                              Text(
                                                                "Pack: ${e.stock}cap",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Poppins-regular",
                                                                    fontSize:
                                                                        11,
                                                                    color: Colors
                                                                        .grey),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "${e.catName}",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Poppins-regular",
                                                                    fontSize:
                                                                        11,
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    5,
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      "Stock :",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Poppins-semibold",
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              MyColors.textcolor),
                                                                    ),
                                                                    e.stock ==
                                                                            '0'
                                                                        ? Icon(
                                                                            Icons.cancel,
                                                                            color:
                                                                                Colors.red,
                                                                            size:
                                                                                20,
                                                                          )
                                                                        : Icon(
                                                                            Icons.check_circle,
                                                                            color:
                                                                                Colors.green,
                                                                            size:
                                                                                20,
                                                                          )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                              ))
                                          .toList()
                                    ],
                                  );
                                },
                              ),
                            );
                          }
                          if (snap.hasError) {
                            return Center(
                              child: Container(
                                height: 150,
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/No-data-available.jpg",
                                      height: 100,
                                    ),
                                    Text(
                                      "No Data Available...",
                                      style: TextStyle(
                                          fontFamily: "Poppins-semibold",
                                          fontSize: 12,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              child: Center(
                                  child: Text(
                                "Loading...",
                                style: TextStyle(
                                    fontFamily: "Poppins-semibold",
                                    fontSize: 16,
                                    color: MyColors.textcolor),
                              )),
                            );
                          }
                        },
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateQuantityInDatabase(Latest_Product_model item) {
    FirebaseFirestore.instance
        .collection('productData')
        .doc()
        .set({'quantity': item.quntity}).then((value) {
      print('Quantity updated successfully');
    }).catchError((error) {
      print('Failed to update quantity: $error');
    });
  }
}
