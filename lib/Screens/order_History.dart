import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prism_medico/Screens/cart.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Screens/notification.dart';
import 'package:prism_medico/Screens/order_detail.dart';
import 'package:prism_medico/Screens/profile.dart';
import 'package:prism_medico/model/order_Model.dart';
import 'package:prism_medico/model/latestProduct.dart';
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/utills/Super_Responce.dart';
import 'package:prism_medico/utills/Session_Manager.dart';
import 'package:prism_medico/Repo/getOrderDetail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prism_medico/utills/Constant.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderHistory extends StatefulWidget {
  final List<Latest_Product_model> cart;
  OrderHistory({this.cart});

  _OrderHistoryState createState() => _OrderHistoryState(this.cart);
}

class _OrderHistoryState extends State<OrderHistory> {
  _OrderHistoryState(this.cart);
  List<Latest_Product_model> cart;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SessionManager.getUser().then((value) {
      setState(() {
        userDetails = value;
      });
    });
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
                            "Order History",
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
                  //   width: MediaQuery.of(context).size.width / 6,
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: FutureBuilder(
            future: getorderListRepo.getOrderList(userDetails.id),
            builder: (BuildContext context,
                AsyncSnapshot<SuperResponse<List<order_Model>>> snap) {
              if (snap.hasData) {
                var list = snap.data.data;

                if (list.isEmpty) {
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
                            "No Order Detail Available...",
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
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        var item = list[index];
                        return Container(
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.only(left: 10, right: 10),
                          // height: 60,
                          // width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey)),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OredrDetail(
                                              order_model: item,
                                              cart: cart,
                                            )));
                              },
                              child: ListTile(
                                leading: Icon(
                                  Icons.calendar_today,
                                  color: Colors.grey,
                                ),
                                trailing: InkWell(
                                  child:
                                      Image.asset("assets/images/forward.png"),
                                ),
                                title: Text(
                                  item.orderDate,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontFamily: "Poppins-Semibold",
                                      fontSize: 14,
                                      color: Colors.grey.shade700),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
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
                          "No Order Detail Available...",
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
    );
  }
}
