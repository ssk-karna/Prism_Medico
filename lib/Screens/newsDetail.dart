import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Screens/profile.dart';
import 'package:prism_medico/Screens/cart.dart';
import 'package:prism_medico/Screens/notification.dart';
import 'package:prism_medico/model/latestProduct.dart';
import 'package:prism_medico/Screens/order_History.dart';
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NewsDetail extends StatefulWidget {
  final newsimage;
  final newtitle;
  final List<Latest_Product_model> cart;

  NewsDetail({this.newsimage, this.newtitle, this.cart});
  _NewsDetailState createState() => _NewsDetailState(this.cart);
}

class _NewsDetailState extends State<NewsDetail> {
  _NewsDetailState(this.cart);
  List<Latest_Product_model> cart;
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
                          "News",
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
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Notificationscreen(
                                        cart: cart,
                                      )));
                        },
                        child: SvgPicture.asset(
                          "assets/images/notification.svg",
                        ),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
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
        child: Form(
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset("assets/images/newsimage.png")),
                Container(
                  height: 50,
                  child: Text(
                    widget.newtitle,
                    softWrap: true,
                    style: TextStyle(
                        fontFamily: "Poppins-semibold",
                        fontSize: 16,
                        color: MyColors.textcolor),
                  ),
                ),
                Divider(
                  color: Colors.grey,
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
