class Latest_Product_model {
  var id;
  var name;
  var catId;
  var composition;
  var packingSpecification;
  var productDetail;
  var unit;
  var rate;
  var type;
  var stock;
  var userId;
  var catName;
  var productImage;
  var quntity;

  Latest_Product_model(
      {this.id,
      this.name,
      this.productDetail,
      this.catId,
      this.composition,
      this.packingSpecification,
      this.unit,
      this.rate,
      this.type,
      this.stock,
      this.userId,
      this.catName,
      this.productImage,
      this.quntity});
  Latest_Product_model.fromJson(Map<dynamic, dynamic> json) {
    id = json['product_id'];
    name = json['product_name'];
    catId = json['category_id'];
    composition = json['composition'];
    packingSpecification = json['packing_specification'];
    productDetail = json['product_details'];
    unit = json['unit'];
    rate = json['rate'];
    type = json['product_type'];
    stock = json['stock'];
    userId = json['user_id'];
    catName = json['category_name'];
    productImage = json['productImages'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['product_id'] = this.id;
    data['product_name'] = this.name;
    data['category_id'] = this.catId;
    data['composition'] = this.composition;
    data['packing_specification'] = this.packingSpecification;
    data['product_details'] = this.productDetail;
    data['unit'] = this.unit;
    data['rate'] = this.rate;
    data['product_type'] = this.type;
    data['stock'] = this.stock;
    data['user_id'] = this.userId;
    data['category_name'] = this.catName;
    data['productImages'] = this.productImage;
    return data;
  }
}
