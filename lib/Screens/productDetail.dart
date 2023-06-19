import 'package:flutter/material.dart';
import 'package:prism_medico/Screens/cart.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Screens/profile.dart';
import 'package:prism_medico/Utilities/myColor.dart';

class ProductDetail extends StatefulWidget {
  final productName;
  final descr;

  ProductDetail({this.productName, this.descr});
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int counter = 1;

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
                          widget.productName,
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
                      Image.asset(
                        "assets/images/Notification.png",
                      ),
                      Image.asset(
                        "assets/images/Cart.png",
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
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Form(
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset("assets/images/productImage.png")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.productName,
                      style: TextStyle(
                          fontFamily: "Poppins-semibold",
                          fontSize: 18,
                          color: MyColors.textcolor),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey.shade300),
                      child: Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.remove,
                                color: MyColors.textcolor,
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
                                fontFamily: "Poppins-regular"),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.add,
                                color: MyColors.textcolor,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: Text(
                        "SACUBRITIL 25 mg+ VALSATARAN 5MG",
                        style: TextStyle(
                            fontFamily: "Poppins-REGULAR",
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                    ),
                    Text(
                      "Available in Stock",
                      style: TextStyle(
                          fontFamily: "Poppins-semibold",
                          fontSize: 12,
                          color: MyColors.textcolor),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 80),
                FlatButton(
                  height: 45,
                  minWidth: MediaQuery.of(context).size.width / 1.5,
                  padding: EdgeInsets.all(10),
                  shape: (RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    //side: BorderSide(color: Colors.red)
                  )),
                  textColor: Colors.white,
                  color: MyColors.themecolor,
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Cart()));
                    setState(() {
                      // istapped = 'Button tapped';
                    });
                  },
                  child: Center(
                    child: Text(
                      'Add to cart',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins-Semibold",
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Product Description",
                    style: TextStyle(
                        fontFamily: "Poppins-semibold",
                        fontSize: 18,
                        color: MyColors.textcolor),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  child: Text(
                    "Recent nutrition research promotes the consumption of vegetables and fruits as part of a balanced diet to reduce the risk of various chronic diseases. However, the large-scale consumption of vegetables and fruits in various forms results in the production of large quantities of waste products.The estimated quantity of citrus waste products produced worldwide is close to 15 million tons annually. The bioactive content of these waste products necessitates an eco-friendly and responsible method of disposal, which subsequently increases disposal costs.New regulations for food waste management have created the concept of byproducts, from which more bioactive compounds can be derived. Notably, citrus waste contains bioactive compounds with anti-inflammatory, anti-cancer, anti-infective, antioxidant, and neuroprotective activity, all of which have applications in treating hypertension, cancer, obesity, diabetes, and neurodegenerative disorders.",
                    style: TextStyle(
                        fontFamily: "Poppins-regular",
                        color: Colors.grey,
                        fontSize: 12),
                    softWrap: true,
                    //overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
