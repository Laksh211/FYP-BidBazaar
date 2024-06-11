import 'package:bidbazar/controllers/category_controller.dart';
import 'package:bidbazar/controllers/image_controller.dart';
import 'package:bidbazar/controllers/product_controller.dart';
import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/widgets/customTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';





class cuProduct extends StatelessWidget { // create and update product screen
   cuProduct({
    super.key,
    required this.imgcontroller,
    required this.productController,
    required this.catController,
    required this.isUpdate,
     this.product
  });

  final ImageController imgcontroller;
  final product_controller productController;
  final categoryController catController;
  final bool isUpdate;
  final productModel? product;
  
  
  
  
  @override
  Widget build(BuildContext context) {
    isUpdate==true?{
      imgcontroller.imageList.addAll(product!.images!),
      productController.nameController.text=product!.name!,
      productController.priceController.text=product!.price.toString(),
      
      productController.specController.text=product!.specs!,


    }:null;
    return Container(
      child: Form(
        key: imgcontroller.productKey,
        child: ListView(
          children: [
            Card(
              semanticContainer: true,
              child: Container(
                width: Get.width * 0.9,
                height: Get.height * 0.4 / 1.2,
                child: Center(
                  child: TextButton.icon(
                    onPressed: () {
                      imgcontroller.pickImages();//pick images
                    },
                    icon: const Icon(
                      Icons.upload_file,
                      color: Colors.black38,
                    ),
                    label: Obx(
                      () => Text(
                        "Images ${imgcontroller.imageList.length}",
                        style: const TextStyle(
                          fontSize: 20,
                          wordSpacing: 2,
                          color: Colors.black38,
                          leadingDistribution:
                              TextLeadingDistribution.proportional,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Divider(
              height: 5,
              thickness: 10,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 5,
                    // margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: customTextFormField(
                        controller: productController.nameController,
                        labelText: 'Product Name',
                        // hintText: 'Email Address',
                        prefixIconData: Icons.phone_android,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autofocus: false,
                        validator: (value) {
                          return value!.isEmpty
                              ? "Name can not be empty"
                              : null;

                          // return controller.validateEmail(value!);
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    elevation: 5,
                    // margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: customTextFormField(
                        controller: productController.priceController,
                        labelText: 'Product Price',
                        prefixIconData: Icons.payment,
                        // hintText: 'Email Address',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        autofocus: false,
                        validator: (value) {
                          return value!.isEmpty
                              ? "Price can not be empty"
                              : null;
                          // return controller.validateEmail(value!);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 20,
                        wordSpacing: 2,
                        leadingDistribution:
                            TextLeadingDistribution.proportional,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: productController.specController,
                      minLines: 5,
                      maxLines: 20,
                      // inputFormatters: [],
                      validator: (value) {
                        return value!.isEmpty
                            ? "Name can not be empty"
                            : null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Category",
                    style: TextStyle(
                      fontSize: 20,
                      wordSpacing: 2,
                      leadingDistribution:
                          TextLeadingDistribution.proportional,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                   const Spacer(
                    flex: 1,
                  ),
                   Obx(
                    () => DropdownButton(
                  enableFeedback: true,
                  value: catController.category.value,
                  items: catController.categoryItems,
                  onChanged: (value) {
                    catController.category.value = value!;
                    // print(value);
                    // catController.update();
                  },
                    ),
                  ),
                 
                 const Spacer(
                    flex: 10,
                  ),
                  

                  
                ],
              ),
            ),
             Card(
              elevation: 5,
              margin: const EdgeInsets.all(10),
               child: Container(
                      // width: 150,
                       child: customTextFormField(
                            controller: productController.qtyController,
                            labelText: 'Product QTY',
                            prefixIconData: Icons.production_quantity_limits_outlined,
                            // hintText: 'Email Address',
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            autofocus: false,
                            validator: (value) {
                              return value!.isEmpty
                                  ? "Qty can not be empty"
                                  : null;
                              // return controller.validateEmail(value!);
                            },
                          ),
                     ),
             ),
             Card(
              elevation: 5,
              margin: const EdgeInsets.all(10),
               child: customTextFormField(
                    controller: productController.saleOnPriceController,
                    labelText: 'Product Auto Sold price',
                    prefixIconData: Icons.price_check,
                    // hintText: 'Email Address',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    autofocus: false,
                    validator: (value) {
                      return value!.isEmpty
                          ? "Item Sold price can not be empty"
                          : int.parse(productController.saleOnPriceController.text) < int.parse(productController.priceController.text)?null:"sold price is not greater then actual price ";
                      // return controller.validateEmail(value!);
                    },
                  ),
             ),
          ],
        ),
      ),
    );
  }
}
