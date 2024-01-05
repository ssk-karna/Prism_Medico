import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/model/User.dart';
import 'package:prism_medico/utills/Constant.dart';
import 'package:prism_medico/utills/Super_Responce.dart';
import 'package:prism_medico/utills/Utils.dart';

class VerifyEmail_repo {
  static Future<SuperResponse<User_Registration>> verifyEmail(
      String email, String userName, String ph) async {
    var body = {'email_id': email, 'user_name': userName, 'phone': ph};
    return http
        .post('${Constants.BASE_URL}prism/user/verify-email.php',
            headers: {HttpHeaders.contentTypeHeader: 'application/json'},
            body: json.encode(body))
        .then((http.Response response) {
      if (response.statusCode < 201 ||
          response.statusCode > 400 ||
          json == null) {
        print("Signup response is :- ${response.body}");
        Map<dynamic, dynamic> map = json.decode(Utils.filterResponseString(response.body));
        final data = map['message'];

        Fluttertoast.showToast(
            msg: data,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5,
            backgroundColor: MyColors.themecolor,
            textColor: MyColors.textcolor,
            fontSize: 12.0);

        // throw new Exception("Error while fetching data");
      }
      print(response.body);
      Map<dynamic, dynamic> map = json.decode(Utils.filterResponseString(response.body));
      if (map != null) {
        final data = map['data'];
        if (data != null && data != "") {
          return SuperResponse.fromJson(map, User_Registration.fromJson(data));
        } else {
          print("Data receive null");
          return SuperResponse.fromJson(map, null);
        }
      } else {
        print("data null");
      }
    });
  }
}
