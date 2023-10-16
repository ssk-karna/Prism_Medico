import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prism_medico/Repo/getOrderDetail.dart';
import 'package:prism_medico/Repo/getOrderDetailByID.dart';
import 'package:prism_medico/Screens/cart.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Screens/order_History.dart';
import 'package:prism_medico/Screens/order_detail.dart';
import 'package:prism_medico/Screens/profile.dart';
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/model/latestProduct.dart';
import 'package:prism_medico/model/order_Model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prism_medico/utills/Constant.dart';
import 'package:prism_medico/utills/Session_Manager.dart';
import 'package:prism_medico/utills/Super_Responce.dart';

class Notificationscreen extends StatefulWidget {
  final List<Latest_Product_model> cart;
  final List<order_Model> notify;
  Notificationscreen({this.cart, this.notify});
  _NotificationState createState() =>
      _NotificationState(this.cart, this.notify);
}

class _NotificationState extends State<Notificationscreen> {
  _NotificationState(this.cart, this.notify);
  List<Latest_Product_model> cart;
  List<order_Model> notify;
  int total;
  String orderId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SessionManager.getUser().then((value) {
      setState(() {
        userDetails = value;
      });
    });
    // getorderListRepo.getOrderList(userDetails.id).then((value) {
    //   for (int i = 0; i < value.data.length; i++) {
    //     setState(() {
    //       orderId = value.data[i].id;
    //     });
    //   }
    // });
    // getorderDetailRepo.getOrderDetail(orderId).then((value) {
    //   for (int i = 0; i < value.data.length; i++) {
    //     setState(() {
    //       total = total + int.parse(value.data[i].quntity);
    //     });
    //   }
    // });
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
                            "Notifications",
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
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => Notificationscreen(
                          //           cart: cart,
                          //         )));
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
                            "No Notification Available...",
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
                                  Icons.circle,
                                  size: 15,
                                  color: item.status_Id == "1"
                                      ? Colors.red
                                      : Colors.green,
                                ),
                                // trailing: InkWell(
                                //   child:
                                //       Image.asset("assets/images/forward.png"),
                                // ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            item.status_Id == "1"
                                                ? Text(
                                                    "Order has been placed...",
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Poppins-Semibold",
                                                        fontSize: 12,
                                                        color: Colors
                                                            .grey.shade700),
                                                  )
                                                : Text(
                                                    "Order has been Dispatched...",
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Poppins-Semibold",
                                                        fontSize: 12,
                                                        color: Colors
                                                            .grey.shade700),
                                                  )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Read More...",
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontFamily:
                                                      "Poppins-Semibold",
                                                  fontSize: 9,
                                                  color: Colors.grey.shade700),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Text(
                                      item.orderDate,
                                      softWrap: true,
                                      style: TextStyle(
                                          fontFamily: "Poppins-Semibold",
                                          fontSize: 10,
                                          color: Colors.grey.shade700),
                                    ),
                                  ],
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

class NotificationsModel {
  String notificationTitle;
  String notificationText;
  String notificationDate;
  String notificationTime;
  bool isNotificationRead;
  NotificationsModel({
    this.notificationTitle,
    this.notificationText,
    this.notificationDate,
    this.notificationTime,
    this.isNotificationRead,
  });
  Map<String, dynamic> toJson() {
    return {
      'notificationTitle': this.notificationTitle,
      'notificationText': this.notificationText,
      'notificationDate': this.notificationDate,
      'notificationTime': this.notificationTime,
      'isNotificationRead': this.isNotificationRead,
    };
  }

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
        notificationDate: json['notificationDate'],
        notificationText: json['notificationText'],
        notificationTitle: json['notificationTitle'] != null
            ? json['notificationTitle']
            : "New Notification",
        notificationTime: json['notificationTime'],
        isNotificationRead: json['isNotificationRead']);
  }
}
