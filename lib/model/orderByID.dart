class OrderbyID_Model {
  var id;
  // var userId;
  var productId;
  var orderDate;
  var dispatchedDate;
  var statuscode;
  var status;
  var qunt;
  late List order;
  late List<Products> product;

  OrderbyID_Model(
      {this.id,
      this.orderDate,
      this.dispatchedDate,
      this.statuscode,
      this.status,
      required this.product});
  OrderbyID_Model.fromJson(Map<dynamic, dynamic> json) {
    id = json['order_id'];
    // userId = json['order_user_id'];
    orderDate = json['order_date'];
    dispatchedDate = json['dispatch_date'];
    statuscode = json['status_id'];
    status = json['status'];
    product = json['products'];
  }
  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['order_id'] = this.id;
    data['order_date'] = this.orderDate;
    data['dispatch_date'] = this.dispatchedDate;
    //  data['order_user_id'] = this.userId;
    data['status_id'] = this.statuscode;
    data['status'] = this.status;
    data['products'] = this.product;

    return data;
  }
}

class Products {
  var id;
  var quntity;
  var dispatched_qty;
  var name;
  var rate;
  var unit;
  var packingSpecification;

  var catName;

  Products(
      {this.id,
      this.dispatched_qty,
      this.name,
      this.packingSpecification,
      this.unit,
      this.rate,
      this.catName,
      this.quntity});
  Products.fromJson(Map<dynamic, dynamic> json) {
    id = json['product_id'];
    quntity = json['ordered_qty'];
    dispatched_qty = json['dispatched_qty'];
    name = json['product_name'];
    rate = json['rate'];
    unit = json['unit'];
    packingSpecification = json['packing_specification'];
    catName = json['category_name'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['product_id'] = this.id;
    data['ordered_qty'] = this.quntity;
    data['dispatched_qty'] = this.dispatched_qty;
    data['product_name'] = this.name;
    data['rate'] = this.rate;
    data['unit'] = this.unit;
    data['packing_specification'] = this.packingSpecification;
    data['category_name'] = this.catName;

    return data;
  }
}
