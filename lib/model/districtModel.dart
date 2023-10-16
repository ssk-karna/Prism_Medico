class District_Model {
  var id;
  var state_id;
  var dist_name;

  District_Model({
    this.id,
    this.state_id,
    this.dist_name,
  });
  District_Model.fromJson(Map<dynamic, dynamic> json) {
    id = json['district_id'];
    state_id = json['state_id'];
    dist_name = json['disctrict_name'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['district_id'] = this.id;
    data['state_id'] = this.state_id;
    data['disctrict_name'] = this.dist_name;

    return data;
  }
}
