import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/data/models/user_model.dart';

class BidModel {
  BidModel({
  this.seller,
     this.buyer, this.items});

 BidModel.fromJson(Map<String, dynamic> json) {
  buyer = json['buyer'];

  if (json['seller'] is String) {
    // If 'seller' is a string, assume it's the ID of the seller
    seller = userModel(id: json['seller']);
  } else if (json['seller'] is Map<String, dynamic>) {
    // If 'seller' is a map, parse it as a userModel object
    seller = userModel.fromJson(json['seller']);
  }

  if (json['items'] != null) {
    items = <Items>[];
    json['items'].forEach((v) {
      items!.add(new Items.fromJson(v));
    });
  }
}

  userModel? seller;
  String? buyer;
  List<Items>? items;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buyer'] = this.buyer;
    data['seller'] = this.seller;

    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  Items({this.product, this.quantity, this.status, this.sId ,
  this.bidprice,
        this.createdat

  });

  Items.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? new productModel.fromJson(json['product']) : null;
    quantity = json['quantity'];
    bidprice = json['bidprice'];

    status = json['status'];
    sId = json['_id'];
    // json['createdat']==""? createdat = json['createdat']:null;

  }

  int? bidprice;
  productModel? product;
  int? quantity;
  String? sId;
  String? status;
  String? createdat;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['quantity'] = this.quantity;
    data['bidprice'] = this.bidprice;

    data['status'] = this.status;
    data['_id'] = this.sId;
    this.createdat==""?
    data['createdat'] = this.createdat:null;
    // data['createdat'] = this.createdat;
    return data;
  }
}

// class Product {
//   String? sId;
//   String? user;
//   String? name;
//   String? specs;
//   int? bidprice;
//   List<String>? images;
//   String? category;
//   int? iV;
//   bool? wishlist;

//   Product(
//       {this.sId,
//       this.user,
//       this.name,
//       this.specs,
//       this.bidprice,
//       this.images,
//       this.category,
//       this.iV,
//       this.wishlist});

//   Product.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     user = json['user'];
//     name = json['name'];
//     specs = json['specs'];
//     bidprice = json['bidprice'];
//     images = json['images'].cast<String>();
//     category = json['category'];
//     iV = json['__v'];
//     wishlist = json['wishlist'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['user'] = this.user;
//     data['name'] = this.name;
//     data['specs'] = this.specs;
//     data['bidprice'] = this.bidprice;
//     data['images'] = this.images;
//     data['category'] = this.category;
//     data['__v'] = this.iV;
//     data['wishlist'] = this.wishlist;
//     return data;
//   }
// }