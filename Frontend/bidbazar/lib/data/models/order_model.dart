import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/data/models/user_model.dart';

class OrderModel {
  String? sId;
  String? buyer;
  List<Items>? items;

  OrderModel({this.sId, this.buyer, this.items});

  OrderModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    buyer = json['buyer'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['buyer'] = this.buyer;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? sId;
  int? totalquantity;
  int? totalprice;
  String? status;
  String? createdat;
  List<OrderedProduct>? orderedProduct;

  Items(
      {this.sId,
      this.totalquantity,
      this.totalprice,
      this.status,
      this.createdat,
      this.orderedProduct});

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    totalquantity = json['totalquantity'];
    totalprice = json['totalprice'];
    status = json['status'];
    createdat = json['createdat'];
    if (json['orderedProduct'] != null) {
      orderedProduct = <OrderedProduct>[];
      json['orderedProduct'].forEach((v) {
        orderedProduct!.add(new OrderedProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['_id'] = this.sId;
    data['totalquantity'] = this.totalquantity;
    data['totalprice'] = this.totalprice;
    // data['status'] = this.status;
    // data['createdat'] = this.createdat;
    if (this.orderedProduct != null) {
      data['orderedProduct'] =
          this.orderedProduct!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderedProduct {
  String? sId;
  int? quantity;
  productModel? productid;
  userModel? buyer;
  userModel? seller;
  int? bidprice;

  OrderedProduct(
      {this.sId, this.quantity, this.productid,this.seller, this.buyer, this.bidprice});

  OrderedProduct.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    quantity = json['quantity'];
    bidprice = json['bidprice'];

    productid = json['productid'] != null
        ? new productModel.fromJson(json['productid'])
        : null;
    json['buyer'] is String? null:
    buyer = userModel.fromJson(json['buyer']);
    json['seller'] is String? null:
    seller = userModel.fromJson(json['seller']);

    //  seller = json['seller'] != null
    // ? new userModel.fromJson(json['seller'])
    // : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['_id'] = this.sId;
    data['quantity'] = this.quantity;
    data['bidprice'] = this.bidprice;
    if (this.productid != null) {
      data['productid'] = this.productid!.toJson();
    }
    if (this.buyer != null) {
      data['buyer'] = this.buyer!.toJson();
    }
    if (this.seller != null) {
      data['seller'] = this.seller!.toJson();
    }
    return data;
  }
}

// class Productid {
//   String? sId;
//   String? user;
//   String? name;
//   int? price;
//   int? saleonprice;
//   bool? wishlist;
//   List<String>? images;
//   String? category;
//   int? qty;
//   int? soldqty;
//   String? createdat;
//   Productid(
//       {this.sId,
//       this.user,
//       this.name,
//       this.price,
//       this.saleonprice,
//       this.wishlist,
//       this.images,
//       this.category,
//       this.qty,
//       this.soldqty,
//       this.createdat});
//   Productid.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     user = json['user'];
//     name = json['name'];
//     price = json['price'];
//     saleonprice = json['saleonprice'];
//     wishlist = json['wishlist'];
//     images = json['images'].cast<String>();
//     category = json['category'];
//     qty = json['qty'];
//     soldqty = json['soldqty'];
//     createdat = json['createdat'];
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['user'] = this.user;
//     data['name'] = this.name;
//     data['price'] = this.price;
//     data['saleonprice'] = this.saleonprice;
//     data['wishlist'] = this.wishlist;
//     data['images'] = this.images;
//     data['category'] = this.category;
//     data['qty'] = this.qty;
//     data['soldqty'] = this.soldqty;
//     data['createdat'] = this.createdat;
//     return data;
//   }
// }