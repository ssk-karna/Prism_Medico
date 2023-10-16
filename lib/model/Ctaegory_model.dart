class category_model {
  var id;
  var name;
  var imageName;
  var catDesc;
  var catImage;
  var userId;
  var del_flag;

  category_model(
      {this.id,
      this.name,
      this.userId,
      this.catDesc,
      this.catImage,
      this.imageName,
      this.del_flag});

  category_model.fromJson(Map<dynamic, dynamic> json) {
    id = json['category_id'];
    name = json['category_name'];
    imageName = json['image_name'];
    catDesc = json['category_description'];
    catImage = json['category_image'];
    userId = json['user_id'];
    del_flag = json['del_flag'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['category_id'] = this.id;
    data['category_name'] = this.name;
    data['image_name'] = this.imageName;
    data['category_description'] = this.catDesc;
    data['category_image'] = this.catImage;
    data['user_id'] = this.userId;
    data['del_flag'] = this.del_flag;

    return data;
  }
}
