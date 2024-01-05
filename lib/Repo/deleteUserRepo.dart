import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:prism_medico/Utilities/myColor.dart';
import 'package:prism_medico/utills/Constant.dart';
import 'package:prism_medico/utills/Internet_Connection.dart';
import 'package:prism_medico/utills/Super_Responce.dart';

class deleteUserRepo{

 static Future<SuperResponse> deleteUserById(
      String userId,
      ) async {
    // userDetails = await SessionManager.getUser();
    // selectedCity = await SessionManager.getSelectedCity();

    var body = {
      'user_id': userId,
    };

    var isInternetConnected = await InternetUtil.isInternetConnected();

    if (isInternetConnected) {
      print('Internet Available');

      return http.delete(
        "${Constants.BASE_URL}prism/user/delete-user.php?user_id=$userId",
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      ).then((http.Response response) {
        if (response.statusCode < 200 ||
            response.statusCode > 400 ||
            json == null) {
          throw new Exception("Error while fetching data");
        }

        print("Delete response is :- ${response.body}");
        Map<dynamic, dynamic> map = json.decode(response.body);
        final data = map['message'];

        Fluttertoast.showToast(
            msg: data,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5,
            backgroundColor: MyColors.themecolor,
            textColor: MyColors.textcolor,
            fontSize: 12.0);

        return SuperResponse.fromJson(map, null);

      }
    );
    } else {
      print('Internet Not Available');

    }
  }
}
