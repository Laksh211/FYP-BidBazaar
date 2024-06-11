import 'package:bidbazar/data/models/product_model.dart';

class cartModel {
  // cart item model we already have user id from auth
  productModel? product;
  int? quantity;
  String? sId;

  cartModel({this.product, this.quantity, this.sId});

  cartModel.fromJson(Map<String, dynamic> json) {
    //convert json object into dart and returndart object
    product = productModel.fromJson(json["product"]);
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    //for set dart object into json object
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product?.sId;
    data['quantity'] = this.quantity;
    data['_id'] = this.sId;
    return data;
  }
}