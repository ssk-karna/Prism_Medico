import 'package:flutter/material.dart';
import 'package:prism_medico/Screens/add_Address.dart';
import 'package:prism_medico/Screens/allProduct.dart';
import 'package:prism_medico/Screens/cart.dart';
import 'package:prism_medico/Screens/faq.dart';
import 'package:prism_medico/Screens/newsDetail.dart';
import 'package:prism_medico/Screens/notification.dart';
import 'package:prism_medico/Screens/order_History.dart';
import 'package:prism_medico/Screens/productDetail.dart';
import 'package:prism_medico/Screens/productList.dart';
import 'package:prism_medico/Screens/profile.dart';
import 'package:prism_medico/Utilities/myColor.dart';

class Homepage extends StatefulWidget {
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Color appTheme = Color.fromARGB(255, 91, 197, 237);
  List<String> images = [
    "assets/images/Cardiac-tablets.png",
    "assets/images/Anti-diabitic.png",
    "assets/images/Neuro-product.png",
    "assets/images/General-Tab.png",
    "assets/images/Softget-capsule.png",
    "assets/images/Injection.png",
  ];
  List<String> title1 = [
    "Cardiac Range ",
    "Anti Diabetic  ",
    "Neuro Product",
    "General Tablets ",
    "Softget ",
    "Injection ",
  ];
  List<String> title2 = [
    "Tablets",
    "Tablets ",
    "Tablets",
    "and Capsules",
    "Capsule",
    "Products",
  ];

  List<String> latestProductimages = [
    "assets/images/Privale.png",
    "assets/images/Privale.png",
    "assets/images/Privale.png",
    "assets/images/Privale.png",
  ];

  List<String> latestproducttitle = [
    "Prisvals-50",
    "Prisvals-100 ",
    "Prisvals-200",
    "Prisvals-50",
  ];

  List<String> newsimages = [
    "assets/images/capsule.png",
    "assets/images/capsule.png",
    "assets/images/capsule.png",
    "assets/images/capsule.png",
  ];
  List<String> newstitle = [
    "India bans 14 fixed-dose medicine...",
    "Cost of prescription drug to the NHS reached...",
    "India bans 14 fixed-dose medicine...",
    "Cost of prescription drug to the NHS reached...",
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: DefaultTabController(
          length: 1,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: MyColors.themecolor,
              bottomOpacity: 1.0,
              elevation: 1,
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Prism Medico & Pharmacy Ltd.",
                                    style: TextStyle(
                                      fontFamily: "Poppins-Semibold",
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Apolo Medical",
                                    style: TextStyle(
                                      fontFamily: "Poppins-normal",
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
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
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Notificationscreen()));
                              },
                              child: Image.asset(
                                "assets/images/Notification.png",
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Cart()));
                              },
                              child: Image.asset(
                                "assets/images/Cart.png",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              bottom: TabBar(
                indicatorColor: Colors.transparent,
                tabs: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllProduct()));
                        },
                        child: Container(
                          //  width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/serach.png",
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Search the product",
                                  style: TextStyle(
                                      fontFamily: "Poppins-regular",
                                      fontSize: 14,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              height: 60,
              decoration: BoxDecoration(color: MyColors.themecolor),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/Vector.png",
                      ),
                      InkWell(
                        child: Image.asset(
                          "assets/images/account.png",
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()));
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
            drawer: Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Stack(children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: appTheme,
                      ),
                      child: Center(child: Text("")),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 6,
                          left: 50),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        maxRadius: 45,
                        minRadius: 45,
                        child: Image.asset(
                          "assets/images/profile.png",
                          height: 500,
                        ),
                      ),
                    ),
                  ]),
                  ListTile(
                    trailing: Container(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.grey.shade800,
                              size: 20,
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Profile()));
                            },
                          ),
                          Text(
                            "Edit",
                            style: TextStyle(
                              fontFamily: "Poppins-Normal",
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    title: Text(
                      "Apollo Medical",
                      style: TextStyle(
                          fontFamily: "Poppins-Semibold",
                          color: Colors.grey.shade800,
                          fontSize: 16),
                    ),
                  ),
                  ListTile(
                    title: Container(
                      height: 100,
                      child: Text(
                          "A/p : simplly dummy text, jaipur 302001, Rajsthan",
                          softWrap: true,
                          style: TextStyle(
                              fontFamily: "Poppins-Regular",
                              color: Colors.grey,
                              fontSize: 12)),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Image.asset(
                      "assets/images/Address.png",
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey.shade800,
                      size: 15,
                    ),
                    title: Text(
                      "Add other Address",
                      style: TextStyle(
                        fontFamily: "Poppins-Semibold",
                        color: Colors.grey.shade800,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Add_Address()));
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      "assets/images/order1.png",
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey.shade800,
                      size: 15,
                    ),
                    title: Text(
                      "Order History",
                      style: TextStyle(
                        fontFamily: "Poppins-Semibold",
                        color: Colors.grey.shade800,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderHistory()));
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      "assets/images/faq.png",
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey.shade800,
                      size: 15,
                    ),
                    title: Text("FAQ",
                        style: TextStyle(
                          fontFamily: "Poppins-Semibold",
                          color: Colors.grey.shade800,
                        )),
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Faq()));
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 7,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: Colors.grey.shade800,
                      ),
                      title: Text("Logout",
                          style: TextStyle(
                            fontFamily: "Poppins-Semibold",
                            color: Colors.grey.shade800,
                          )),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            body: Container(
                //height: 500,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                    child: Form(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Shop By Category",
                            style: TextStyle(
                                fontFamily: "Poppins-semibold",
                                fontSize: 18,
                                color: MyColors.textcolor),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 80,
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height / 3.4,
                            width: MediaQuery.of(context).size.width,
                            // padding: EdgeInsets.all(8.0),
                            child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: images.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 10.0,
                                      mainAxisSpacing: 10.0),
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductList(
                                                  productname1: title1[index],
                                                  productname2: title2[index],
                                                )));
                                  },
                                  child: Card(
                                      color: Color.fromARGB(250, 230, 250, 255),
                                      shadowColor: Colors.grey,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(top: 3),
                                              child: Text(
                                                title1[index],
                                                softWrap: true,
                                                style: TextStyle(
                                                    fontFamily:
                                                        "Poppins-semibold",
                                                    fontSize: 10,
                                                    color:
                                                        Colors.grey.shade900),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(bottom: 3),
                                              child: Text(
                                                title2[index],
                                                softWrap: true,
                                                style: TextStyle(
                                                    fontFamily:
                                                        "Poppins-semibold",
                                                    fontSize: 10,
                                                    color:
                                                        Colors.grey.shade900),
                                              ),
                                            ),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  3.4 /
                                                  3.4,

                                              //color: Colors.yellow,
                                              child: Image.asset(
                                                images[index],
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                );
                              },
                            )),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 70),
                        FlatButton(
                          height: 45,
                          minWidth: MediaQuery.of(context).size.width / 1.5,
                          padding: EdgeInsets.all(8),
                          shape: (RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            //side: BorderSide(color: Colors.red)
                          )),
                          textColor: Colors.white,
                          color: MyColors.themecolor,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => OrderHistory()));
                          },
                          child: Center(
                            child: Text(
                              'Order History',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins-Semibold",
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 90,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Latest Product",
                            style: TextStyle(
                                fontFamily: "Poppins-semibold",
                                fontSize: 18,
                                color: MyColors.textcolor),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: latestProductimages.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductDetail(
                                                productName:
                                                    latestproducttitle[index],
                                              )));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 8, right: 8, top: 2, bottom: 2),
                                  padding: EdgeInsets.all(5),
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
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
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        latestProductimages[index],
                                        fit: BoxFit.fill,
                                        height: 90,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                latestproducttitle[index],
                                                style: TextStyle(
                                                    fontFamily:
                                                        "Poppins-Semibold",
                                                    fontSize: 10),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "Sacubitril 49mg+valsartan",
                                                style: TextStyle(
                                                    fontFamily:
                                                        "Poppins-Normal",
                                                    fontSize: 10,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "26 mg",
                                                style: TextStyle(
                                                    fontFamily:
                                                        "Poppins-Normal",
                                                    fontSize: 10,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "9.5 mm tab 5x1x14",
                                                style: TextStyle(
                                                    fontFamily:
                                                        "Poppins-Normal",
                                                    fontSize: 10,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 70,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Best Sellers",
                            style: TextStyle(
                                fontFamily: "Poppins-semibold",
                                fontSize: 18,
                                color: MyColors.textcolor),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: latestProductimages.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductDetail(
                                                productName:
                                                    latestproducttitle[index],
                                              )));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 8, right: 8, top: 2, bottom: 2),
                                  padding: EdgeInsets.all(5),
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
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
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        latestProductimages[index],
                                        fit: BoxFit.fill,
                                        height: 90,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                latestproducttitle[index],
                                                style: TextStyle(
                                                    fontFamily:
                                                        "Poppins-Semibold",
                                                    fontSize: 10),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "Sacubitril 49mg+valsartan",
                                                style: TextStyle(
                                                    fontFamily:
                                                        "Poppins-Normal",
                                                    fontSize: 10,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "26 mg",
                                                style: TextStyle(
                                                    fontFamily:
                                                        "Poppins-Normal",
                                                    fontSize: 10,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "9.5 mm tab 5x1x14",
                                                style: TextStyle(
                                                    fontFamily:
                                                        "Poppins-Normal",
                                                    fontSize: 10,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 5),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Latest News",
                            style: TextStyle(
                                fontFamily: "Poppins-semibold",
                                fontSize: 18,
                                color: Colors.grey.shade900),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: MediaQuery.of(context).size.height / 3.5,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            itemCount: latestProductimages.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(8),
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 2),
                                        blurRadius: 5.0,
                                        color: Colors.grey.withOpacity(0.6),
                                      ),
                                    ]),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      newsimages[index],
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NewsDetail(
                                                      newsimage:
                                                          newsimages[index],
                                                      newtitle:
                                                          newstitle[index],
                                                    )));
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                newstitle[index],
                                                softWrap: true,
                                                style: TextStyle(
                                                    fontFamily:
                                                        "Poppins-Semibold",
                                                    fontSize: 14),
                                              ),
                                            ),
                                            SizedBox(height: 3),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "Sacubitril 49mg+valsartan",
                                                style: TextStyle(
                                                    fontFamily:
                                                        "Poppins-Normal",
                                                    fontSize: 10,
                                                    color: Colors.grey),
                                              ),
                                            ),
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
                      ],
                    ),
                  ),
                ))),
          )),
    );
  }
}
