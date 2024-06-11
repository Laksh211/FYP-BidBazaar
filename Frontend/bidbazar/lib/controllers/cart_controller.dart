import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/data/models/cart_model.dart';
import 'package:bidbazar/data/models/product_model.dart';
// import 'package:bidbazar/data/models/user_model.dart';
import 'package:bidbazar/data/repo/cart_repo.dart';
import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';

class cartController extends GetxController with StateMixin {
  RxList<cartModel> cartlist = (List<cartModel>.of([])).obs;
  cartRepo cart = cartRepo();
  RxDouble totalAmount = 0.0.obs;
  // RxInt totalQty = 0.obs;
  int totalQty = 0;
  RxInt qty = 0.obs;

  AuthenticateController user = Get.put(AuthenticateController());

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
      AuthenticateController.userdata.first.usertype=='Buyer'?
    fetchCartItems():null;
  }

  Future fetchCartItems() async {
    try {
      change(cartlist, status: RxStatus.loading());
      // String id = user.userdata.first.sId.toString();

      var cartItems =
          await cart.fetchCart(AuthenticateController.userdata.first.sId!);
      // print("cart all Items");
      // print(cartItems);
      cartlist.assignAll(cartItems);
      cartlist.refresh();
      if(cartlist.isEmpty){
      change(cartlist, status: RxStatus.empty() ,);
      }else {
        cartTotalAmount();
        carStateSuccess();
      // change(cartlist, status: RxStatus.success());
      }
    } on DioException catch (ex) {
      change(cartlist, status: RxStatus.error(ex.toString()));
    }
  }

  void carStateSuccess(){
      change(cartlist, status: RxStatus.success());
  }
   void carStateEmpty(){
      change(cartlist, status: RxStatus.empty());
  }
 

  cartTotalAmount() {
    totalAmount.value = 0.0;
    totalQty = 0;
    cartlist.forEach(
      // ignore: unnecessary_set_literal
      (element) => {
        print(totalQty),

        print(element.quantity!),
        totalQty=totalQty + element.quantity!,
        print(totalQty),

        // print("price " + cartlist.first.product!.price.toString()),
        totalAmount.value +=
            element.product!.price!.toDouble() * element.quantity!.toDouble(),
      },
    );

    // ignore: prefer_interpolation_to_compose_strings
    print("total cart price " + totalAmount.value.toString());
    print("total cart qty ${totalQty}");

  }

  void addToCart(productModel product, int Quantity) async {
    try {
      print("newCart 1");
      print(product.price);
      cartModel item = cartModel(
          product: product, quantity: Quantity); // object id will generate auto
      print(item.product!.price);
      var cartItems = await cart.addToCart(
          item, AuthenticateController.userdata.first.sId!);

       cartlist.assignAll(cartItems);
      cartTotalAmount();
      // ignore: unused_catch_clause
    } on DioException catch (ex) {
      rethrow;
    }
  }

  void removeItemfromCart(String productId) async {
    try {
      await cart.removeFromCartItem(
          productId, AuthenticateController.userdata.first.sId!);

      // cartlist.assignAll(cartItems);

      cartTotalAmount();

      Get.snackbar("Cart", "Cart item delete successfully");
      // ignore: unused_catch_clause
    } on DioException catch (ex) {
      rethrow;
    }
  }

  void removeAllFromCart() async {
    try {
      await cart.removeAllFromCart(
           AuthenticateController.userdata.first.sId!);
      cartlist.clear();
      qty.value = 0;
      totalAmount.value=0;
      totalQty=0;
      Get.snackbar("Cart", "Cart items delete successfully");
      // ignore: unused_catch_clause
    } on DioException catch (ex) {
      rethrow;
    }
  }


}