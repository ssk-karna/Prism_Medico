import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:prism_medico/model/latestProduct.dart';
import 'package:prism_medico/utills/Constant.dart';
import 'package:prism_medico/utills/Internet_Connection.dart';
import 'package:prism_medico/utills/Super_Responce.dart';
import 'package:prism_medico/utills/Utils.dart';

class bestProductListRepo {
  static Future<SuperResponse<List<Latest_Product_model>>?>
      getbestProduct() async {
    // userDetails = await SessionManager.getUser();
    // selectedCity = await SessionManager.getSelectedCity();

    var isInternetConnected = await InternetUtil.isInternetConnected();
    Uri url = Uri.parse("${Constants.BASE_URL}prism/product-master/all-product-list.php?product_type=2");


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

        Map<dynamic, dynamic> map = json.decode(Utils.filterResponseString(response.body));

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
// static Future<SuperResponse<Latest_Product_model>> getProducts(
//     String categoryID) async {
//   //userDetails = await SessionManager.getUser();
//   //var cityName = await SessionManager.getSelectedCity();

//   var body = {
//     "product_type": categoryID,
//   };

//   print(body);

//   var isInternetConnected = await InternetUtil.isInternetConnected();

//   if (isInternetConnected) {
//     print('Internet Available');

//     return http.get(
//       "${Constants.BASE_URL}prism/product-master/all-product-list.php?product_type=3",
//       headers: {HttpHeaders.contentTypeHeader: 'application/json'},
//     ).then((http.Response response) {
//       /*if (response.statusCode < 200 ||
//           response.statusCode > 400 ||
//           json == null) {
//         throw new Exception("Error while fetching data");
//       }*/
//       print(response.body);
//       Map<dynamic, dynamic> map = json.decode(response.body);
//       final data = map['data'];

//       if (data != null && data != "") {
//         print('To get Sub categories & Product list........#############');
//         return SuperResponse.fromJson(
//             map, Latest_Product_model.fromJson(data));
//       } else {
//         return SuperResponse.fromJson(map, null);
//       }
//     });
//   } else {
//     print('Internet Not Available');

//     var productList = Latest_Product_model();
//     print(productList);

//     SuperResponse<Latest_Product_model> superResponse =
//         SuperResponse(data: productList);
//     return superResponse;
//   }
// }
