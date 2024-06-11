// import 'dart:ffi';

import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/controllers/image_controller.dart';
import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/data/repo/product_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class product_controller extends GetxController with StateMixin {
  RxList<productModel> productList = (List<productModel>.of([])).obs;
  RxList<productModel> favouriteProducts = (List<productModel>.of([])).obs;

  RxBool isWishListed = false.obs;
  final product_repo = productRepo();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController specController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController saleOnPriceController = TextEditingController();


  ImageController imagecontroller = Get.put(ImageController());
  RxString startLabel = 0.toString().obs;
  RxString endLabel = 100000.toString().obs;

  AuthenticateController user = Get.put(AuthenticateController());
  // favouriteProduct();
  String usertypes = "";
  @override
  void onInit() async {
    // TODO: implement onInit
    usertypes = await AuthenticateController.userdata.first.usertype!;
    // print("najeeb " + usertypes);
    await usertypes == "Buyer" ? fetchProducts() : fetchProductByUser();

    // Future.delayed(Duration(milliseconds: 5000), () {
    //   addProduct();
    //   // Do something

    // });
    super.onInit();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    priceController.dispose();
    specController.dispose();
    qtyController.dispose();
    productList.clear();
    favouriteProducts.clear();
    user.dispose();
    imagecontroller.dispose();
    super.dispose();
  }
  
  

  Future fetchProducts() async {
    try {
      change(productList, status: RxStatus.loading());

      var products = await product_repo.fetchProduct();
      productList.assignAll(products);
      // print("leght of ${productList.length} ");
      // print("last of ${productList.last} ");
      // // print("title of ${categoryList[0].sId} ");

      change(productList, status: RxStatus.success());
    } catch (ex) {
      change(productList, status: RxStatus.error(ex.toString()));
    }
  }

  Future fetchProductByUser() async {
    try {
      change(productList, status: RxStatus.loading());
      // user.usertypes
      var products = await product_repo
          .fetchProductByUserId(AuthenticateController.userdata.first.sId!);
      productList.assignAll(products);

      change(productList, status: RxStatus.success());
    } catch (ex) {
      change(productList, status: RxStatus.error(ex.toString()));
    }
  }

    Future<String?> renewProduct({required String productId}) async {
    try {
      change(productList, status: RxStatus.loading());
      // user.usertypes
      String currentDat = await product_repo
          .renewProduct(productId:productId);
      

      change(productList, status: RxStatus.success());
      return currentDat;
    } catch (ex) {
      change(productList, status: RxStatus.error(ex.toString()));
    }
  }

  Future addProduct({
    required String name,
    required String specs,
    required int price,
    required List<String> images,
    required String category,
    required int qty,
    required int autoSoldOnPrice
  }) async {
    try {
      change(productList, status: RxStatus.loading());
      var product = await product_repo.createProduct(
        UserId: AuthenticateController.userdata.first.sId!,
        name: name,
        specs: specs,
        price: price,
        image: images,
        autoSoldOnPrice:autoSoldOnPrice,
        // image: ["https://i.postimg.cc/G267pKHS/front.png"],
        category: category,
        qty: qty ,
      );

      productList.add(product);
      change(productList, status: RxStatus.success());
    } catch (ex) {
      change(productList, status: RxStatus.error(ex.toString()));
    }
  }

  Future removeProduct(productModel product, String id, String userId, String productId) async {
    try {
      change(productList, status: RxStatus.loading());

      await product_repo.RemoveProduct(product, id, userId, productId);

      change(productList, status: RxStatus.success());
    } catch (ex) {
      change(productList, status: RxStatus.error(ex.toString()));
    }
  }

  Future<bool?> wishlistProduct({
    required String productId,
  }) async {
    try {
      isWishListed.value = await product_repo.addProductToWishList(productId);
      return isWishListed.value;
      // change(productList, status: RxStatus.success());
    } catch (ex) {
      // throw ex;
      change(productList, status: RxStatus.error(ex.toString()));
    }
    return null;
  }

  void clearfields() {
    nameController.clear();
    priceController.clear();
    specController.clear();
  }
}