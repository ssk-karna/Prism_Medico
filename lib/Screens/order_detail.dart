import 'package:flutter/material.dart';
import 'package:prism_medico/Screens/cart.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Screens/notification.dart';
import 'package:prism_medico/Screens/order_History.dart';
import 'package:prism_medico/Screens/profile.dart';
import 'package:prism_medico/Utilities/myColor.dart';

class OredrDetail extends StatefulWidget {
  final orderdate;

  OredrDetail({this.orderdate});
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OredrDetail> {
  List<String> item = [
    "Prisvals-50",
    "Prisvals-100",
    "Prisvals-200",
    "Prisvals-50",
    "Prisvals-100",
    "Prisvals-20",
  ];

  List<String> pc = [
    "3",
    "4",
    "5",
    "10",
    "50",
    "20",
  ];
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
                Container(
                  // width: MediaQuery.of(context).size.width / 1,
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.orderdate,
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
                  width: MediaQuery.of(context).size.width / 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        child: Image.asset(
                          "assets/images/Notification.png",
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Notificationscreen()));
                        },
                      ),
                      InkWell(
                        child: Image.asset(
                          "assets/images/Cart.png",
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Cart()));
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
                  child: Image.asset(
                    "assets/images/Vector.png",
                  ),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Homepage()));
                  },
                ),
                InkWell(
                  child: Image.asset(
                    "assets/images/account.png",
                  ),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                ),
                InkWell(
                  child: Image.asset(
                    "assets/images/order.png",
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OrderHistory()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            // height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  child: ListView.builder(
                      itemCount: item.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item[index],
                              style: TextStyle(
                                  fontFamily: "Poppins-regular",
                                  color: MyColors.textcolor,
                                  fontSize: 13),
                            ),
                            Text(
                              pc[index],
                              style: TextStyle(
                                  fontFamily: "Poppins-regular",
                                  color: MyColors.textcolor,
                                  fontSize: 13),
                            )
                          ],
                        );
                      }),
                ),
                Divider(color: Colors.grey),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                          fontFamily: "Poppins-semibold",
                          color: MyColors.textcolor,
                          fontSize: 18),
                    ),
                    Text(
                      "93",
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
        ),
      ),
    );
  }
}
