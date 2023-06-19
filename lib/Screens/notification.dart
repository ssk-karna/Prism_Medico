import 'package:flutter/material.dart';
import 'package:prism_medico/Screens/cart.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Screens/order_History.dart';
import 'package:prism_medico/Screens/profile.dart';
import 'package:prism_medico/Utilities/myColor.dart';

class Notificationscreen extends StatefulWidget {
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notificationscreen> {
  List<String> notifyimages = [
    "assets/images/capsule.png",
    "assets/images/capsule.png",
    "assets/images/capsule.png",
    "assets/images/capsule.png",
  ];

  List<String> notifytitle = [
    "Prisval-50 order has been placed",
    "Prisval-50 order has been placed",
    "Prisval-50 order has been placed",
    "Prisval-50 order has been placed",
  ];

  List<String> notifydesc = [
    "Loram ipsum dolor sit amet,consecteture",
    "Loram ipsum dolor sit amet,consecteture",
    "Loram ipsum dolor sit amet,consecteture",
    "Loram ipsum dolor sit amet,consecteture",
  ];

  List<String> notifytime = [
    "1 min ago",
    "10 min ago",
    "10 hr ago",
    "1 hr ago",
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
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderHistory()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: notifytitle.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width / 2,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        maxRadius: 30,
                        child: Image.asset(
                          notifyimages[index],
                          height: 40,
                          // fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  notifytitle[index],
                                  softWrap: true,
                                  style: TextStyle(
                                      fontFamily: "Poppins-Semibold",
                                      fontSize: 12),
                                ),
                              ),
                              //  SizedBox(height: ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  notifydesc[index],
                                  style: TextStyle(
                                      fontFamily: "Poppins-Normal",
                                      fontSize: 10,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        notifytime[index],
                        style: TextStyle(
                            fontFamily: "Poppins-Normal",
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
