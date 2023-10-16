import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prism_medico/Screens/cart.dart';
import 'package:prism_medico/Screens/order_History.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Screens/profile.dart';
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/model/latestProduct.dart';
import 'package:prism_medico/Screens/notification.dart';
import 'package:prism_medico/Repo/productRepo.dart';
import 'package:prism_medico/utills/Super_Responce.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prism_medico/utills/Constant.dart';
import 'package:prism_medico/utills/Session_Manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductDetail extends StatefulWidget {
  final Latest_Product_model productDetail;
  final List<Latest_Product_model> cart;
  final bool commingfromHome;
  final productId;
  final productName;

  ProductDetail(
      {Key key,
      this.productDetail,
      this.productId,
      this.productName,
      this.cart,
      this.commingfromHome})
      : super(key: key);
  _ProductDetailState createState() => _ProductDetailState(this.cart);
}

class _ProductDetailState extends State<ProductDetail> {
  _ProductDetailState(this.cart);
  List<Latest_Product_model> cart;
  // List<Latest_Product_model> _product = List<Latest_Product_model>();
  var items;
  var _qty;
  int counter = 0;
  var quntity;
  TextEditingController _quntitycontroller;

  @override
  void initState() {
    super.initState();
    setState(() {
      cart.length;
      //  widget.productDetail.quntity = 0;
      _quntitycontroller = TextEditingController();
      if (widget.commingfromHome == true) {
        if (widget.productDetail.quntity == null) {
          _qty = 0;
        } else {
          _qty = widget.productDetail.quntity;
        }
      } else {
        _qty = 1;
      }
      quntity = new TextEditingController(text: counter.toString());
    });
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
    // setState(() {
    //   getProductDetailRepo.getProductDetail(widget.productId).then((value) {
    //     items = value.data;

    //     print(items.name);
    //     print(items.quntity);
    //   });
    // });
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _quntitycontroller.clear();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(cart);
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
                              widget.productName,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    Notificationscreen(cart: cart),
                              ),
                            );
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
          height: MediaQuery.of(context).size.height / 1,
          child: Form(
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              color: Colors.white,
              // height: MediaQuery.of(context).size.height ,
              child: FutureBuilder(
                future: getProductDetailRepo
                    .getProductDetail(widget.productDetail.id),
                builder: (context,
                    AsyncSnapshot<SuperResponse<Latest_Product_model>> snap) {
                  if (snap.hasData) {
                    var list = snap.data.data;

                    return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        list.quntity = 0;
                        return Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              height: 200,
                              child: CarouselSlider.builder(
                                itemCount:
                                    widget.productDetail.productImage.length,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                itemBuilder:
                                    (BuildContext context, int itemIndex) =>
                                        Container(
                                  child: Image.network(
                                      'https://prismapp.in/prism/${widget.productDetail.productImage[itemIndex]}'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Container(
                            //     width: MediaQuery.of(context).size.width,
                            //     child: Image.asset(
                            //         "assets/images/productImage.png")),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 200,
                                  child: Text(
                                    widget.productDetail.name,
                                    softWrap: true,
                                    style: TextStyle(
                                        fontFamily: "Poppins-semibold",
                                        fontSize: 18,
                                        color: MyColors.textcolor),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.grey.shade300),
                                  child: widget.commingfromHome == true
                                      ? Row(
                                          children: [
                                            IconButton(
                                                icon: Icon(
                                                  Icons.remove,
                                                  color: MyColors.textcolor,
                                                ),
                                                onPressed: () {
                                                  counter = int.parse(
                                                      _quntitycontroller.text);
                                                  setState(() {
                                                    if (counter > 0) {
                                                      counter--;
                                                      _quntitycontroller.text =
                                                          counter.toString();
                                                      _qty = _quntitycontroller
                                                          .text;
                                                    }
                                                  });
                                                }),
                                            widget.productDetail.quntity == null
                                                // ? Text("0")
                                                // : Text(widget
                                                //     .productDetail.quntity
                                                //     .toString()),
                                                ? Container(
                                                    width: 30,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller:
                                                          _quntitycontroller
                                                            ..text = "$_qty",
                                                      onSaved:
                                                          (String newValue) {
                                                        setState(() {
                                                          _qty = newValue;
                                                          _qty =
                                                              _quntitycontroller
                                                                  .text
                                                                  .toString();
                                                          counter = _qty;
                                                          widget.productDetail
                                                                  .quntity =
                                                              int.parse(_qty);
                                                          updateQuantityInDatabase(
                                                              widget
                                                                  .productDetail);
                                                        });
                                                      },
                                                      onChanged: (value) {
                                                        setState(() {
                                                          widget.productDetail
                                                              .quntity = value;
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
                                                    width: 40,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller:
                                                          _quntitycontroller
                                                            ..text = "$_qty",
                                                      onSaved:
                                                          (String newValue) {
                                                        setState(() {
                                                          _qty = newValue;
                                                          _qty =
                                                              _quntitycontroller
                                                                  .text
                                                                  .toString();

                                                          widget.productDetail
                                                                  .quntity =
                                                              int.parse(_qty);
                                                          updateQuantityInDatabase(
                                                              widget
                                                                  .productDetail);
                                                          updateQuantityInDatabase(
                                                              widget
                                                                  .productDetail);
                                                        });
                                                      },
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _qty =
                                                              _quntitycontroller
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
                                                  color: MyColors.textcolor,
                                                ),
                                                onPressed: () {
                                                  // if (widget.productDetail
                                                  //         .quntity ==
                                                  //     null)
                                                  //   widget.productDetail
                                                  //       .quntity = 0;
                                                  counter = int.parse(
                                                      _quntitycontroller.text);
                                                  setState(() {
                                                    if (_qty == 0) {
                                                      counter++;
                                                      _quntitycontroller.text =
                                                          counter.toString();
                                                      _qty = _quntitycontroller
                                                          .text;
                                                    } else {
                                                      counter = int.parse(_qty);
                                                      counter++;
                                                      _quntitycontroller.text =
                                                          counter.toString();
                                                      _qty = _quntitycontroller
                                                          .text;
                                                    }
                                                  });
                                                  // updateQuantityInDatabase(
                                                  //     widget.productDetail
                                                  //         .quntity);
                                                })
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            IconButton(
                                                icon: Icon(
                                                  Icons.remove,
                                                  color: MyColors.textcolor,
                                                ),
                                                onPressed: () {
                                                  counter = int.parse(
                                                      _quntitycontroller.text);
                                                  setState(() {
                                                    if (counter > 0) {
                                                      counter--;
                                                      _quntitycontroller.text =
                                                          counter.toString();
                                                    }
                                                  });
                                                }),
                                            widget.productDetail.quntity == null
                                                //     ? Text("0")
                                                //     : Text(cart[index]
                                                //         .quntity
                                                //         .toString()),
                                                ? Container(
                                                    width: 30,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller:
                                                          _quntitycontroller
                                                            ..text = "$_qty",
                                                      onSaved:
                                                          (String newValue) {
                                                        setState(() {
                                                          _qty = newValue;
                                                          // _qty =
                                                          //     _quntitycontroller
                                                          //         .text
                                                          //         .toString();
                                                          // counter = _qty;
                                                          // widget.productDetail
                                                          //         .quntity =
                                                          //     int.parse(_qty);
                                                          // updateQuantityInDatabase(
                                                          //     widget
                                                          //         .productDetail);
                                                        });
                                                      },
                                                      onChanged: (value) {
                                                        setState(() {
                                                          widget.productDetail
                                                              .quntity = value;
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
                                                    width: 40,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller:
                                                          _quntitycontroller
                                                            ..text = '$_qty',
                                                      onSaved:
                                                          (String newValue) {
                                                        setState(() {
                                                          _qty = newValue;
                                                          //_qty =
                                                          //     _quntitycontroller
                                                          //         .text
                                                          //         .toString();

                                                          // widget.productDetail
                                                          //         .quntity =
                                                          //     int.parse(_qty);
                                                          // updateQuantityInDatabase(
                                                          //     widget
                                                          //         .productDetail);
                                                          // updateQuantityInDatabase(
                                                          //     widget
                                                          //         .productDetail);
                                                        });
                                                      },
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _qty =
                                                              _quntitycontroller
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
                                                  color: MyColors.textcolor,
                                                ),
                                                onPressed: () {
                                                  counter = int.parse(
                                                      _quntitycontroller.text);
                                                  setState(() {
                                                    if (_qty == 0) {
                                                      counter++;
                                                      _quntitycontroller.text =
                                                          counter.toString();
                                                      _qty = _quntitycontroller
                                                          .text;
                                                    } else {
                                                      counter = int.parse(_qty);
                                                      counter++;
                                                      _quntitycontroller.text =
                                                          counter.toString();
                                                      _qty = _quntitycontroller
                                                          .text;
                                                    }
                                                  });
                                                })
                                          ],
                                        ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.8,
                                  child: Text(
                                    list.composition,
                                    style: TextStyle(
                                        fontFamily: "Poppins-REGULAR",
                                        fontSize: 12,
                                        color: Colors.grey),
                                  ),
                                ),
                                widget.productDetail.stock == '0'
                                    ? Text(
                                        "Out of Stock",
                                        style: TextStyle(
                                            fontFamily: "Poppins-semibold",
                                            fontSize: 12,
                                            color: Colors.red),
                                      )
                                    : Text(
                                        "Available in Stock",
                                        style: TextStyle(
                                            fontFamily: "Poppins-semibold",
                                            fontSize: 12,
                                            color: MyColors.textcolor),
                                      ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 80),
                            FlatButton(
                              height: 45,
                              minWidth: MediaQuery.of(context).size.width / 1.5,
                              padding: EdgeInsets.all(10),
                              shape: (RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                //side: BorderSide(color: Colors.red)
                              )),
                              textColor: Colors.white,
                              color: MyColors.themecolor,
                              onPressed: () {
                                _qty = _quntitycontroller.text.toString();

                                widget.productDetail.quntity = int.parse(_qty);
                                updateQuantityInDatabase(widget.productDetail);
                                if (cart.length != 0) {
                                  if (cart[index].id.contains(list.id)) {
                                    if (widget.productDetail.quntity == 0 ||
                                        widget.productDetail.quntity == null) {
                                      Fluttertoast.showToast(
                                          msg: "Enter Quntity",
                                          gravity: ToastGravity.CENTER,
                                          backgroundColor: Colors.lightBlue,
                                          textColor: MyColors.textcolor,
                                          toastLength: Toast.LENGTH_LONG);
                                    } else {
                                      setState(() {
                                        cart[cart.indexWhere((element) =>
                                                element.id == cart[index].id)] =
                                            cart[index];
                                      });
                                      Fluttertoast.showToast(
                                          msg:
                                              "${list.name} updated into cart...",
                                          gravity: ToastGravity.CENTER,
                                          backgroundColor: Colors.lightBlue,
                                          textColor: MyColors.textcolor,
                                          toastLength: Toast.LENGTH_LONG);
                                    }
                                  } else {
                                    setState(() {
                                      cart.add(widget.productDetail);
                                      SessionManager.saveCartObject(cart);
                                    });
                                    Fluttertoast.showToast(
                                        msg: "${list.name} add into cart...",
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Colors.lightBlue,
                                        textColor: MyColors.textcolor,
                                        toastLength: Toast.LENGTH_LONG);
                                  }
                                } else if (widget.productDetail.quntity == 0 ||
                                    widget.productDetail.quntity == null) {
                                  Fluttertoast.showToast(
                                      msg: "Enter Quntity",
                                      gravity: ToastGravity.CENTER,
                                      backgroundColor: Colors.lightBlue,
                                      textColor: MyColors.textcolor,
                                      toastLength: Toast.LENGTH_LONG);
                                } else {
                                  setState(() {
                                    cart.add(widget.productDetail);
                                    SessionManager.saveCartObject(cart);
                                  });
                                  Fluttertoast.showToast(
                                      msg: "${list.name} added into cart...",
                                      gravity: ToastGravity.CENTER,
                                      backgroundColor: Colors.lightBlue,
                                      textColor: MyColors.textcolor,
                                      toastLength: Toast.LENGTH_LONG);
                                }
                              },
                              child: Center(
                                child: Text(
                                  'Add to cart',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins-Semibold",
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Product Description",
                                style: TextStyle(
                                    fontFamily: "Poppins-semibold",
                                    fontSize: 18,
                                    color: MyColors.textcolor),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              //  height: MediaQuery.of(context).size.height,
                              child: Text(
                                widget.productDetail.productDetail,
                                style: TextStyle(
                                    fontFamily: "Poppins-regular",
                                    color: Colors.grey,
                                    fontSize: 12),
                                softWrap: true,
                                //overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  if (snap.hasError) {
                    return Center(
                      child: Container(
                        height: 150,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/No-Product-Available.jpg",
                              height: 100,
                            ),
                            Text(
                              "No Product Detail Available...",
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
            ),
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

  // void _goCartPage(Latest_Product_model product) {
  //   SessionManager.saveProductListObject(product);
  //   productDetail = product;

  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => Cart()));
  // }
}
