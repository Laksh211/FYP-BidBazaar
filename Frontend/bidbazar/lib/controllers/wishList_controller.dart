import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/data/models/product_model.dart';
// import 'package:bidbazar/data/models/product_model.dart';
// import 'package:bidbazar/data/models/user_model.dart';
import 'package:bidbazar/data/models/wishListModel.dart';
// import 'package:bidbazar/data/repo/cart_repo.dart';
import 'package:bidbazar/data/repo/wishList_repo.dart';
// import 'package:bidbazar/widgets/wishList.dart';
import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';

// bool isDataFetch = false;

class WishListController extends GetxController with StateMixin {
  RxList<wishListModel> wishlist = (List<wishListModel>.of([])).obs;

  wishListRepo wishlistrepo = wishListRepo();

  AuthenticateController user = AuthenticateController();
  // AuthenticateController user = Get.put(AuthenticateController());

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    fetchWishListItems();
    // isDataFetch == false ? fetchWishListItems() : isDataFetch = true;
    // fetchCartItems();
    // isDataFetch = true;
    // print("isData " + isDataFetch.toString());
  }

  @override
  void onClose() {
    // TODO: implement onClose
       wishlist.clear();
    super.onClose();
  }
  // @override
  void dispose() {
    // TODO: implement dispose
    user.dispose();
    wishlist.clear();
    super.dispose();
  }

  Future fetchWishListItems() async {
    try {
      
       wishlist.clear();
      change(wishlist, status: RxStatus.loading());
      // String id = user.userdata.first.sId.toString();
      // print(wishlist);
      // print(user.userdata.first.sId.toString());
      var wishList = await wishlistrepo
          .fetchWishList(AuthenticateController.userdata.first.sId.toString());
      print(wishlist.isEmpty);
      print("object working");


      wishlist.assignAll(wishList);
      
       if(wishlist.isEmpty){
      change(wishlist, status: RxStatus.empty() ,);
      }else {
      
      change(wishlist, status: RxStatus.success());
      }
    } on DioException catch (ex) {
      change(wishlist, status: RxStatus.error(ex.toString()));
    }
  }




//unused function
  Favourite(productModel product, String productId) async {
    // add and delete
    try {
      wishListModel item = wishListModel(
          product: product,
          user: AuthenticateController.userdata.first.sId
              .toString()); // object id will generate auto

      await wishlistrepo.wishListItem(
          productId, AuthenticateController.userdata.first.sId.toString());

      // wishlist.add(item);
      
      print("wishlist item");
      print(wishlist);
      // ignore: unused_catch_clause
    } on DioException catch (ex) {
      rethrow;
    }
  }
}
