import 'package:flutter/material.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Screens/notification.dart';
import 'package:prism_medico/Screens/order_History.dart';
import 'package:prism_medico/Screens/profile.dart';
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/Utilities/size_Confige.dart';

class Cart extends StatefulWidget {
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool stockavailable = true;
  int counter = 1;

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
  void initState() {
    counter = 1;
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
                Container(
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
      body: SingleChildScrollView(
          child: Form(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 15),
                height: 40,
                decoration: BoxDecoration(color: Colors.grey.shade200),
                child: Center(
                  child: Text(
                    "2 Items in the cart",
                    style: TextStyle(
                        fontFamily: "Poppins-regular",
                        fontSize: 12,
                        color: MyColors.textcolor),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.7,
                child: ListView.builder(
                  itemCount: notifytitle.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width / 2,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            maxRadius: 30,
                            child: Image.asset(
                              notifyimages[index],
                              height: 40,
                              // fit: BoxFit.fill,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.4,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      IconButton(
                                          icon: Icon(
                                            Icons.cancel,
                                            color: MyColors.textcolor,
                                          ),
                                          onPressed: null)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        notifydesc[index],
                                        style: TextStyle(
                                            fontFamily: "Poppins-regular",
                                            fontSize: 10,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.4,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              6,
                                          child: Row(
                                            children: [
                                              Text(
                                                "Stock :",
                                                style: TextStyle(
                                                    fontFamily:
                                                        "Poppins-semibold",
                                                    fontSize: 12,
                                                    color: MyColors.textcolor),
                                              ),
                                              stockavailable
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
                                          //color: Colors.yellow,
                                          height: 30,

                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey.shade300),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton(
                                                  icon: Icon(
                                                    Icons.remove,
                                                    color: MyColors.textcolor,
                                                    size: 15,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      counter--;
                                                    });
                                                  }),
                                              Text(
                                                counter.toString(),
                                                style: TextStyle(
                                                    color: MyColors.textcolor,
                                                    fontFamily:
                                                        "Poppins-regular"),
                                              ),
                                              IconButton(
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: MyColors.textcolor,
                                                    size: 15,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      counter++;
                                                    });
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
              FlatButton(
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
                  showOrderConfirm(context);

                  /* if (_pass == _confiPass) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Homepage()));
                        } else {
                          //showAlertDialog(context);
                        }*/
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
            ],
          ),
        ),
      )),
    );
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
        showOrderplaced(context);
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
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Homepage()));
      },
      child: Text(
        'OKEY',
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
}
