class order_Model {
  var id;
  var userId;
  var productId;
  var orderDate;
  var status;
  var status_Id;
  var qunt;
  List<Order> order;
  List product;

  order_Model(
      {this.id,
      this.productId,
      this.userId,
      this.orderDate,
      this.status,
      this.status_Id,
      this.order,
      this.qunt,
      this.product});
  order_Model.fromJson(Map<dynamic, dynamic> json) {
    id = json['order_id'];
    userId = json['order_user_id'];
    orderDate = json['order_date'];
    status = json['status'];
    status_Id = json['status_id'];
    productId = json['product_id'];
    qunt = json['ordered_qty'];
    order = json['order'];
    product = json['products'];
  }
  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['order_id'] = this.id;
    data['order_user_id'] = this.userId;
    data['order_date'] = this.orderDate;
    data['status_id'] = this.status_Id;
    data['status'] = this.status;
    data['product_id'] = this.productId;
    data['ordered_qty'] = this.qunt;
    data['order'] = this.order;
    data['products'] = this.product;

    return data;
  }
}

class Order {
  var productId;
  var qunt;

  Order({
    this.productId,
    this.qunt,
  });
  Order.fromJson(Map<dynamic, dynamic> json) {
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

// class Products {
//   var id;
//   var quntity;
//   var dispatched_qty;
//   var name;
//   var rate;
//   var unit;
//   var packingSpecification;

//   var catName;

//   Products(
//       {this.id,
//       this.dispatched_qty,
//       this.name,
//       this.packingSpecification,
//       this.unit,
//       this.rate,
//       this.catName,
//       this.quntity});
//   Products.fromJson(Map<dynamic, dynamic> json) {
//     id = json['product_id'];
//     quntity = json['ordered_qty'];
//     dispatched_qty = json['dispatched_qty'];
//     name = json['product_name'];
//     rate = json['rate'];
//     unit = json['unit'];
//     packingSpecification = json['packing_specification'];
//     catName = json['category_name'];
//   }

//   Map<dynamic, dynamic> toJson() {
//     final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
//     data['product_id'] = this.id;
//     data['ordered_qty'] = this.quntity;
//     data['dispatched_qty'] = this.dispatched_qty;
//     data['product_name'] = this.name;
//     data['rate'] = this.rate;
//     data['unit'] = this.unit;
//     data['packing_specification'] = this.packingSpecification;
//     data['category_name'] = this.catName;

//     return data;
//   }
// }
