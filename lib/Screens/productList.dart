import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prism_medico/Screens/cart.dart';
import 'package:prism_medico/Screens/productDetail.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Screens/notification.dart';
import 'package:prism_medico/Screens/order_History.dart';
import 'package:prism_medico/Screens/profile.dart';
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/model/latestProduct.dart';
import 'package:prism_medico/Repo/getCategoryProduct.dart';
import 'package:prism_medico/utills/Session_Manager.dart';
import 'package:prism_medico/utills/Super_Responce.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductList extends StatefulWidget {
  final latest_product_model;
  final counter;
  final user;
  final List<Latest_Product_model> cart;
  final catName;

  ProductList(
      {Key key,
      this.user,
      this.latest_product_model,
      this.catName,
      this.cart,
      this.counter})
      : super(key: key);
  _ProductListState createState() => _ProductListState(this.cart);
}

class _ProductListState extends State<ProductList> {
  bool stockavailable = true;
  int counter = 0;
  var list;
  List items;
  String search;
  _ProductListState(this.cart);
  List<Latest_Product_model> cart;

  List suggestionList = [];
  TextEditingController _textController = TextEditingController();
  List<String> productName = [];
  List<String> productDetail = [];
  List<String> productSTock = [];
  List<int> productQuntity = [];
  List<String> productID = [];

  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
    //  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: false);

    getCategoryProductListRepo
        .getCatgorieProduct(widget.latest_product_model)
        .then((value) {
      for (int i = 0; i < value.data.length; i++) {
        items = value.data;
        var list = Latest_Product_model(name: value.data[i].name);
        var _ID = Latest_Product_model(id: value.data[i].id);
        var _detail =
            Latest_Product_model(composition: value.data[i].composition);
        var _stock = Latest_Product_model(stock: value.data[i].stock);
        var _quntity = Latest_Product_model(quntity: value.data[i].quntity);

        productID.add(_ID.id);
        productName.add(list.name);
        productDetail.add(_detail.composition);
        productSTock.add(_stock.stock);
        productQuntity.add(_quntity.quntity);
      }
    });
    setState(() {
      cart.length;
    });
  }

  void typeAheadFilter(String value) {
    suggestionList.clear();

    if (value.isEmpty) {
      setState(() {});
      return;
    }

    for (String n in productName) {
      if (n.toLowerCase().contains(value)) {
        suggestionList.add(n);
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          cart.length;
        });
        Navigator.of(context).pop();
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
                  Expanded(
                    child: Container(
                      // width: MediaQuery.of(context).size.width / 1,
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.catName,
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
                    // width: MediaQuery.of(context).size.width / 6,
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
          height: 60,
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
        body: SingleChildScrollView(
            child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Form(
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height / 1.3,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                      controller: _textController,
                      onSaved: (newValue) {
                        search = newValue;
                      },
                      onFieldSubmitted: (value) {
                        search = value;
                      },
                      onTap: () {},
                      onChanged: (value) {
                        typeAheadFilter(value);
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
                if (suggestionList.isNotEmpty ||
                    _textController.text.isNotEmpty) ...[
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(5),
                      shrinkWrap: true,
                      itemCount: suggestionList.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(2),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 15,
                                child: Image.network(
                                    'https://prismapp.in/prism/${items[index].productImage[0]}'),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              InkWell(
                                child: Container(
                                  // color: Colors.yellow,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              suggestionList[index],
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontFamily:
                                                      "Poppins-Semibold",
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            child: Text(
                                              productDetail[index],
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontFamily: "Poppins-regular",
                                                  fontSize: 10,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
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
                                                        color:
                                                            MyColors.textcolor),
                                                  ),
                                                  productSTock[index] != "0"
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
                                            Container(
                                              height: 30,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.5 /
                                                  2.3,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.grey.shade300),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  IconButton(
                                                      icon: Icon(
                                                        Icons.remove,
                                                        color:
                                                            MyColors.textcolor,
                                                        size: 15,
                                                      ),
                                                      onPressed: () {
                                                        {
                                                          setState(() {
                                                            if (items[index]
                                                                    .quntity >
                                                                0) {
                                                              items[index]
                                                                  .quntity--;
                                                            }
                                                          });
                                                          updateQuantityInDatabase(
                                                              items[index]);
                                                        }
                                                      }),
                                                  Container(
                                                      width: 10,
                                                      child: items[index]
                                                                  .quntity ==
                                                              null
                                                          ? Text(
                                                              '0',
                                                              style: TextStyle(
                                                                  color: MyColors
                                                                      .textcolor,
                                                                  fontFamily:
                                                                      "Poppins-regular"),
                                                            )
                                                          : Text(
                                                              '${items[index].quntity}',
                                                              style: TextStyle(
                                                                  color: MyColors
                                                                      .textcolor,
                                                                  fontFamily:
                                                                      "Poppins-regular"),
                                                            )),
                                                  IconButton(
                                                      icon: Icon(
                                                        Icons.add,
                                                        color:
                                                            MyColors.textcolor,
                                                        size: 15,
                                                      ),
                                                      onPressed: () {
                                                        if (items[index]
                                                                .quntity ==
                                                            null)
                                                          items[index].quntity =
                                                              0;
                                                        setState(() {
                                                          items[index]
                                                              .quntity++;
                                                        });
                                                        updateQuantityInDatabase(
                                                            items[index]);
                                                      })
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (cart.length != 0) {
                                                  if (cart.contains(
                                                      items[index].id)) {
                                                    setState(() {
                                                      cart[cart.indexWhere(
                                                              (element) =>
                                                                  element.id ==
                                                                  cart[index]
                                                                      .id)] =
                                                          cart[index];
                                                    });
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "${items[index].name} updated into cart...",
                                                        gravity:
                                                            ToastGravity.CENTER,
                                                        backgroundColor:
                                                            Colors.lightBlue,
                                                        textColor:
                                                            MyColors.textcolor,
                                                        toastLength:
                                                            Toast.LENGTH_LONG);
                                                  } else {
                                                    if (items[index].quntity ==
                                                            null ||
                                                        items[index].quntity ==
                                                            0) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Enter Quntity...",
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          backgroundColor:
                                                              Colors.lightBlue,
                                                          textColor: MyColors
                                                              .textcolor,
                                                          toastLength: Toast
                                                              .LENGTH_LONG);
                                                    } else {
                                                      setState(() {
                                                        cart.add(items[index]);
                                                        cart.length;
                                                        SessionManager
                                                            .saveCartObject(
                                                                cart);
                                                      });
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "${items[index].name} added into cart...",
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          backgroundColor:
                                                              Colors.lightBlue,
                                                          textColor: MyColors
                                                              .textcolor,
                                                          toastLength: Toast
                                                              .LENGTH_LONG);
                                                    }
                                                  }
                                                  // Navigator.of(context).push(
                                                  //     MaterialPageRoute(
                                                  //         builder:
                                                  //             (context) =>
                                                  //                 Cart(
                                                  //                   cart: [
                                                  //                     e
                                                  //                   ],
                                                  //                 )));
                                                } else {
                                                  setState(() {
                                                    cart.add(cart[index]);
                                                    SessionManager
                                                        .saveCartObject(cart);
                                                  });
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "${list.name} added into cart...",
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      backgroundColor:
                                                          Colors.lightBlue,
                                                      textColor:
                                                          MyColors.textcolor,
                                                      toastLength:
                                                          Toast.LENGTH_LONG);
                                                }
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.5 /
                                                    4,
                                                decoration: BoxDecoration(
                                                    color: MyColors.themecolor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Center(
                                                    child: Text(
                                                      "ADD",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Poppins-semibold",
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) => ProductDetail(
                                                productId: productID[index],
                                                productName:
                                                    suggestionList[index],
                                                cart: cart,
                                                productDetail: list,
                                                commingfromHome: false,
                                              )))
                                      .then((value) {
                                    setState(() {
                                      cart.length;
                                    });
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ] else ...[
                  Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: FutureBuilder(
                      future: getCategoryProductListRepo
                          .getCatgorieProduct(widget.latest_product_model),
                      builder: (BuildContext context,
                          AsyncSnapshot<
                                  SuperResponse<List<Latest_Product_model>>>
                              snap) {
                        if (snap.hasData) {
                          List list = snap.data.data;

                          if (list.length != 0 || list.isNotEmpty) {
                            return ListView.separated(
                                itemCount: list.length,
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                                itemBuilder: (BuildContext context, int index) {
                                  var item = list[index];

                                  return Container(
                                    margin: EdgeInsets.all(5),
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                15,
                                            child: Image.network(
                                                'https://prismapp.in/prism/${items[index].productImage[0]}'),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductDetail(
                                                            productId: item.id,
                                                            productName:
                                                                item.name,
                                                            cart: cart,
                                                            productDetail:
                                                                items[index],
                                                            commingfromHome:
                                                                true,
                                                          )))
                                                  .then((value) {
                                                setState(() {
                                                  cart.length;
                                                });
                                              });
                                            },
                                            child: Container(
                                              //color: Colors.yellow,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.5,
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
                                                        child: Container(
                                                          // width: MediaQuery.of(
                                                          //             context)
                                                          //         .size
                                                          //         .width /
                                                          //     1.4,
                                                          child: Text(
                                                            items[index].name,
                                                            softWrap: true,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins-Semibold",
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          items[index]
                                                              .composition,
                                                          softWrap: true,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Poppins-regular",
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
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
                                                                    fontSize:
                                                                        12,
                                                                    color: MyColors
                                                                        .textcolor),
                                                              ),
                                                              item.stock != "0"
                                                                  ? Icon(
                                                                      Icons
                                                                          .check_circle,
                                                                      color: Colors
                                                                          .green,
                                                                      size: 20,
                                                                    )
                                                                  : Icon(
                                                                      Icons
                                                                          .cancel,
                                                                      color: Colors
                                                                          .red,
                                                                      size: 20,
                                                                    ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 30,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              1.5 /
                                                              2.3,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: Colors.grey
                                                                  .shade300),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons
                                                                        .remove,
                                                                    color: MyColors
                                                                        .textcolor,
                                                                    size: 15,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    {
                                                                      setState(
                                                                          () {
                                                                        if (items[index].quntity >
                                                                            0) {
                                                                          items[index]
                                                                              .quntity--;
                                                                        }
                                                                      });
                                                                      updateQuantityInDatabase(
                                                                          items[
                                                                              index]);
                                                                    }
                                                                  }),
                                                              Container(
                                                                  width: 10,
                                                                  child: items[index]
                                                                              .quntity ==
                                                                          null
                                                                      ? Text(
                                                                          '0',
                                                                          style: TextStyle(
                                                                              color: MyColors.textcolor,
                                                                              fontFamily: "Poppins-regular"),
                                                                        )
                                                                      : Text(
                                                                          '${items[index].quntity}',
                                                                          style: TextStyle(
                                                                              color: MyColors.textcolor,
                                                                              fontFamily: "Poppins-regular"),
                                                                        )),
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.add,
                                                                    color: MyColors
                                                                        .textcolor,
                                                                    size: 15,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    if (items[index]
                                                                            .quntity ==
                                                                        null)
                                                                      items[index]
                                                                          .quntity = 0;
                                                                    setState(
                                                                        () {
                                                                      items[index]
                                                                          .quntity++;
                                                                    });
                                                                    updateQuantityInDatabase(
                                                                        items[
                                                                            index]);
                                                                  })
                                                            ],
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            if (cart.contains(
                                                                items[index]
                                                                    .id)) {
                                                              setState(() {
                                                                cart[cart.indexWhere(
                                                                    (element) =>
                                                                        element
                                                                            .id ==
                                                                        cart[index]
                                                                            .id)] = cart[
                                                                    index];
                                                              });
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                      "${items[index].name} updated into cart...",
                                                                  gravity:
                                                                      ToastGravity
                                                                          .CENTER,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .lightBlue,
                                                                  textColor:
                                                                      MyColors
                                                                          .textcolor,
                                                                  toastLength: Toast
                                                                      .LENGTH_LONG);
                                                            } else {
                                                              if (items[index]
                                                                          .quntity ==
                                                                      null ||
                                                                  items[index]
                                                                          .quntity ==
                                                                      0) {
                                                                Fluttertoast.showToast(
                                                                    msg:
                                                                        "Enter Quantity",
                                                                    gravity:
                                                                        ToastGravity
                                                                            .SNACKBAR,
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
                                                                setState(() {
                                                                  cart.add(items[
                                                                      index]);
                                                                  SessionManager
                                                                      .saveCartObject(
                                                                          cart);
                                                                });
                                                                Fluttertoast.showToast(
                                                                    msg:
                                                                        "${items[index].name} added into cart...",
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
                                                              }
                                                            }

                                                            // Navigator.of(context).push(
                                                            //     MaterialPageRoute(
                                                            //         builder:
                                                            //             (context) =>
                                                            //                 Cart(
                                                            //                   cart: [
                                                            //                     e
                                                            //                   ],
                                                            //                 )));
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                1.5 /
                                                                4,
                                                            decoration: BoxDecoration(
                                                                color: MyColors
                                                                    .themecolor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: Center(
                                                                child: Text(
                                                                  "ADD",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins-semibold",
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
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
                                    ),
                                  );
                                });
                          } else {
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
                          }
                        } else {
                          return Center(
                            child: Container(
                              height: 150,
                              child: Column(
                                children: [
                                  Text(
                                    "Loading...",
                                    style: TextStyle(
                                        fontFamily: "Poppins-semibold",
                                        fontSize: 12,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ]),
            ),
          ),
        )),
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

  Widget addmore(var add) {
    add = 0;
    return Row(
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              add--;
            });
          },
          icon: Icon(Icons.remove),
        ),
        Container(
          height: 18,
          width: 25,
          child: Center(child: Text(add.toString())),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              add++;
            });
          },
          icon: Icon(Icons.add),
        )
      ],
    );
  }
}
