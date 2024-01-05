import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Screens/notification.dart';
import 'package:prism_medico/Screens/order_History.dart';
import 'package:prism_medico/Screens/profile.dart';
import 'package:prism_medico/model/latestProduct.dart';
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prism_medico/Repo/orderRepo.dart';
import 'package:prism_medico/model/order_Model.dart';
import 'package:prism_medico/utills/Constant.dart';
import 'package:prism_medico/utills/Internet_Connection.dart';
import 'package:prism_medico/utills/Progress_Dialog.dart';
import 'package:prism_medico/utills/Session_Manager.dart';

class Cart extends StatefulWidget {
  final Latest_Product_model product;
  final List<Latest_Product_model> cart;
  final name;
  final specificaton;
  final detail;
  final id;
  final rate;
  bool iscommingfromallproduct;

  var qunty;

  Cart(
      {this.product,
      this.qunty,
      this.cart,
      this.detail,
      this.id,
      this.name,
      this.rate,
      this.specificaton,
      this.iscommingfromallproduct});

  _CartState createState() => _CartState(this.cart);
}

class _CartState extends State<Cart> {
  final _formKey = GlobalKey<FormState>();
  bool stockavailable = true;

  List<dynamic> listNewArr;
  var isCartEmpty = false;
  _CartState(this.cart);
  List<Latest_Product_model> cart;
  List<Latest_Product_model> cart1;
  List<order_Model> notify = List<order_Model>();
  List<order_Model> notifylist;
  DateTime today = DateTime.now();
  String dateStr;
  List<Order> orderItems;
  List notificationData = [];
  List orderData = [];
  int quntity;
  var _qty;
  int counter = 0;
  var quntitystring;
  TextEditingController _quntitycontroller;
  var deviceID;
  void getProduct() {
    var list1 = <Latest_Product_model>[
      Latest_Product_model(),
    ];
    cart1 = list1;
  }

  @override
  void initState() {
    isCartEmpty = true;
    SessionManager.getUser().then((value) {
      setState(() {
        userDetails = value;
      });
    });
    _quntitycontroller = TextEditingController();

    //_qty=cart[i];
    setState(() {
      _qty;
    });

    quntitystring = new TextEditingController(text: counter.toString());
    SessionManager.getcartList().then((value) {
      setState(() {
        proList = value;
        print(proList.length);
      });
    });

    setState(() {
      dateStr = today.toString().substring(0, 10);
    });
    getProduct();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.themecolor,
        //bottomOpacity: 1.0,
        elevation: 1,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    // width: MediaQuery.of(context).size.width / 1,
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Cart",
                            style: TextStyle(
                              fontFamily: "Poppins-Semibold",
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  //  width: MediaQuery.of(context).size.width / 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Notificationscreen(
                                    cart: cart,
                                    // notify: notify,
                                  )));
                        },
                        child: SvgPicture.asset(
                          "assets/images/notification.svg",
                        ),
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
                                            backgroundColor: MyColors.textcolor,
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
                          // if (cart.isNotEmpty)
                          //   Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //       builder: (context) => Cart(cart: cart),
                          //     ),
                          //   );
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
                                )));
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
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 15),
                height: 40,
                decoration: BoxDecoration(color: Colors.grey.shade200),
                child: Center(
                  child: cart.length == 0
                      ? Text(
                          "No item in the cart",
                          style: TextStyle(
                              fontFamily: "Poppins-regular",
                              fontSize: 12,
                              color: MyColors.textcolor),
                        )
                      : Text(
                          " ${cart.length.toString()}  item in the cart",
                          style: TextStyle(
                              fontFamily: "Poppins-regular",
                              fontSize: 12,
                              color: MyColors.textcolor),
                        ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              cart.length == 0
                  ? Center(
                      child: Container(
                        height: 150,
                        child: Text("Your Cart is Empty....",
                            style: TextStyle(
                                fontFamily: "Poppins-Bold",
                                fontSize: 18,
                                color: MyColors.textcolor)),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height / 1.4,
                      child: Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 1.5,
                            child: ListView.builder(
                              itemCount: cart.length,
                              itemBuilder: (context, index) {
                                var item = cart[index];
                                _qty = item.quntity;

                                return Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.all(5),
                                  width: MediaQuery.of(context).size.width,
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.network(
                                        '${Constants.BASE_URL}prism/${item.productImage[0]}',
                                        height: 60,
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.4,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      item.name,
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Poppins-Semibold",
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  IconButton(
                                                      icon: Icon(
                                                        Icons.cancel,
                                                        color:
                                                            MyColors.textcolor,
                                                        size: 20,
                                                      ),
                                                      onPressed: () {
                                                        cart.remove(item);
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "${item.name}  Deleted",
                                                            toastLength: Toast
                                                                .LENGTH_LONG);
                                                        setState(() {
                                                          cart.length;
                                                        });
                                                      })
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 20,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                    child: Text(
                                                      item.composition,
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Poppins-regular",
                                                          fontSize: 10,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.4,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              5.9,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "Stock :",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins-semibold",
                                                                fontSize: 12,
                                                                color: MyColors
                                                                    .textcolor),
                                                          ),
                                                          stockavailable
                                                              ? Icon(
                                                                  Icons
                                                                      .check_circle,
                                                                  color: Colors
                                                                      .green,
                                                                  size: 20,
                                                                )
                                                              : Icon(
                                                                  Icons.cancel,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 20,
                                                                ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      //color: Colors.yellow,
                                                      height: 30,

                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors
                                                              .grey.shade300),
                                                      child:
                                                          // widget.iscommingfromallproduct ==
                                                          //         true
                                                          //     ? Row(
                                                          //         mainAxisAlignment:
                                                          //             MainAxisAlignment
                                                          //                 .spaceEvenly,
                                                          //         children: [
                                                          //           IconButton(
                                                          //               icon:
                                                          //                   Icon(
                                                          //                 Icons
                                                          //                     .remove,
                                                          //                 color: MyColors
                                                          //                     .textcolor,
                                                          //                 size:
                                                          //                     15,
                                                          //               ),
                                                          //               onPressed:
                                                          //                   () {
                                                          //                 setState(
                                                          //                     () {
                                                          //                   item.quntity--;
                                                          //                 });
                                                          //                 updateQuantityInDatabase(
                                                          //                     item);
                                                          //               }),
                                                          //           item.quntity ==
                                                          //                   null
                                                          //               ? Text(
                                                          //                   '0',
                                                          //                   style: TextStyle(
                                                          //                       color: MyColors.textcolor,
                                                          //                       fontFamily: "Poppins-regular"),
                                                          //                 )
                                                          //               : Text(
                                                          //                   item.quntity
                                                          //                       .toString(),
                                                          //                   style: TextStyle(
                                                          //                       color: MyColors.textcolor,
                                                          //                       fontFamily: "Poppins-regular"),
                                                          //                 ),
                                                          //           IconButton(
                                                          //               icon:
                                                          //                   Icon(
                                                          //                 Icons
                                                          //                     .add,
                                                          //                 color: MyColors
                                                          //                     .textcolor,
                                                          //                 size:
                                                          //                     15,
                                                          //               ),
                                                          //               onPressed:
                                                          //                   () {
                                                          //                 if (item.quntity ==
                                                          //                     null) {
                                                          //                   item.quntity =
                                                          //                       0;
                                                          //                   setState(
                                                          //                       () {
                                                          //                     item.quntity++;
                                                          //                     //cart[index].quntity=widget.qunty;
                                                          //                   });
                                                          //                   updateQuantityInDatabase(
                                                          //                       item);
                                                          //                 }
                                                          //               })
                                                          //         ],
                                                          //       )
                                                          //    :
                                                          Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          IconButton(
                                                              icon: Icon(
                                                                Icons.remove,
                                                                color: MyColors
                                                                    .textcolor,
                                                                size: 15,
                                                              ),
                                                              onPressed: () {
                                                                counter = int.parse(
                                                                    _quntitycontroller
                                                                        .text);
                                                                setState(() {
                                                                  if (item.quntity >
                                                                      0) {
                                                                    item.quntity--;
                                                                    _quntitycontroller
                                                                            .text =
                                                                        item.quntity
                                                                            .toString();
                                                                    _qty =
                                                                        _quntitycontroller
                                                                            .text;
                                                                  }
                                                                  // counter = int.parse(
                                                                  //     _quntitycontroller
                                                                  //         .text);
                                                                  // setState(() {
                                                                  //   if (counter >
                                                                  //       0) {
                                                                  //     counter--;
                                                                  //     _quntitycontroller
                                                                  //             .text =
                                                                  //         counter
                                                                  //             .toString();
                                                                  //     _qty = _quntitycontroller
                                                                  //         .text;
                                                                  //   }
                                                                  // });
                                                                });

                                                                // updateQuantityInDatabase(
                                                                //     item);
                                                              }),
                                                          item.quntity == null
                                                              // ? Text(
                                                              //     '0',
                                                              //     style: TextStyle(
                                                              //         color: MyColors
                                                              //             .textcolor,
                                                              //         fontFamily:
                                                              //             "Poppins-regular"),
                                                              //   )
                                                              // : Text(
                                                              //     item.quntity
                                                              //         .toString(),
                                                              //     style: TextStyle(
                                                              //         color: MyColors
                                                              //             .textcolor,
                                                              //         fontFamily:
                                                              //             "Poppins-regular"),
                                                              //   ),
                                                              ? Container(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 30,
                                                                  child:
                                                                      TextFormField(
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    controller:
                                                                        _quntitycontroller
                                                                          ..text =
                                                                              "$_qty",
                                                                    onSaved: (String
                                                                        newValue) {
                                                                      setState(
                                                                          () {
                                                                        _qty =
                                                                            newValue;
                                                                        // _qty = _quntitycontroller
                                                                        //     .text
                                                                        //     .toString();
                                                                        // counter =
                                                                        //     _qty;
                                                                        // item.quntity =
                                                                        //     int.parse(_qty);
                                                                        // updateQuantityInDatabase(
                                                                        //     item);
                                                                      });
                                                                    },
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        item.quntity =
                                                                            value;
                                                                      });
                                                                    },
                                                                    style: TextStyle(
                                                                        color: MyColors
                                                                            .textcolor,
                                                                        fontFamily:
                                                                            "Poppins-regular"),
                                                                  ),
                                                                )
                                                              : Container(
                                                                  color: Colors
                                                                      .yellow
                                                                      .shade50,
                                                                  width: 30,
                                                                  child:
                                                                      TextFormField(
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    controller:
                                                                        _quntitycontroller
                                                                          ..text =
                                                                              "$_qty",
                                                                    onSaved: (String
                                                                        newValue) {
                                                                      setState(
                                                                          () {
                                                                        _qty =
                                                                            newValue;
                                                                        // _qty = _quntitycontroller
                                                                        //     .text
                                                                        //     .toString();

                                                                        // item.quntity =
                                                                        //     int.parse(_qty);

                                                                        // updateQuantityInDatabase(
                                                                        //     item);
                                                                      });
                                                                    },
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        _qty = _quntitycontroller
                                                                            .text
                                                                            .toString();
                                                                      });
                                                                    },
                                                                    decoration:
                                                                        InputDecoration(),
                                                                    style: TextStyle(
                                                                        color: MyColors
                                                                            .textcolor,
                                                                        fontFamily:
                                                                            "Poppins-regular"),
                                                                  ),
                                                                ),
                                                          IconButton(
                                                              icon: Icon(
                                                                Icons.add,
                                                                color: MyColors
                                                                    .textcolor,
                                                                size: 15,
                                                              ),
                                                              onPressed: () {
                                                                counter = int.parse(
                                                                    _quntitycontroller
                                                                        .text);
                                                                if (item.quntity ==
                                                                    null) {
                                                                  item.quntity =
                                                                      0;
                                                                  setState(() {
                                                                    item.quntity++;
                                                                    _quntitycontroller
                                                                            .text =
                                                                        item.quntity
                                                                            .toString();
                                                                    _qty =
                                                                        _quntitycontroller
                                                                            .text;
                                                                  });
                                                                } else {
                                                                  setState(() {
                                                                    item.quntity++;
                                                                    _quntitycontroller
                                                                            .text =
                                                                        item.quntity
                                                                            .toString();
                                                                    _qty =
                                                                        _quntitycontroller
                                                                            .text;
                                                                  });
                                                                }
                                                                // updateQuantityInDatabase(
                                                                //     item);

                                                                // setState(() {
                                                                //   if (_qty ==
                                                                //       0) {
                                                                //     counter++;
                                                                //     _quntitycontroller
                                                                //             .text =
                                                                //         counter
                                                                //             .toString();
                                                                //     _qty =
                                                                //         _quntitycontroller
                                                                //             .text;
                                                                //   } else {
                                                                //     counter = int
                                                                //         .parse(
                                                                //             _qty);
                                                                //     counter++;
                                                                //     _quntitycontroller
                                                                //             .text =
                                                                //         counter
                                                                //             .toString();
                                                                //     _qty =
                                                                //         _quntitycontroller
                                                                //             .text;
                                                                //   }
                                                                // });
                                                              })
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: FlatButton(
                              // height: ,
                              minWidth: MediaQuery.of(context).size.width / 3,
                              padding: EdgeInsets.all(10),
                              shape: (RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                //side: BorderSide(color: Colors.red)
                              )),
                              textColor: Colors.white,
                              color: MyColors.themecolor,

                              onPressed: () {
                                _qty = _quntitycontroller.text.toString();

                                //  updateQuantityInDatabase(_qty);
                                if (_qty == 0 || _qty == null) {
                                  Fluttertoast.showToast(
                                      msg: "Enter Quantity..",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.SNACKBAR,
                                      timeInSecForIosWeb: 10,
                                      backgroundColor: MyColors.themecolor,
                                      textColor: MyColors.textcolor,
                                      fontSize: 12.0);
                                } else {
                                  showOrderConfirm(context);
                                }
                              },
                              child: Text(
                                'Order',
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
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void updateQuantityInDatabase(Latest_Product_model item) {
    FirebaseFirestore.instance
        .collection('list')
        .doc(item.id)
        .set({'quantity': item.quntity}).then((value) {
      print('Quantity updated successfully');
    }).catchError((error) {
      print('Failed to update quantity: $error');
    });
  }

  showOrderConfirm(BuildContext context) {
    // set up the buttons
    Widget okButton = FlatButton(
      // height: ,
      minWidth: MediaQuery.of(context).size.width / 5,
      padding: EdgeInsets.all(10),
      shape: (RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        //side: BorderSide(color: Colors.red)
      )),
      textColor: Colors.white,
      color: MyColors.themecolor,
      onPressed: () {
        //postingList();
        onLoginButtonClick();
        //showOrderplaced(context);
        // Navigator.of(context).pop();
      },
      child: Text(
        'YES',
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Poppins-Semibold",
          fontSize: 14,
        ),
      ),
    );
    Widget cancelButton = FlatButton(
      // height: ,
      minWidth: MediaQuery.of(context).size.width / 5,
      padding: EdgeInsets.all(10),
      shape: (RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        //side: BorderSide(color: Colors.red)
      )),
      textColor: Colors.white,
      color: Colors.grey,
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(
        'NO',
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Poppins-Semibold",
          fontSize: 14,
        ),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Container(
        height: 50,
        child: Column(
          children: [
            Text(
              "Do you want ",
              style: TextStyle(
                fontFamily: "Poppins-semibold",
                fontSize: 14,
              ),
            ),
            Text(
              "confirm your order?",
              style: TextStyle(
                fontFamily: "Poppins-semibold",
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
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

  showOrderplaced(BuildContext context) {
    // set up the buttons
    Widget okButton = FlatButton(
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
        setState(() {
          cart.clear();
        });

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Homepage(
                  cart: cart,
                )));
      },
      child: Text(
        'OKAY',
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Poppins-Semibold",
          fontSize: 14,
        ),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Icon(
        Icons.check_circle_outline,
        color: Colors.green,
        size: 80,
      ),
      content: Container(
        height: 30,
        child: Center(
          child: Text(
            "Your Order has been placed.",
            style: TextStyle(
              fontFamily: "Poppins-semibold",
              fontSize: 14,
            ),
          ),
        ),
      ),
      actions: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Center(child: okButton),
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

  showOrdernotplaced(BuildContext context) {
    // set up the buttons
    Widget okButton = FlatButton(
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
        setState(() {
          cart.clear();
        });

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Homepage(
                  cart: cart,
                )));
      },
      child: Text(
        'OKAY',
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Poppins-Semibold",
          fontSize: 14,
        ),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Icon(
        Icons.cancel_outlined,
        color: Colors.red,
        size: 80,
      ),
      content: Container(
        height: 30,
        child: Center(
          child: Text(
            "Your Order not placed.",
            style: TextStyle(
              fontFamily: "Poppins-semibold",
              fontSize: 14,
            ),
          ),
        ),
      ),
      actions: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Center(child: okButton),
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

  void onLoginButtonClick() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('form is valid');

      for (int i = 0; i < cart.length; i++) {
        var orderItems = Order(productId: cart[i].id, qunt: cart[i].quntity);

        orderData.add(orderItems);
      }

      triggerNotification() {
        for (int i = 0; i < cart.length; i++) {
          AwesomeNotifications().createNotification(
              content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: '${cart[i].name} order placed....',
            body: '${cart[i].composition} order placed....',
          ));
        }
      }

      orderDetail.orderDate = dateStr;
      orderDetail.userId = userDetails.id;
      orderDetail.status = '1';

      // notify = notifylist;
      SessionManager().addNotifications(notify);
      var isInternetConnected = await InternetUtil.isInternetConnected();

      if (isInternetConnected) {
        // Fluttertoast.showToast(
        //     msg: "Server Unavailable...Please Try again later..!!!",
        //     toastLength: Toast.LENGTH_LONG,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 10,
        //     backgroundColor: MyColors.themecolor,
        //     textColor: MyColors.textcolor,
        //     fontSize: 12.0);
        try {
          var response = await Order_repo.orderRepo(
            orderDetail.orderDate,
            orderDetail.userId,
            orderDetail.status,
            orderData,
          );
         // ProgressDialog.showProgressDialog(context);
          print(response.data);

          if (response.status == 201) {
            // Fluttertoast.showToast(
            //     msg: "Your order has been placed.",
            //     toastLength: Toast.LENGTH_LONG,
            //     gravity: ToastGravity.CENTER,
            //     timeInSecForIosWeb: 10,
            //     backgroundColor: MyColors.themecolor,
            //     textColor: MyColors.textcolor,
            //     fontSize: 12.0);
            showOrderplaced(context);
            triggerNotification();
          } else {
            if (response.status == 422) {
              Fluttertoast.showToast(
                  msg: response.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 10,
                  backgroundColor: MyColors.themecolor,
                  textColor: MyColors.textcolor,
                  fontSize: 12.0);
            } else {}

            // Fluttertoast.showToast(
            //     msg: "Order Not Palced",
            //     toastLength: Toast.LENGTH_LONG,
            //     gravity: ToastGravity.CENTER,
            //     timeInSecForIosWeb: 10,
            //     backgroundColor: MyColors.themecolor,
            //     textColor: MyColors.textcolor,
            //     fontSize: 12.0);
            Navigator.pop(context);
            SessionManager().addNotifications(notify);
            showOrdernotplaced(context);
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
    } else {
      setState(() {});
    }
  }

  void _goToHomePage(List<order_Model> user) {
    SessionManager().addNotifications(user);
    orderDetailS = user;

//    Navigator.pushReplacement(context,
//        MaterialPageRoute(
//            builder: (context) => HomePage(title: 'Habib Store')));
  }
}
