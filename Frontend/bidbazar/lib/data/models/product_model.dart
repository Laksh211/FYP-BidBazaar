class productModel {
  String? sId;
  String? user;
  String? name;
  String? specs;

  int? price;
  bool? wishlist;
  List<String>? images;
  String? category;
  int? qty;
  int? soldqty;
  int? saleonprice;
  String? createdat;

  productModel(
      {this.sId,
      this.user,
      this.name,
      this.specs,
      this.price,
      this.wishlist,
      this.images,
      this.category,
      this.qty,
      this.saleonprice,
      this.soldqty,
        this.createdat
      });

  productModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    name = json['name'];
    specs = json['specs'];
    price = json['price'];
    wishlist = json['wishlist'];
    images = json['images'].cast<String>();
    category = json['category'];
    qty = json['qty'];
    soldqty = json['soldqty'];
    saleonprice = json['saleonprice'];
    createdat = json['createdat'] ?? "";

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['name'] = this.name;
    data['specs'] = this.specs;
    data['price'] = this.price;
    data['wishlist'] = this.wishlist;
    data['images'] = this.images;
    data['category'] = this.category;
    data['qty'] = this.qty;
    data['soldqty'] = this.soldqty;
    data['saleonprice'] = this.saleonprice;
    return data;
  }
  
}