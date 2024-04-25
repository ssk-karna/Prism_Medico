import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:prism_medico/model/order_Model.dart';

import 'package:prism_medico/utills/Constant.dart';
import 'package:prism_medico/utills/Super_Responce.dart';

class Order_repo {
  static Future<SuperResponse<order_Model>> orderRepo(
    String date,
    String userId,
    String status,
    List orderItems,
    // String productID,
    // String qunty,
  ) async {
    var body = {
      'order_date': date,
      'order_user_id': userId,
      'status': status,
      'order': orderItems
    };
    Uri url = Uri.parse('${Constants.BASE_URL}prism/order/order.php');


    return http
        .post(url,
            headers: {HttpHeaders.contentTypeHeader: 'application/json'},
            body: json.encode(body))
        .then((http.Response response) {
      /* if (response.statusCode < 200 ||
          response.statusCode > 400 ||
          json == null) {
        throw new Exception("Error while fetching data");
      }*/
      print(json.encode(body));
      print(response.body);
      Map<dynamic, dynamic> map = json.decode(response.body);
      final data = map['data'];

     // if (data != null && data != "") {
        return SuperResponse.fromJson(map, order_Model.fromJson(data));
      // } else {
      //   return SuperResponse.fromJson(map, null);
      // }
    });
  }
}
