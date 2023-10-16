import 'package:prism_medico/model/latestProduct.dart';

class ProductsVM {
  List<Latest_Product_model> lst = List<Latest_Product_model>();

  add(String id, String name, String detail, String specification, String stock,
      String quntity) {
    lst.add(Latest_Product_model(
        catId: id,
        name: name,
        packingSpecification: specification,
        productDetail: detail,
        stock: stock,
        unit: quntity));
  }

  del(int index) {
    lst.removeAt(index);
  }
}
