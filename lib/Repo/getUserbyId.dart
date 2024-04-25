import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/model/User.dart';
import 'package:prism_medico/utills/Constant.dart';
import 'package:prism_medico/utills/Super_Responce.dart';

class GetbyUserID {
  static Future<SuperResponse<User_Registration>?> getByuserId(String id) async {
    var body = {'user_id': id};
    Uri url = Uri.parse('${Constants.BASE_URL}prism/user/getUserDetailsById.php/$id');

    return http.get(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    ).then((http.Response response) {
      if (response.statusCode < 200 ||
          response.statusCode > 400 ||
          json == null) {
        Map<dynamic, dynamic> map = json.decode(response.body);
        final data = map['message'];
        if (data == null) {
          print("1");
        } else {
          Fluttertoast.showToast(
              msg: data,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 5,
              backgroundColor: MyColors.themecolor,
              textColor: MyColors.textcolor,
              fontSize: 12.0);
        }
        // throw new Exception("Error while fetching data");
      }
      print(response.body);
      Map<dynamic, dynamic> map = json.decode(response.body);
      if (map != null) {
        final data = map['data'];
    //    if (data != null && data != "") {
          return SuperResponse.fromJson(map, User_Registration.fromJson(data));
        // } else {
        //   print("Data is recive null");
        //   return SuperResponse.fromJson(map, null);
        // }
      } else {
        print("data null");
      }
    });
  }
}
