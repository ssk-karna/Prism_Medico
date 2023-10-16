import 'package:flutter/material.dart';
import 'package:prism_medico/Widgets/Custom_Bakground.dart';
import 'package:prism_medico/model/latestProduct.dart';

class Faq extends StatefulWidget {
  final List<Latest_Product_model> cart;

  Faq({this.cart});
  _Faqstate createState() => _Faqstate(this.cart);
}

class _Faqstate extends State<Faq> {
  _Faqstate(this.cart);
  List<Latest_Product_model> cart;
  bool pressed1 = false;
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //   iconTheme: MyColors.textcolor,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Row(
          children: [
            Text(
              "FAQ",
              style: TextStyle(
                  fontFamily: "Poppins-Semibold",
                  fontSize: 20,
                  color: Colors.black),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          CustomBGWidget(),
          Form(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Top Questions",
                          style: TextStyle(
                              fontFamily: "Poppins-semibold",
                              fontSize: 16,
                              color: Colors.grey.shade800),
                        ),
                        Text(
                          "View all",
                          style: TextStyle(
                              fontFamily: "Poppins-semibold",
                              fontSize: 14,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        pressed = !pressed;
                      });
                    },
                    child: Column(children: <Widget>[
                      AnimatedContainer(
                        height: pressed
                            ? MediaQuery.of(context).size.height / 4
                            : 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey)),
                        duration: Duration(seconds: 0),
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "How to check order ? ",
                                    style: TextStyle(
                                        fontFamily: "Poppins-semibold",
                                        fontSize: 14,
                                        color: Colors.grey.shade800),
                                  ),
                                  pressed
                                      ? Icon(
                                          Icons.minimize,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          Icons.add,
                                          color: Colors.red,
                                        )
                                ],
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                top: 20,
                                child: pressed
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.5,
                                            child: Text(
                                              "Open the Tradebase app to get started and follow the step. Tradebase dosen't charge a fee to create or maintain your account.",
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontFamily: "Poppins-regular",
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(""),
                                        ],
                                      ))
                          ],
                        ),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        pressed1 = !pressed1;
                      });
                    },
                    child: Column(children: <Widget>[
                      AnimatedContainer(
                        height: pressed1
                            ? MediaQuery.of(context).size.height / 4
                            : 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey)),
                        duration: Duration(seconds: 0),
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "How to check order history ?  ",
                                    style: TextStyle(
                                        fontFamily: "Poppins-semibold",
                                        fontSize: 14,
                                        color: Colors.grey.shade800),
                                  ),
                                  pressed1
                                      ? Icon(
                                          Icons.minimize,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          Icons.add,
                                          color: Colors.red,
                                        )
                                ],
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                top: 20,
                                child: pressed1
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.5,
                                            child: Text(
                                              "Open the Tradebase app to get started and follow the step. Tradebase dosen't charge a fee to create or maintain your account.",
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontFamily: "Poppins-regular",
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(""),
                                        ],
                                      ))
                          ],
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
