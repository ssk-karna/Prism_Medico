import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:prism_medico/model/statesModel.dart';
import 'package:prism_medico/utills/Constant.dart';
import 'package:prism_medico/utills/Internet_Connection.dart';
import 'package:prism_medico/utills/Super_Responce.dart';

class GetStateListRepo {
  static Future<SuperResponse<List<State_Model>>> getStateList() async {
    var isInternetConnected = await InternetUtil.isInternetConnected();

    if (isInternetConnected) {
      print('Internet Available');

      return http.get(
        "${Constants.BASE_URL}prism/user/all-state-list.php",
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      ).then((http.Response response) {
        if (response.statusCode < 200 ||
            response.statusCode > 400 ||
            json == null) {
          throw new Exception("Error while fetching data");
        }

        Map<dynamic, dynamic> map = json.decode(response.body);

        Iterable data = map['data'];

        List<State_Model> stateList =
            data.map((dynamic ts) => State_Model.fromJson(ts)).toList();
        // print(categoryList);
        // for (var b in categoryList) {
        //   print(b.toJson());
        // }
        //save in the shared pref
        //SessionManager.saveCategoryListObject(categoryList);

        var superResponse = SuperResponse.fromJson(map, stateList);
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
