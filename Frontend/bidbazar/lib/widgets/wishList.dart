import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/controllers/wishList_controller.dart';
// import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/widgets/gridItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishList extends GetView<WishListController> {
  WishList({super.key});

  static const String routeName = '/wishListScreen';

  // final productController = Get.put(product_controller());
  @override
  final WishListController controller = Get.put(WishListController());

  // void favouriteProduct() {
  //   controller.favouriteProducts.clear();
  //   controller.productList.forEach((element) {
  //     if (element.wishlist == true) {
  //       controller.favouriteProducts.add(element);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // favouriteProduct();
    // print("state update");
    return Scaffold(
      appBar: AppBar(
        title: const Text("WishList"),
        elevation: 0,
        foregroundColor: Colors.black54,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      // drawer: Drawer(),
      body: controller.obx(
        (state) => Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: controller.wishlist.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: Get.width / Get.height / .65,
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 30.0,
                ),
                itemBuilder: (context, index) {
                  // print("state update");

                  // productModel product = productModel.fromJson(
                  // controller.wishlist[index].product as Map<String, dynamic>);
                  // print(index);
                  return CupertinoButton(
                    onPressed: () {
                      Get.toNamed(
                        "productDetailScreen",
                        arguments: [
                          
                          controller.wishlist[index].product!,
                          AuthenticateController.userdata.first.usertype,
                          controller,
                          false,
                        ],
                      );
                    },
                    // child: Text("dw"),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        gridItem(
                        product: controller.wishlist[index].product!,
                        // product: productController.favouriteProducts[index],
                        index: index,
                        isProductDelete: false,
                        userType: AuthenticateController.userdata.first.usertype,
                        // userType: controller.user.usertypes.toString(),
                      ),

                      InkWell(
                        
                        
                        onTap: () {
                           controller.Favourite(
                              // add and delete functionality
                              controller.wishlist[index].product!,
                              controller.wishlist[index].product!.sId.toString(),
                            );
                          controller.wishlist.removeAt(index);
                          
                          controller.update();

                         
                          
                        },
                        child: 
                          
                          const Icon(Icons.delete , color: Color.fromARGB(180, 200, 200, 200),shadows: [
                            Shadow(
                              color:Colors.white12,
                              blurRadius: 25,
                              
                            )
                          ],))

                      ],
                     
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        onEmpty: const Center(child: Text("WishList is Empty")),
      ),
    );
  }
}
