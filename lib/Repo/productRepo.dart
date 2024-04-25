import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:prism_medico/model/latestProduct.dart';
import 'package:prism_medico/utills/Constant.dart';


import 'package:prism_medico/utills/Super_Responce.dart';

class getProductDetailRepo {
  static Future<SuperResponse<Latest_Product_model>> getProductDetail(
      String productId) async {
    var body = {'product_id': productId};
    Uri url = Uri.parse('${Constants.BASE_URL}prism/product-master/getProductById.php/$productId');

    return http.get(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    ).then((http.Response response) {
      if (response.statusCode < 200 ||
          response.statusCode > 400 ||
          json == null) {
        throw new Exception("Error while fetching data");
      }
      print(response.body);
      Map<String, dynamic> map = json.decode(response.body);
      final data = map['data'];

    //  if (data != null && data != "") {
        return SuperResponse.fromJson(map, Latest_Product_model.fromJson(data));
      // } else {
      //   return SuperResponse.fromJson(map, null);
      // }
    });
  }
}
