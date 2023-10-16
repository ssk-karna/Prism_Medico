import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prism_medico/Repo/bestProductRepo.dart';
import 'package:prism_medico/Repo/categoryListRepo.dart';
import 'package:prism_medico/Repo/getStateRepo.dart';
import 'package:prism_medico/Repo/latestProductREpo.dart';
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
import 'package:prism_medico/Screens/login.dart';
import 'package:prism_medico/Screens/universalSearch.dart';
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/model/Ctaegory_model.dart';
import 'package:prism_medico/model/latestProduct.dart';
import 'package:prism_medico/model/User.dart';
import 'package:prism_medico/utills/Constant.dart';
import 'package:prism_medico/utills/Session_Manager.dart';
import 'package:prism_medico/utills/Internet_Connection.dart';
import 'package:prism_medico/utills/Super_Responce.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:prism_medico/model/order_Model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class Homepage extends StatefulWidget {
  final User_Registration user;
  final bool isComeFromLogin;
  final productListr;
  final List<Latest_Product_model> cart;
  final List<order_Model> notify;
  Homepage(
      {Key key,
      this.productListr,
      this.user,
      this.isComeFromLogin,
      this.cart,
      this.notify})
      : super(key: key);

  _HomepageState createState() => _HomepageState(this.cart, this.notify);
}

class _HomepageState extends State<Homepage> {
  _HomepageState(this.cart, this.notify);
  List<Latest_Product_model> cart;
  List<order_Model> notify;
  Color appTheme = Color.fromARGB(255, 91, 197, 237);
  var isInternetConnected = InternetUtil.isInternetConnected();
  SharedPreferences sharedPreferences;
  //var userDetails;
  var user;
  var statelist;

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
  void initState() {
    setState(() {
      cart.length;
      CircularProgressIndicator();
    });
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AlertDialog(
                title: Text(
                  'Get Notified!',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Poppins-semibold",
                      color: Colors.blue),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Image.asset(
                            'assets/images/Notification.png',
                            height: 20,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Allow Prism_Medico to send you notifications!',
                      style: TextStyle(
                          fontSize: 13, fontFamily: "Poppins-regular"),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text(
                        'Deny',
                      )),
                  TextButton(
                      onPressed: () async {
                        isAllowed = true;
                        AwesomeNotifications()
                            .requestPermissionToSendNotifications();
                        Navigator.of(ctx).pop();
                      },
                      child: Text(
                        'Allow',
                      )),
                ],
              );
            });
      }
    });
    // SessionManager.getcartList().then((data) {
    //   setState(() {
    //     cart = data;
    //   });
    // });

    SessionManager.getUser().then((value) {
      if (value == null) {
        setState(() {
          return userDetails == widget.user;
        });
      } else {
        setState(() {
          return userDetails = value;
        });
      }
    });

    setState(() {
      requestPhoneStatePermission();
    });
    super.initState();

    // GetStateListRepo.getStateList().then((value) => {
    //     for (int i=0; i<=value.data.length; i++ ) {
    //       statelist = value.data[i].id

    //     }
    // });
  }

  Future<void> requestPhoneStatePermission() async {
    // PermissionStatus status = await Permission.phone.request();

    // if (status == PermissionStatus.granted) {
    //   print("permission granted");
    //   // Permission granted, you can now access phone-related features
    // } else {
    //   print("permission not granted");
    //   await openAppSettings();
    //   // Permission denied, handle accordingly (e.g., show an error message)
    // }
    PermissionStatus statusCamera = await Permission.camera.request();
    if (statusCamera.isGranted) {
      // Permission granted, proceed with actions related to camera
      print('Camera permission granted');
    } else {
      // Permission denied
      print('Camera permission denied');
      await openAppSettings();
    }

    // PermissionStatus statusStorage = await Permission.storage.request();
    // if (statusStorage.isGranted) {
    //   // Permission granted, proceed with actions related to storage
    //   print('Storage permission granted');
    // } else {
    //   // Permission denied
    //   print('Storage permission denied');
    //   await openAppSettings();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
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
                        Expanded(
                          child: Container(
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
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: userDetails.pharmacyname == null
                                          ? Text(
                                              '',
                                              style: TextStyle(
                                                fontFamily: "Poppins-normal",
                                                fontSize: 13,
                                              ),
                                            )
                                          : Text(
                                              '${userDetails.pharmacyname.toString().toUpperCase()}',
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
                        ),
                        Container(
                          // width: MediaQuery.of(context).size.width / 6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Notificationscreen(
                                            cart: cart,
                                            //  notify: notify,
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
                                                    toastLength:
                                                        Toast.LENGTH_LONG,
                                                    gravity:
                                                        ToastGravity.SNACKBAR,
                                                    timeInSecForIosWeb: 10,
                                                    backgroundColor:
                                                        MyColors.themecolor,
                                                    textColor:
                                                        MyColors.textcolor,
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
                                                    backgroundColor:
                                                        MyColors.textcolor,
                                                    foregroundColor:
                                                        Colors.white,
                                                    child: Text(
                                                      cart.length.toString(),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                bottom: TabBar(
                  indicatorColor: Colors.transparent,
                  tabs: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            // {
                            //   var result = await showSearch<String>(
                            //     context: context,
                            //     delegate: search(),
                            //   );
                            //   //setState(() => _result = result);
                            // }
                            // ;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllProduct(
                                          cart: cart,
                                        )));
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
                height: 50,
                decoration: BoxDecoration(color: MyColors.themecolor),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          "assets/images/Home.svg",
                        ),
                        InkWell(
                          child: SvgPicture.asset(
                            "assets/images/account.svg",
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile(
                                          cart: cart,
                                        )));
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
              drawer: Drawer(
                child: Container(
                  height: MediaQuery.of(context).size.height,
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
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(
                              top: 70,
                            ),
                            child: userDetails.user_image == null
                                ? CircleAvatar(
                                    backgroundColor: Colors.white,
                                    maxRadius: 45,
                                    minRadius: 45,
                                    // backgroundImage: NetworkImage(
                                    //   'https://www.prismapp.in/prism/images/user/${userDetails.user_image}',
                                    // ),
                                  )
                                : CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    maxRadius: 45,
                                    minRadius: 45,
                                    backgroundImage: NetworkImage(
                                      'https://www.prismapp.in/prism/images/user/${userDetails.user_image}',
                                    ),
                                  ),
                          ),
                        ),
                      ]),
                      ListTile(
                        // leading: Container(
                        //   child: Text(''),
                        // ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey.shade800,
                            size: 20,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile(
                                          cart: cart,
                                        )));
                          },
                        ),
                        title: userDetails.pharmacyname == null
                            ? Text(
                                '',
                                style: TextStyle(
                                    fontFamily: "Poppins-Semibold",
                                    color: Colors.grey.shade800,
                                    fontSize: 16),
                              )
                            : Text(
                                '${userDetails.pharmacyname.toString().toUpperCase()}',
                                style: TextStyle(
                                    fontFamily: "Poppins-Semibold",
                                    color: Colors.grey.shade800,
                                    fontSize: 16),
                              ),
                      ),
                      ListTile(
                        title: Container(
                          height: 90,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  userDetails.pharmacyname == null
                                      ? Text('',
                                          softWrap: true,
                                          style: TextStyle(
                                              fontFamily: "Poppins-Regular",
                                              color: Colors.grey,
                                              fontSize: 12))
                                      : Text(
                                          '${userDetails.pharmacyname.toString().toUpperCase()}',
                                          softWrap: true,
                                          style: TextStyle(
                                              fontFamily: "Poppins-Regular",
                                              color: Colors.grey,
                                              fontSize: 12)),
                                ],
                              ),
                              Row(
                                children: [
                                  userDetails.address == null
                                      ? Text('',
                                          softWrap: true,
                                          style: TextStyle(
                                              fontFamily: "Poppins-Regular",
                                              color: Colors.grey,
                                              fontSize: 12))
                                      : Text('${userDetails.address}',
                                          softWrap: true,
                                          style: TextStyle(
                                              fontFamily: "Poppins-Regular",
                                              color: Colors.grey,
                                              fontSize: 12)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  userDetails.city == null
                                      ? Text('',
                                          softWrap: true,
                                          style: TextStyle(
                                              fontFamily: "Poppins-Regular",
                                              color: Colors.grey,
                                              fontSize: 12))
                                      : Text('${userDetails.city}',
                                          softWrap: true,
                                          style: TextStyle(
                                              fontFamily: "Poppins-Regular",
                                              color: Colors.grey,
                                              fontSize: 12)),
                                ],
                              ),
                              Row(
                                children: [
                                  userDetails.disName == null
                                      ? Text('',
                                          softWrap: true,
                                          style: TextStyle(
                                              fontFamily: "Poppins-Regular",
                                              color: Colors.grey,
                                              fontSize: 12))
                                      : Text('${userDetails.disName}',
                                          softWrap: true,
                                          style: TextStyle(
                                              fontFamily: "Poppins-Regular",
                                              color: Colors.grey,
                                              fontSize: 12)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  userDetails.stateName == null
                                      ? Text('',
                                          softWrap: true,
                                          style: TextStyle(
                                              fontFamily: "Poppins-Regular",
                                              color: Colors.grey,
                                              fontSize: 12))
                                      : Text('${userDetails.stateName}',
                                          softWrap: true,
                                          style: TextStyle(
                                              fontFamily: "Poppins-Regular",
                                              color: Colors.grey,
                                              fontSize: 12)),
                                ],
                              ),
                              Row(
                                children: [
                                  userDetails.pincode == null
                                      ? Text('',
                                          softWrap: true,
                                          style: TextStyle(
                                              fontFamily: "Poppins-Regular",
                                              color: Colors.grey,
                                              fontSize: 12))
                                      : Text('${userDetails.pincode}',
                                          softWrap: true,
                                          style: TextStyle(
                                              fontFamily: "Poppins-Regular",
                                              color: Colors.grey,
                                              fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      // ListTile(
                      //   leading: SvgPicture.asset(
                      //     "assets/images/address.svg",
                      //   ),
                      //   trailing: Icon(
                      //     Icons.arrow_forward_ios,
                      //     color: Colors.grey.shade800,
                      //     size: 15,
                      //   ),
                      //   title: Text(
                      //     "Add other Address",
                      //     style: TextStyle(
                      //       fontFamily: "Poppins-Semibold",
                      //       color: Colors.grey.shade800,
                      //     ),
                      //   ),
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => Add_Address(
                      //                   cart: cart,
                      //                 )));
                      //   },
                      // ),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderHistory(
                                        cart: cart,
                                      )));
                        },
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/images/faq.svg",
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Faq(
                                        cart: cart,
                                      )));
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3.5,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      // SizedBox(
                      //   height: 15,
                      // ),
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
                            showConfirm(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Container(
                  color: Colors.white,
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
                              color: Colors.white,
                              height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width,
                              // padding: EdgeInsets.all(8.0),

                              child: FutureBuilder(
                                future: GetCategoryListRepo.getCatgories(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<
                                            SuperResponse<List<category_model>>>
                                        snap) {
                                  if (snap.hasData) {
                                    var list = snap.data.data;
                                    return GridView(
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 10.0,
                                              mainAxisSpacing: 10.0),
                                      children: <Widget>[
                                        ...list.map((e) => InkWell(
                                              onTap: () {
                                                Future.delayed(
                                                    Duration(seconds: 2), () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductList(
                                                                latest_product_model:
                                                                    e.id,
                                                                catName: e.name,
                                                                cart: cart,
                                                                user:
                                                                    widget.user,
                                                              ))).then((value) {
                                                    setState(() {});
                                                  });
                                                });
                                              },
                                              child: Card(
                                                  color: Color.fromARGB(
                                                      250, 230, 250, 255),
                                                  shadowColor: Colors.grey,
                                                  elevation: 5,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  ),
                                                  child: Center(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width: 98,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 3),
                                                          child: Center(
                                                            child: Text(
                                                              '${e.name}',
                                                              softWrap: true,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Poppins-semibold",
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade900),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              2.8 /
                                                              4.1,

                                                          //color: Colors.yellow,
                                                          child: Image.network(
                                                            'https://prismapp.in/prism/${e.catImage}',
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ))
                                      ],
                                    );
                                  } else {
                                    return Center(
                                      child: Container(
                                          height: 50,
                                          child: CircularProgressIndicator()),
                                    );
                                  }
                                },
                              )),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 70),
                          FlatButton(
                            height: 45,
                            minWidth: MediaQuery.of(context).size.width / 1.5,
                            padding: EdgeInsets.all(5),
                            shape: (RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              //side: BorderSide(color: Colors.red)
                            )),
                            textColor: Colors.white,
                            color: MyColors.themecolor,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OrderHistory(
                                        cart: cart,
                                      )));
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
                              height: MediaQuery.of(context).size.height / 4.2,
                              width: MediaQuery.of(context).size.width,
                              child: FutureBuilder(
                                future: latestProductListRepo.getProduct(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<
                                            SuperResponse<
                                                List<Latest_Product_model>>>
                                        snap) {
                                  if (snap.hasData) {
                                    var list = snap.data.data;
                                    if (snap.data.data != null) {
                                      return ListView(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        children: <Widget>[
                                          ...list.map((e) => (InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductDetail(
                                                                productId: e.id,
                                                                productName:
                                                                    e.name,
                                                                cart: cart,
                                                                productDetail:
                                                                    e,
                                                                commingfromHome:
                                                                    true,
                                                              ))).then((value) {
                                                    setState(() {
                                                      cart.length;
                                                    });
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 5,
                                                      right: 5,
                                                      top: 2,
                                                      bottom: 2),
                                                  padding: EdgeInsets.all(5),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          offset: Offset(0, 2),
                                                          blurRadius: 5.0,
                                                          color: Colors.grey
                                                              .withOpacity(0.6),
                                                        ),
                                                      ]),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Image.network(
                                                        'https://prismapp.in/prism/${e.productImage[0]}',
                                                        height: 80,
                                                      ),
                                                      // Image.network(
                                                      //   'https://prismapp.in/prism/images/product/649ac487abede.png',
                                                      //   fit: BoxFit.fill,
                                                      //   height: 70,
                                                      // ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 5, right: 5),
                                                        child: Column(
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                '${e.name}',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Poppins-Semibold",
                                                                    fontSize:
                                                                        10),
                                                              ),
                                                            ),
                                                            SizedBox(height: 8),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Container(
                                                                height: 25,
                                                                child: Text(
                                                                  '${e.composition}',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins-Normal",
                                                                      fontSize:
                                                                          10,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )))
                                        ],
                                      );
                                    } else {
                                      return Text("No Data Available");
                                    }
                                  } else {
                                    return Center(
                                      child: Container(
                                          height: 50,
                                          child: CircularProgressIndicator()),
                                    );
                                  }
                                },
                              )),
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
                              height: MediaQuery.of(context).size.height / 4.2,
                              width: MediaQuery.of(context).size.width,
                              child: FutureBuilder(
                                future: bestProductListRepo.getbestProduct(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<
                                            SuperResponse<
                                                List<Latest_Product_model>>>
                                        snap) {
                                  if (snap.hasData) {
                                    var list = snap.data.data;
                                    if (snap.data.data != null) {
                                      return ListView(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        children: <Widget>[
                                          ...list.map((e) => (InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductDetail(
                                                                productId: e.id,
                                                                productName:
                                                                    e.name,
                                                                cart: cart,
                                                                productDetail:
                                                                    e,
                                                                commingfromHome:
                                                                    true,
                                                              ))).then((value) {
                                                    setState(() {
                                                      cart.length;
                                                    });
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 5,
                                                      right: 5,
                                                      top: 2,
                                                      bottom: 2),
                                                  padding: EdgeInsets.all(5),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          offset: Offset(0, 2),
                                                          blurRadius: 5.0,
                                                          color: Colors.grey
                                                              .withOpacity(0.6),
                                                        ),
                                                      ]),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Image.network(
                                                        'https://prismapp.in/prism/${e.productImage[0]}',
                                                        height: 80,
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 5, right: 5),
                                                        child: Column(
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                '${e.name}',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Poppins-Semibold",
                                                                    fontSize:
                                                                        10),
                                                              ),
                                                            ),
                                                            SizedBox(height: 8),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Container(
                                                                height: 25,
                                                                child: Text(
                                                                  '${e.composition}',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Poppins-Normal",
                                                                      fontSize:
                                                                          10,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )))
                                        ],
                                      );
                                    } else {
                                      return Text("No Data Available");
                                    }
                                  } else {
                                    return Center(
                                      child: Container(
                                          height: 50,
                                          child: CircularProgressIndicator()),
                                    );
                                  }
                                },
                              )),
                          /*  SizedBox(height: 5),
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
                            itemCount: newsimages.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(8),
                                width: MediaQuery.of(context).size.width / 2.5,
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
                                        Navigator.push(
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
                                                1.6,
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
                      */
                        ],
                      ),
                    ),
                  ))))),
    );
  }

  showConfirm(BuildContext context) {
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
        SessionManager.logout();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(
                cart: cart,
              ),
            ));
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
              "Do you want Logout??? ",
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
}
