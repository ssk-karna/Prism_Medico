class User_Registration {
  var id;
  var name;
  var email;
  var fullname;
  var password;
  var pharmacyname;
  var address;
  var city;
  var district;
  var disName;
  var pincode;
  var state;
  var stateName;
  var phone;
  var image_name;
  var img_url;
  var user_image;
  var otp;

  User_Registration(
      {this.id,
      this.name,
      this.email,
      this.fullname,
      this.password,
      this.address,
      this.city,
      this.district,
      this.disName,
      this.pharmacyname,
      this.phone,
      this.pincode,
      this.state,
      this.stateName,
      this.image_name,
      this.img_url,
      this.user_image,
      this.otp});
  User_Registration.fromJson(Map<dynamic, dynamic> json) {
    id = json['user_id'];
    name = json['user_name'];
    fullname = json['full_name'];
    pharmacyname = json['pharmacy_name'];
    address = json['address'];
    city = json['city'];
    district = json['district'];
    disName = json['disctrict_name'];
    pincode = json['pincode'];
    state = json['state'];
    stateName = json['state_name'];
    phone = json['phone'];
    email = json['email_id'];
    password = json['password'];
    image_name = json['image_name'];
    img_url = json['base64Image'];
    user_image = json['user_image'];
    otp = json['otp'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['user_id'] = this.id;
    data['user_name'] = this.name;
    data['full_name'] = this.fullname;
    data['pharmacy_name'] = this.pharmacyname;
    data['address'] = this.address;
    data['city'] = this.city;
    data['district'] = this.district;
    data['disctrict_name'] = this.disName;
    data['pincode'] = this.pincode;
    data['state'] = this.state;
    data['state_name'] = this.stateName;
    data['phone'] = this.phone;
    data['email_id'] = this.email;
    data['password'] = this.password;
    data['image_name'] = this.image_name;
    data['base64Image'] = this.img_url;
    data['user_image'] = this.user_image;
    data['otp'] = this.otp;

    return data;
  }
}
