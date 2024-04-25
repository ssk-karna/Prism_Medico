import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:prism_medico/model/Ctaegory_model.dart';
import 'package:prism_medico/model/latestProduct.dart';
import 'package:prism_medico/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prism_medico/model/order_Model.dart';

class SessionManager {
  static saveUserObject(User_Registration user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_user_login', true);

    final userJson = jsonEncode(user.toJson());
    await prefs.get(user.id);
    await prefs.setString('user', userJson);
  }

  static Future<User_Registration> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user')) {
      String? jsonString = prefs.getString('user');
      if(jsonString != null){
        Map<String, dynamic> map = jsonDecode(jsonString);
        return User_Registration.fromJson(map);
      }
      else{
        return User_Registration();
      }

    } else
      return User_Registration();
  }

  static Future<bool> isUserLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('is_user_login');
  }

  static Future<User_Registration> isUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('user_id') as User_Registration;
  }

  static logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  static Future<String?> getDeviceId() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        return build.id; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        return data.identifierForVendor; //UUID for iOS
      }
    } catch (ex) {
      print('Failed to get platform version');
    }
    return null;
  }

  void addNotifications(List<order_Model> notifications) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    final userJson = jsonEncode(notifications);
    _preferences.setString('notifications', userJson);
  }

  Future<List<order_Model>> getNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('notifications')) {
      print('Category List from Prefernce : ${prefs.getString('catgorylist')}');
      String? jsonString = prefs.getString('catgorylist');
        Iterable data = jsonDecode(jsonString!);
        List<order_Model> categoryList =
        data.map((dynamic ts) => order_Model.fromJson(ts)).toList();
        return categoryList;
      } else
        return [] as List<order_Model>;
    }


  static saveCategoryListObject(List<category_model> categoryList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final categoryListJson = jsonEncode(categoryList);
    await prefs.setString('catgorylist', categoryListJson);
  }

  static Future<List<category_model>> getCategoryList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('catgorylist')) {
      print('Category List from Prefernce : ${prefs.getString('catgorylist')}');
      String? jsonString = prefs.getString('catgorylist');
      Iterable data = jsonDecode(jsonString!);
      List<category_model> categoryList =
          data.map((dynamic ts) => category_model.fromJson(ts)).toList();

      return categoryList;
    } else
      return [] as List<category_model>;
  }

  static Future<List<Latest_Product_model>> getProductList1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('catgorylist')) {
      print('Category List from Prefernce : ${prefs.getString('catgorylist')}');
      String? jsonString = prefs.getString('catgorylist');
      Iterable data = jsonDecode(jsonString!);
      List<Latest_Product_model> categoryList =
          data.map((dynamic ts) => Latest_Product_model.fromJson(ts)).toList();

      return categoryList;
    } else
      return [] as List<Latest_Product_model>;
  }

  static saveProductListObject(List<Latest_Product_model> productList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final productListJson = jsonEncode(productList);
    await prefs.setString('productlist', productListJson);
  }

  static Future<List<Latest_Product_model>> getProductList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('productList')) {
      print('Category List from Prefernce : ${prefs.getString('productList')}');
      String? jsonString = prefs.getString('productList');
      Iterable data = jsonDecode(jsonString!);
      List<Latest_Product_model> productList =
          data.map((dynamic ts) => Latest_Product_model.fromJson(ts)).toList();

//      Map<String, dynamic> map = jsonDecode(prefs.getString('catgorylist'));
//      return User.fromJson(map);
      return productList;
    } else
      return [] as List<Latest_Product_model>;
  }

  static saveCartObject(List<Latest_Product_model> cartList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.get('user_id');
    final carttList = jsonEncode(cartList);
    await prefs.setString('cartlist', carttList);
  }

  static Future<List<Latest_Product_model>> getcartList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('cartList')) {
      print('cart List from Prefernce : ${prefs.getString('cartList')}');
      String? jsonString = prefs.getString('cartList');
      Iterable data = jsonDecode(jsonString!);
      List<Latest_Product_model> carttList =
          data.map((dynamic ts) => Latest_Product_model.fromJson(ts)).toList();

      return carttList;
    } else
      return [] as List<Latest_Product_model>;
  }
}

/*static Future<String> getDeviceId() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        return build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        return data.identifierForVendor; //UUID for iOS
      }
    } catch (ex) {
      print('Failed to get platform version');
    }
    return null;
  }

  static saveSelectedCityObject(String cityName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_city', cityName);
  }

  static Future<String> getSelectedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('selected_city')) {
      var cityName = prefs.getString('selected_city');
      return cityName;
    } else
      return '';
  }

//   static saveCategoryListObject(List<Catgory> categoryList) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final categoryListJson = jsonEncode(categoryList);
//     await prefs.setString('catgorylist', categoryListJson);
//   }
//
//
   

}*/
