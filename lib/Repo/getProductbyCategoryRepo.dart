import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:prism_medico/model/latestProduct.dart';
import 'package:prism_medico/utills/Constant.dart';
import 'package:prism_medico/utills/Internet_Connection.dart';
import 'package:prism_medico/utills/Super_Responce.dart';

class searchProductListbycategoryRepo {
  static Future<SuperResponse<List<Latest_Product_model>>?>
      searchProductbyCategory(
    String catId,
    String productName,
  ) async {
    // userDetails = await SessionManager.getUser();
    // selectedCity = await SessionManager.getSelectedCity();

    var body = {
      'category_id': catId,
      'product_name': productName,
    };
    Uri url = Uri.parse("${Constants.BASE_URL}prism/product-master/all-product-list.php?category_id=$catId&key=$productName");

    var isInternetConnected = await InternetUtil.isInternetConnected();

    if (isInternetConnected) {
      print('Internet Available');

      return http.get(
        url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      ).then((http.Response response) {
        if (response.statusCode < 200 ||
            response.statusCode > 400 ||
            json == null) {
          throw new Exception("Error while fetching data");
        }

        Map<dynamic, dynamic> map = json.decode(response.body);

        Iterable data = map['data'];
        List<Latest_Product_model> categoryList = data
            .map((dynamic ts) => Latest_Product_model.fromJson(ts))
            .toList();

        // for (var b in categoryList) {
        //   print(b.toJson());
        // }
        //save in the shared pref
        //SessionManager.saveCategoryListObject(categoryList);

        var superResponse = SuperResponse.fromJson(map, categoryList);
        return superResponse;
      });
    } else {
      print('Internet Not Available');

      //  var categoryList = await SessionManager.getCategoryList();
      //  print(categoryList);

      // SuperResponse<List<category_model>> superResponse = SuperResponse(data: categoryList,);
      //return superResponse;
    }
  }
}
