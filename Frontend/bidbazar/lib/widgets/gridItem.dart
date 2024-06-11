import 'dart:ui';

import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/controllers/cart_controller.dart';
import 'package:bidbazar/controllers/product_controller.dart';
import 'package:bidbazar/core/api.dart';
import 'package:bidbazar/data/models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class gridItem extends StatelessWidget {
  gridItem(
      {super.key,
      required this.product,
      required this.index,
      this.userType,
      this.isProductDelete,
      this.cart});
  productModel product;
  int index;
  bool? isProductDelete = false;
  String? userType;
  cartController? cart;
  // product_controller? controller;

  // cartController cart = Get.put(cartController());
  product_controller productController = Get.put(product_controller());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
       decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    
                  )
              ),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              decoration: const BoxDecoration(
                // color: Colors.grey[200],
                // borderRadius: BorderRadius.vertical(
                    // top: Radius.circular(1), bottom: Radius.circular(10)),
              ),
              child: Hero(
                tag: product.sId.toString(),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(5), bottom: Radius.circular(5)),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        "${Api.BASE_URL}/images/${product.images!.elementAt(0).toString()}",
                  ),
                  // "https://i.postimg.cc/nzdgXrFC/anh-nhat-Pd-ALQmf-Eqv-E-unsplash.jpg"
                ),
              ),
              // height: size.height * 1,
            ),
          ),
          // Divider(
          //   height: 1,
          //   thickness: 3,
          // ),
          // ListTile(
          //   // leading: ,
          
          //   // title: Text("Samung s21 ultra"),
          //   trailing: Icon(Icons.shopping_cart),
          // ),
          // Card(),
          // Padding(padding: padding),
          
          Expanded(
            flex: 2,
            child: Container(
              // width: Get.width * 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 6, 0, 3),
                    child: Text(
                      maxLines: 1,
                      product.name!,
                      // controller.productList[index].name.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Rs " + product.price.toString(),
          
                          // controller.productList[index].price.toString(),
                          style: const TextStyle(
                            // letterSpacing: 1,
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            // color: Colors.orange[900],
                          ),
                          maxLines: 1,
                        ),
                      ),
                      InkWell(
                        onTap: () async{
                          //Please ensure that the item is in your cart before adding it. => not implemented
                          userType == "Buyer"
                              ? {
                                   cart!.addToCart(product, 1),                      
                                  cart!.carStateSuccess(),
                                  Get.snackbar("Add to cart",
                                      "Product added to your cart")
                                }
                              : null;
                          isProductDelete == true
                              ? {
                                  productController.removeProduct(
                                       product,
                                      product.sId.toString(),
                                      AuthenticateController
                                          .userdata.first.sId!,
                                      product.sId!),
                                  productController.productList.removeAt(index),
                                }
                              : null;
                        },
                        child: userType == "Buyer"
                            ? Icon(
                                Icons.shopping_cart,
                                color: Colors.grey[500],
                              )
                            : isProductDelete == true
                                ? Icon(
                                    Icons.delete,
                                    color: Colors.grey[500],
                                  )
                                : SizedBox.shrink(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
