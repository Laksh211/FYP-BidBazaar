import 'package:bidbazar/controllers/category_controller.dart';
import 'package:bidbazar/controllers/product_controller.dart';
import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/data/repo/product_repo.dart';
import 'package:bidbazar/widgets/productView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

// ignore: must_be_immutable
class Category extends GetView<categoryController> {
  Category({super.key});
  // AuthenticateController categoryController = Get.put(AuthenticateController());
  @override
  categoryController controller = Get.put(categoryController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Category"),
      ),
      body: SizedBox(
        // padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
        width: size.width * 1,
        height: size.height * 1,
        child: Column(
          children: [
            Expanded(
              child: controller.obx(
                (state) {
                  return ListView.builder(
                    itemCount: controller.categoryList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          // const CircularProgressIndicator();
                          List<productModel> productList = await productRepo()
                              .fetchProductByCategory(
                                  controller.categoryList[index].sId!);
                          productList.isNotEmpty?
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => Scaffold(
                                        appBar: AppBar(
                                          elevation: 0.0,
                                          backgroundColor: Colors.white,
                                          automaticallyImplyLeading: true,
                                          foregroundColor: Colors.black,
                                          centerTitle: true,
                                          title: Text(
                                              "Category ${controller.categoryList[index].title}"),
                                        ),
                                        body: SizedBox(
                                            width: Get.width * 1,
                                            height: Get.height * 1,
                                            child: productView(
                                              productList: productList.obs,
                                            )),
                                      )))
                          :Get.snackbar("Category", "${controller.categoryList[index].title} is not availabale");
                                      
                                      
                        },
                        leading: const Icon(Icons.smartphone_outlined),
                        title: Text(
                            controller.categoryList[index].title.toString()),
                        trailing: const Icon(Icons.arrow_right),
                      );
                    },
                  );
                },
                onLoading: const Center(child: CircularProgressIndicator()),
                onEmpty: const Text("empty"),
                onError: (error) => Text(
                  error.toString(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// class CategoryProducts extends StatelessWidget {
//   const CategoryProducts({
//     super.key,
//     required this.controller,
//     required this.index
//   });
//   final int index;
//   final categoryController controller;

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       elevation: 0.0,
  //       backgroundColor: Colors.white,
  //       automaticallyImplyLeading: true,
  //       foregroundColor: Colors.black,
  //       centerTitle: true,
  //       title:  Text("Category ${controller.categoryList[index].title}"),
  //     ), 
  //     body: FutureBuilder(future:productRepo()
  //                             .fetchProductByCategory(
  //     controller.categoryList[index].sId??"") , builder: (context, snapshot) {
  //       return SizedBox(
  //           width: Get.width * 1,
  //           height: Get.height * 1,
  //           child: productView(
  //             productList: snapshot.data!.obs,
  //           ));
  //     },)
  //                             );
  // }
// }
