import 'package:bidbazar/controllers/category_controller.dart';
import 'package:bidbazar/controllers/image_controller.dart';
import 'package:bidbazar/controllers/product_controller.dart';
import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/data/repo/product_repo.dart';
import 'package:bidbazar/widgets/cuproduct.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';



class UpdateProduct extends StatelessWidget {
   UpdateProduct({super.key,required this.product});

 final ImageController imgcontroller = Get.put(ImageController());
 final product_controller productController = Get.put(product_controller());
 final categoryController catController = Get.put(categoryController());
 late productModel product;
 productRepo repo= productRepo();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: cuProduct(product: product, 
      imgcontroller: imgcontroller,
      productController: productController,
      catController: catController, 
      isUpdate: true
      
      ) ,
      persistentFooterButtons: [
       ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(Get.width * 0.4, Get.height * 0.1 / 2),
                        backgroundColor: Colors.amber[900],
                      ),
                      onPressed: ()async {
                         
                        product.name=productController.nameController.text;
                        product.price=int.parse(productController.priceController.text);   
                        product.specs=productController.specController.text;

                        repo.updateProduct(productId: product.sId!, name: productController.nameController.text, price: int.parse(productController.priceController.text), specs: productController.specController.text, quantity:productController.qtyController.text, );
                        Navigator.pop(context);
                      },
              
                      child:    const Text(
                              "Save Product",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                      
                    ),


      ],
    );
  }
}