import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:prism_medico/Screens/cart.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Screens/notification.dart';
import 'package:prism_medico/Screens/order_History.dart';
import 'package:prism_medico/Screens/profile.dart';
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/model/latestProduct.dart';
import 'package:prism_medico/model/orderByID.dart';
import 'package:prism_medico/model/order_Model.dart';
import 'package:prism_medico/Repo/getOrderDetailByID.dart';
import 'package:prism_medico/utills/Super_Responce.dart';

class OredrDetail extends StatefulWidget {
  final order_Model order_model;
  final List<Latest_Product_model> cart;

  OredrDetail({required this.order_model, required this.cart});
  _OrderDetailState createState() => _OrderDetailState(this.cart);
}

class _OrderDetailState extends State<OredrDetail> {
  _OrderDetailState(this.cart);
  List<Latest_Product_model> cart;
  var product_items;
  var total = 0;
  var sum;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getorderDetailRepo.getOrderDetail(widget.order_model.id).then((value) {
      for (int i = 0; i < value!.data.length; i++) {
        setState(() {
          total = total + int.parse(value.data[i].quntity);
        });
      }
    });
    setState(() {});
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
                            widget.order_model.orderDate,
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
        child: Container(
          color: Colors.white,
          child: FutureBuilder<SuperResponse<List<Products>>?>(
              future: getorderDetailRepo.getOrderDetail(widget.order_model.id),
              builder: (BuildContext context,
                  AsyncSnapshot<SuperResponse<List<Products>>?> snap) {
                if (snap.hasData) {
                  var list = snap.data!.data;
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 15,
                              color: widget.order_model.status_Id == '1'
                                  ? Colors.red
                                  : Colors.green,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Order Status = ",
                              style: TextStyle(
                                  fontFamily: "Poppins-semibold",
                                  color: MyColors.textcolor,
                                  fontSize: 12),
                            ),
                            widget.order_model.status_Id == '1'
                                ? Text(
                                    widget.order_model.status,
                                    style: TextStyle(
                                        fontFamily: "Poppins-semibold",
                                        color: MyColors.textcolor,
                                        fontSize: 12),
                                  )
                                : Text(
                                    widget.order_model.status,
                                    style: TextStyle(
                                        fontFamily: "Poppins-semibold",
                                        color: MyColors.textcolor,
                                        fontSize: 12),
                                  )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          // height: MediaQuery.of(context).size.height,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Ordered item",
                                    style: TextStyle(
                                        fontFamily: "Poppins-semibold",
                                        color: MyColors.textcolor,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    "Pcs",
                                    style: TextStyle(
                                        fontFamily: "Poppins-regular",
                                        color: MyColors.textcolor,
                                        fontSize: 15),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height / 2,
                                child: FutureBuilder<
                                    SuperResponse<List<Products>>?>(
                                    future: getorderDetailRepo
                                        .getOrderDetail(widget.order_model.id),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<
                                                SuperResponse<List<Products>>?>
                                            snap) {
                                      if (snap.hasData) {
                                        var list = snap.data!.data;

                                        return ListView(
                                          children: <Widget>[
                                            ...list.map((e) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${e.name}',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Poppins-regular",
                                                        color:
                                                            MyColors.textcolor,
                                                        fontSize: 13),
                                                  ),
                                                  Text(
                                                    '${e.quntity}',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Poppins-regular",
                                                        color:
                                                            MyColors.textcolor,
                                                        fontSize: 13),
                                                  )
                                                ],
                                              );
                                            }).toList()
                                          ],
                                        );
                                      } else {
                                        return Center(
                                          child: Container(
                                              height: 50,
                                              child:
                                                  CircularProgressIndicator()),
                                        );
                                      }
                                    }),
                              ),
                              Divider(color: Colors.grey),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                        fontFamily: "Poppins-semibold",
                                        color: MyColors.textcolor,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    '$total',
                                    style: TextStyle(
                                        fontFamily: "Poppins-semibold",
                                        color: MyColors.textcolor,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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
              }),
        ),
      ),
    );
  }
}
