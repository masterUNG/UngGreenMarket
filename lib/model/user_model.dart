class UserModel {
  String id;
  String chooseType;
  String name;
  String surname;
  String username;
  String password;
  String houseno;
  String villageNo;
  String subdistrict;
  String district;
  String province;
  String postalcode;
  String tel;
  String name1;
  String storename;
  String address;
  String phone;
  String urlImage;
  String token;

  UserModel(
      {this.id,
      this.chooseType,
      this.name,
      this.surname,
      this.username,
      this.password,
      this.houseno,
      this.villageNo,
      this.subdistrict,
      this.district,
      this.province,
      this.postalcode,
      this.tel,
      this.name1,
      this.storename,
      this.address,
      this.phone,
      this.urlImage,
      this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chooseType = json['chooseType'];
    name = json['name'];
    surname = json['surname'];
    username = json['username'];
    password = json['password'];
    houseno = json['houseno'];
    villageNo = json['villageNo'];
    subdistrict = json['subdistrict'];
    district = json['district'];
    province = json['province'];
    postalcode = json['postalcode'];
    tel = json['tel'];
    name1 = json['name1'];
    storename = json['storename'];
    address = json['address'];
    phone = json['phone'];
    urlImage = json['urlImage'];
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chooseType'] = this.chooseType;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['username'] = this.username;
    data['password'] = this.password;
    data['houseno'] = this.houseno;
    data['villageNo'] = this.villageNo;
    data['subdistrict'] = this.subdistrict;
    data['district'] = this.district;
    data['province'] = this.province;
    data['postalcode'] = this.postalcode;
    data['tel'] = this.tel;
    data['name1'] = this.name1;
    data['storename'] = this.storename;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['urlImage'] = this.urlImage;
    data['Token'] = this.token;
    return data;
  }
}

