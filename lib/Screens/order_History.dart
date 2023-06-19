import 'package:flutter/material.dart';
import 'package:prism_medico/Screens/cart.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Screens/notification.dart';
import 'package:prism_medico/Screens/order_detail.dart';
import 'package:prism_medico/Screens/profile.dart';
import 'package:prism_medico/Utilities/myColor.dart';

class OrderHistory extends StatefulWidget {
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  List<String> date = [
    "01/05/2023",
    "02/05/2023",
    "03/05/2023",
    "04/05/2023",
    "05/05/2023",
    "06/05/2023",
    "07/05/2023",
    "08/05/2023",
    "09/05/2023",
    "10/05/2023",
    "11/05/2023",
    "12/05/2023",
    "13/05/2023",
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
                Image.asset(
                  "assets/images/order.png",
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: date.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.only(left: 10, right: 10),
                // height: 60,
                // width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey)),
                child: Center(
                  child: ListTile(
                    leading: Icon(
                      Icons.calendar_today,
                      color: Colors.grey,
                    ),
                    trailing: InkWell(
                      child: Image.asset("assets/images/forward.png"),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OredrDetail(
                                      orderdate: date[index],
                                    )));
                      },
                    ),
                    title: Text(
                      date[index],
                      softWrap: true,
                      style: TextStyle(
                          fontFamily: "Poppins-Semibold",
                          fontSize: 14,
                          color: Colors.grey.shade700),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
