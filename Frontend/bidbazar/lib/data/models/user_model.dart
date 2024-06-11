class userModel {
  String? sId;
  String? fullname;
  String? email;
  String? mobile;
  String? cnic;
  String? address;
  String? password;
  String? usertype;
  String? id;
  bool? block;
  bool? verification;
  List<String>? cnicimages;
  List<String>? profileimages;

  userModel(
      {this.sId,
      this.fullname,
      this.email,
      this.mobile,
      this.cnic,
      this.address,
      this.password,
      this.usertype,
      this.id,
      this.block,
      this.verification,
      this.profileimages,
      this.cnicimages
      });

  userModel.fromJson(Map<String, dynamic> json) {
    //return method
    sId = json['_id'];
    fullname = json['fullname'];
    email = json['email'];
    mobile = json['mobile'];
    cnic = json['cnic'];
    address = json['address'];
    password = json['password'];
    usertype = json['usertype'];
    id = json['id'];
    block = json['block'];
    verification = json['verification'];
    profileimages = json['profileimages'].cast<String>();
    cnicimages = json['cnicimages'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    // set method
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['cnic'] = this.cnic;
    data['address'] = this.address;
    data['password'] = this.password;
    data['usertype'] = this.usertype;
    data['id'] = this.id;
    data['block'] = this.block;
    data['verification'] = this.verification;
    return data;
  }
}
