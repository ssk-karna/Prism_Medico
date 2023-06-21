import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:prism_medico/Screens/cart.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Screens/notification.dart';
import 'package:prism_medico/Screens/order_History.dart';
import 'package:prism_medico/Screens/product.dart';
import 'package:prism_medico/Screens/profile.dart';
import 'package:prism_medico/Utilities/myColor.dart';

class AllProduct extends StatefulWidget {
  _AllProductState createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  bool stockavailable = true;
  List<String> added = [];
  String currentText = "";
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  List<String> suggestions = [
    'Aspira Capsule',
    'Aspira aa Capsules',
    'casule Capsule',
    'casule Capsules',
    'Privale Plus Cap',
    'Privale Perfomance',
    'Privale Capsule',
    'Privale Capsules',
    'Privale Plus Cap',
    'Privale Perfomance',
    'Becasule Capsule',
    'Becasule Capsules',
    'Becasule Plus Cap',
    'Becasule Perfomance',
    'Becasule Capsule',
    'Becasule Capsules',
    'Becasule Plus Cap',
    'Becasule Perfomance',
  ];
  TextEditingController controller = TextEditingController();
  List suggestionList = [];
  String hint = "";

  List<String> nameList = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
    'Nathaniel Bond',
    'Taylor Story',
    'Lamont Padilla',
    'Jamia Sun',
    'Nikki Reichert',
    'Tea Holguin',
    'Rafael Meade',
    'Mercedez Goad',
    'Aileen Foltz',
    'Bryant Burt',
  ];

  void typeAheadFilter(String value) {
    suggestionList.clear();

    if (value.isEmpty) {
      setState(() {});
      return;
    }

    for (String name in suggestions) {
      if (name.toLowerCase().contains(value)) {
        suggestionList.add(name);
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                            "All Products",
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Cart()));
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
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.5,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: TextFormField(
                          controller: controller,
                          onFieldSubmitted: (value) {},
                          onChanged: (value) => typeAheadFilter(value),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            //hintText: hint,
                            labelText: "Search",
                            alignLabelWithHint: false,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 2.0,
                              ),
                            ),
                            //   hintTextDirection: TextDirection.rtl),
                          )),
                    ),
                    const SizedBox(height: 10),
                    if (suggestionList.isNotEmpty ||
                        controller.text.isNotEmpty) ...[
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(10),
                          shrinkWrap: true,
                          itemCount: suggestionList.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                showOrderplaced(context);

                                // show the dialog
                              },
                              child: Container(
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
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              (suggestionList[index]),
                                              style: TextStyle(
                                                  fontFamily:
                                                      "Poppins-semibold",
                                                  fontSize: 14),
                                            ),
                                            Text(
                                              "Pack: 20 cap",
                                              style: TextStyle(
                                                  fontFamily: "Poppins-regular",
                                                  fontSize: 11,
                                                  color: Colors.grey),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "PFIZER LTD NERO",
                                              style: TextStyle(
                                                  fontFamily: "Poppins-regular",
                                                  fontSize: 11,
                                                  color: Colors.grey),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Stock :",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Poppins-semibold",
                                                        fontSize: 12,
                                                        color:
                                                            MyColors.textcolor),
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
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            );
                          },
                        ),
                      )
                    ] else ...[
                      Container(),
                      /*Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(10),
                          shrinkWrap: true,
                          itemCount: suggestions.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            return Container(
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            (suggestions[index]),
                                            style: TextStyle(
                                                fontFamily: "Poppins-semibold",
                                                fontSize: 14),
                                          ),
                                          Text(
                                            "Pack: 20 cap",
                                            style: TextStyle(
                                                fontFamily: "Poppins-regular",
                                                fontSize: 11,
                                                color: Colors.grey),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "PFIZER LTD NERO",
                                            style: TextStyle(
                                                fontFamily: "Poppins-regular",
                                                fontSize: 11,
                                                color: Colors.grey),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
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
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                          },
                        ),
                      )*/
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showOrderplaced(BuildContext context) {
    // set up the buttons
    Widget okButton = FlatButton(
      // height: ,
      // minWidth: MediaQuery.of(context).size.width / 3,
      padding: EdgeInsets.only(left: 15, right: 15),
      shape: (RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        //side: BorderSide(color: Colors.red)
      )),
      textColor: Colors.white,
      color: MyColors.themecolor,
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Cart()));
      },
      child: Text(
        'ADD',
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Poppins-Semibold",
          fontSize: 12,
        ),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Aspira Capsule",
            style: TextStyle(fontFamily: "Poppins-semibold", fontSize: 16),
          ),
          IconButton(
              icon: Icon(
                Icons.cancel,
                color: MyColors.textcolor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      ),
      content: Container(
        height: 80,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "PFIZER LTD NERO",
                  style: TextStyle(
                      fontFamily: "Poppins-Regular",
                      fontSize: 12,
                      color: MyColors.textcolor),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Case:",
                  style: TextStyle(
                      fontFamily: "Poppins-Regular",
                      fontSize: 12,
                      color: MyColors.textcolor),
                ),
                Container(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Qty:",
                        style: TextStyle(
                            fontFamily: "Poppins-semibold",
                            fontSize: 14,
                            color: MyColors.textcolor),
                      ),
                      Container(width: 60, child: TextFormField()),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        Center(child: okButton),
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
