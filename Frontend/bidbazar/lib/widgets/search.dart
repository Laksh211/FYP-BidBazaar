import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/widgets/gridItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CustomSearch extends StatelessWidget {
  CustomSearch(
      {super.key,
      this.controller,
      required this.isScrolledColor,
      this.onChanged,
      this.OnTap,
      this.searchProducts,
      this.userType,
      this.onlySearch});

  // onlySearch = data[1]["onlySearch"];

  static const String routeName = '/customSearch';

  void Function()? OnTap;
  // var data = Get.arguments;

  TextEditingController? controller;

  bool isScrolledColor;
  final ValueChanged<String>? onChanged;
  bool? onlySearch;
  List<productModel>? searchProducts;
  String? userType;

  // Widget searchProducts(product){
  //   return
  // }

  @override
  Widget build(BuildContext context) {
    return onlySearch == true
        ? Container(

            decoration: BoxDecoration(
              boxShadow:isScrolledColor?[] : [
                BoxShadow(
   color: Colors.black.withOpacity(0.2), //color of shadow
   spreadRadius: 5, //spread radius
   blurRadius: 7, // blur radius
   offset: Offset(0, 2), // changes position of shadow
   //first paramerter of offset is left-right
   //second parameter is top to down
)
              ],
                border: Border.all(width: 1,
                 color:isScrolledColor ?
                  const Color.fromARGB(255, 0, 0, 0) :
                   Color.fromARGB(255, 255, 255, 255)),  
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Icon(Icons.search_rounded),
                ),
                Expanded(
                  flex: 5,
                  child:Text("Hi, ${AuthenticateController.userdata.first.fullname!.toUpperCase()} ${AuthenticateController.userdata.first.usertype!.toUpperCase()}"  , textScaleFactor: 0.7),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text("Search Result"),
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back),
              ),
              elevation: 0,
              backgroundColor: Colors.white60,
              foregroundColor: Colors.black54,
            ),
            body: SizedBox(
              height: Get.height * 1,
              width: Get.width * 1,
              child: GridView.builder(
                itemCount: searchProducts!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: Get.width / Get.height / .65,
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 30.0,
                ),
                itemBuilder: (context, index) {
                  productModel product = searchProducts![index];
                  return CupertinoButton(
                    onPressed: () {
                      Get.toNamed(
                        "productDetailScreen",
                        arguments: [product, userType,null,true],
                      );
                    },
                    child: gridItem(product: product, index: index),
                  );
                },
              ),
            ),
          );
  }
}
