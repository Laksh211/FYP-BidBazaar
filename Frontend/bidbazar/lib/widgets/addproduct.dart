// import 'dart:ffi';

import 'package:bidbazar/controllers/category_controller.dart';
import 'package:bidbazar/controllers/image_controller.dart';
import 'package:bidbazar/controllers/product_controller.dart';
import 'package:bidbazar/widgets/cuproduct.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class addProduct extends GetView<ImageController> {
  addProduct({super.key});

  static const String routeName = '/addProduct';
  ImageController imgcontroller = Get.put(ImageController());
  product_controller productController = Get.put(product_controller());
  categoryController catController = Get.put(categoryController());


  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: () async {
        productController.clearfields();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black87),
            title: const Text(
              "Bidbazar",
              style: TextStyle(color: Colors.black87),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: cuProduct(isUpdate: false, imgcontroller: imgcontroller, productController: productController, catController: catController),
          persistentFooterButtons: [
            Row(
              children: [
                // Container(
                //   width: 45,
                //   height: 45,
                //   color: Colors.amber[900],
                //   child: Center(
                //     child: Text(
                //       "1",
                //       style: TextStyle(
                //           fontSize: 20,
                //           fontWeight: FontWeight.w700,
                //           color: Colors.white),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   width: 4,
                // ),

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(Get.width * 0.9, Get.height * 0.1 / 2),
                        backgroundColor: Colors.amber[900]),
                    onPressed: () async {
                      if (controller.productKey.currentState!.validate() ) {
                        await imgcontroller.upload(); //upload image to server
                        print("Product uploading started ");

                        print(productController.nameController.text);
                        print(productController.specController.text);
                        print(catController.category.value);

                        await productController.addProduct(
                          name: productController.nameController.text,
                          specs: productController.specController.text,
                          price: int.parse(productController.priceController.text),
                          images: imgcontroller.uploadImageList,
                          category: catController.category.value,
                          autoSoldOnPrice: int.parse(productController.saleOnPriceController.text),
                          qty:int.parse(productController.qtyController.text)
                        );
                        imgcontroller.imageList.clear();
                        imgcontroller.uploadImageList.clear();
                        productController.clearfields();
                        productController.saleOnPriceController.clear();
                        Get.snackbar("Product", "Product added successfully ");

                         Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      "Add Product",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]
          // : null,
          ),
    );
  }
}

