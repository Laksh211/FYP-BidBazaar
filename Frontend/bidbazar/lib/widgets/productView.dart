import 'dart:ui';

import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/controllers/cart_controller.dart';
import 'package:bidbazar/controllers/product_controller.dart';
import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/widgets/gridItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class productView extends GetView<product_controller> {
  productView(
      {super.key, required this.productList, this.cart, this.isProductDelete});
  // product_controller controller;
  RxList<productModel> productList = (List<productModel>.of([])).obs;
  bool? isProductDelete;
  cartController? cart;

  // AuthenticateController user = Get.put(AuthenticateController());

  // String userType =
  //       user.userdata.first.usertype.toString() == "Buyer" ? "Buyer" : "Seller";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return controller.obx(
      (state) => RefreshIndicator(
        onRefresh: () async {
          // controller.fetchProducts();
          imageCache.clear();
          imageCache.clearLiveImages();
          controller.update();
        },
        child: GridView.builder(
          itemCount: productList.length,
          // padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: size.width / size.height / .61,
            crossAxisCount: 2,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
          itemBuilder: (context, index) {
            productModel product = productList[index];

            return CupertinoButton(
              onPressed: () {
                // print("working");
                // print(productList);
                product.soldqty == product.qty
                    ? null
                    : Get.toNamed(
                        "productDetailScreen",
                        arguments: [
                          productList[index],
                          AuthenticateController.userdata.first.usertype,
                          // controller,
                          null,
                          true,
                          // index
                        ],
                      );
              },
              child:
               
               product.qty == product.soldqty
                  ? Stack(
                      children: [
                       
                        CupertinoButton(
                          onPressed: () {
                            Get.snackbar("Product", "product is sold");
                          },
                          child: gridItem(
                            cart: cart,
                            isProductDelete: isProductDelete,
                            product: product,
                            index: index,
                            userType:
                                AuthenticateController.userdata.first.usertype,
                          ),
                        ),
                        ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                            child: const SizedBox(
                              height: 220,
                              width: 150,
                            ),
                          ),
                        ),
                        const Card(
                            margin: EdgeInsets.all(5),
                            child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  "Sold out",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ))),
                       
                      ],
                    )
                  : gridItem(
                      cart: cart,
                      isProductDelete: isProductDelete,
                      product: product,
                      index: index,
                      userType: AuthenticateController.userdata.first.usertype,
                    ),
            );
          },
        ),
      ),
      // onLoading: ,
      onEmpty: const Text(
        "There is no product to display",
      ),
      onError: (error) => Center(child: Text("${error}")),
    );
  }
}
