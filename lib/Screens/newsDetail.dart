import 'package:flutter/material.dart';
import 'package:prism_medico/Screens/homepage.dart';
import 'package:prism_medico/Screens/profile.dart';
import 'package:prism_medico/Utilities/myColor.dart';

class NewsDetail extends StatefulWidget {
  final newsimage;
  final newtitle;

  NewsDetail({this.newsimage, this.newtitle});
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
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
