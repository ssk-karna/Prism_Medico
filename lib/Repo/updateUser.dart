import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/model/User.dart';
import 'package:prism_medico/utills/Constant.dart';
import 'package:prism_medico/utills/Super_Responce.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:prism_medico/utills/Session_Manager.dart';
import 'package:prism_medico/utills/Utils.dart';

class UpdateUserRepo {
  static Future<SuperResponse<User_Registration>> updateUserr(
    var userId,
    String UserName,
    String fullName,
    String pharmacyName,
    String address,
    String city,
    String disct,
    String pincode,
    String state,
    String mobileNumber,
    String emailID,
    String img_Name,
    String user_img,
    String img,
  ) async {
    //FirebaseApp.initializeApp();
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    var deviceId = await SessionManager.getDeviceId();
    var fcmToken = await firebaseMessaging.getToken();

    var body = {
      'user_id': userId,
      'user_name': UserName,
      'full_name': fullName,
      'pharmacy_name': pharmacyName,
      'address': address,
      'city': city,
      'district': disct,
      'pincode': pincode,
      'state': state,
      'phone': mobileNumber,
      'email_id': emailID,
      'image_name': img_Name,
      'user_image': user_img,
      'image': img,

      // 'fcm_token': fcmToken,
      // 'device_id': deviceId,
      // 'device_type': Platform.isIOS ? "iOS" : "Android",

      //  'device_type': Platform.isAndroid ? "iOS" : "Android",
      //'register_type': 'mnumber'
    };
    return http
        .post('${Constants.BASE_URL}prism/user/update-user.php?user_id=$userId',
            headers: {HttpHeaders.contentTypeHeader: 'application/json'},
            body: json.encode(body))
        .then((http.Response response) {
      if (response.statusCode < 200 ||
          response.statusCode > 404 ||
          json == null) {
        Map<dynamic, dynamic> map = json.decode(Utils.filterResponseString(response.body));
        final data = map['message'];
        Fluttertoast.showToast(
            msg: data,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 10,
            backgroundColor: MyColors.themecolor,
            textColor: MyColors.textcolor,
            fontSize: 12.0);
      }
      print(response.body);
      Map<dynamic, dynamic> map = json.decode(Utils.filterResponseString(response.body));
      final data = map['data']['userData'];

      if (data != null && data != "") {
        return SuperResponse.fromJson(map, User_Registration.fromJson(data));
      } else {
        return SuperResponse.fromJson(map, null);
      }
    });
  }
}
