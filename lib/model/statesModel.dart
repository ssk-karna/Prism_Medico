class State_Model {
  var id;
  var state_name;

  State_Model({
    this.id,
    this.state_name,
  });
  State_Model.fromJson(Map<dynamic, dynamic> json) {
    id = json['state_id'];
    state_name = json['state_name'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['state_id'] = this.id;
    data['state_name'] = this.state_name;

    return data;
  }
}
