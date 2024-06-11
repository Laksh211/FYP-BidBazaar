import 'package:bidbazar/data/models/product_model.dart';

class wishListModel {
  String? sId;
  String? user;
  productModel? product;

  wishListModel({this.sId, this.user, this.product});

  wishListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    product = productModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = this.user;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}
