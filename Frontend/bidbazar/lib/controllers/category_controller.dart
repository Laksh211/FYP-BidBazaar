import 'package:bidbazar/data/models/category_model.dart';
import 'package:bidbazar/data/repo/category_repo.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class categoryController extends GetxController with StateMixin {
  final category_repo = categoryRepo();

  // var categoryList = List<categoryModel>().obs;
  // List<categoryModel> categoryList = <categoryModel>[].obs;
  RxString ErrorMessage = "".obs;

  // List<DropdownMenuItem<String>> categoryItems =
  //     RxList(<DropdownMenuItem<String>>[].obs);
  RxList<DropdownMenuItem> categoryItems = (List<DropdownMenuItem>.of([])).obs;
  RxString category = "6556628c382b1a3cca976166".obs;

  RxList<categoryModel> categoryList = (List<categoryModel>.of([])).obs;

  @override
  void onInit() async {
    await fetchCategories();

    for (var a in categoryList) {
      print(a.title);
      categoryItems
          .add(DropdownMenuItem(child: Text("${a.title}"), value: "${a.sId}"));
    }

    super.onInit();
  }

  Future fetchCategories() async {
    try {
      change(categoryList, status: RxStatus.loading());
      var category = await category_repo.fetchCategory();
      categoryList.assignAll(category);
      // print("leght of ${categoryList.length} ");
      // print("last of ${categoryList.last} ");
      // print("title of ${categoryList[0].title} ");
      // print("title of ${categoryList[0].sId} ");

      change(categoryList, status: RxStatus.success());
    } catch (ex) {
      ErrorMessage.value = ex.toString();
      change(categoryList, status: RxStatus.error(ex.toString()));
    }
  }
}
