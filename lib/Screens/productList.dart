import 'package:flutter/material.dart';
import 'package:prism_medico/Screens/cart.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Screens/notification.dart';
import 'package:prism_medico/Screens/profile.dart';
import 'package:prism_medico/Utilities/myColor.dart';

class ProductList extends StatefulWidget {
  final productname1;
  final productname2;
  final productimage;
  final productdiscr;

  ProductList(
      {this.productname1,
      this.productname2,
      this.productimage,
      this.productdiscr});
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool stockavailable = true;
  int counter = 1;
  List<String> productimages = [
    "assets/images/Privale.png",
    "assets/images/Privale.png",
    "assets/images/Privale.png",
    "assets/images/Privale.png",
  ];

  List<String> producttitle = [
    "Prisvals-50",
    "Prisvals-100 ",
    "Prisvals-200",
    "Prisvals-50",
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
                          widget.productname1,
                          style: TextStyle(
                            fontFamily: "Poppins-Semibold",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.productname2,
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
      body: Container(
          child: Form(
        child: Column(
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                //  width: double.infinity,
                height: 50,
                margin: EdgeInsets.all(15),
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
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                      decoration: InputDecoration(
                    border: InputBorder.none,
                    alignLabelWithHint: true,
                    labelText: "Search the product",
                    prefixIcon: Icon(Icons.search),
                    labelStyle: new TextStyle(
                      color: Colors.grey,
                      fontFamily: "Poppins-Regular",
                      fontSize: 12,
                    ),
                  )),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.5,
              child: ListView.builder(
                itemCount: productimages.length,
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
                        Image.asset(
                          productimages[index],
                          height: 50,
                          // fit: BoxFit.fill,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            // color: Colors.yellow,
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        producttitle[index],
                                        softWrap: true,
                                        style: TextStyle(
                                            fontFamily: "Poppins-Semibold",
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  child: Text(
                                    "Sacubitril 49mg+valsartan 26 mg 9.5 mm tab 5x1x14",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontFamily: "Poppins-regular",
                                        fontSize: 10,
                                        color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
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
                                        height: 30,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5 /
                                                2.5,
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
                                                  counter--;
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
                                                  counter++;
                                                })
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Cart()));
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
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
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
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
