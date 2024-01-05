import 'package:prism_medico/model/User.dart';
import 'package:prism_medico/model/latestProduct.dart';
import 'package:prism_medico/model/order_Model.dart';

User_Registration userDetails = User_Registration();
Latest_Product_model productDetail = Latest_Product_model();
List<Latest_Product_model> proList = List<Latest_Product_model>();
order_Model orderDetail = order_Model();
List<order_Model> orderDetailS = List<order_Model>();

class Constants {
  static const BASE_URL = 'https://mktourtravel.com/prism/ServerSide/';
  static const razorpay_key = "rzp_test_5u5gBcl3DCTojr";

  static const NO_INTERNET_ERROR = 'No internet connection avaliable.';
  static const TRY_AGAIN = 'Error occur. Please try again';
  String rupee = "\u20B9";
}
