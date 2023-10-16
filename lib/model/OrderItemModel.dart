class orderItem_Model {
  String productId;

  String qunt;

  orderItem_Model({this.productId, this.qunt});
  orderItem_Model.fromJson(Map<dynamic, dynamic> json) {
    productId = json['product_id'];
    qunt = json['ordered_qty'];
  }
  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();

    data['product_id'] = this.productId;
    data['ordered_qty'] = this.qunt;

    return data;
  }
}
