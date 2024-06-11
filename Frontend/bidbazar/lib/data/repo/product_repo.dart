// import 'dart:convert';

// import 'dart:convert';

import 'package:bidbazar/core/api.dart';
import 'package:bidbazar/data/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';
// import 'package:get/get_navigation/get_navigation.dart';

class productRepo {
  Api api = Api();

  Future<productModel> createProduct({
    required String UserId,
    required String name,
    required String specs,
    required int price,
    required List<String> image,
    required String category,
    required int qty,
    required autoSoldOnPrice

  }) async {
    try {
      // FormData formData = FormData.fromMap({
      //   'user': UserId,
      //   'name': name,
      //   'specs': specs,
      //   'price': price,
      //   'images': jsonEncode(image),
      //   'category': category,
      // });

      final data = {
        "user": UserId,
        "name": name,
        "specs": specs,
        "price": price,
        "images": image,
        "category": category,
        "qty": qty,
        "saleonprice":autoSoldOnPrice
      };

      // FormData formData = FormData.fromMap(data, ListFormat.multiCompatible);

      Response response = await api.sendRequest.post("/product", data: data);

      final productResponse = ApiResponse.fromResponse(response);

      if (!productResponse.success) {
        throw productResponse.message.toString();
      }
      return productModel.fromJson(productResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<bool> addProductToWishList(String productId) async {
    try {
      Response response = await api.sendRequest
          .post("/product/wishListProduct", data: {"id": productId});

      ApiResponse productResponse = ApiResponse.fromResponse(response);
      // print(response.data);
      if (!productResponse.success) {
        throw productResponse.message.toString();
      }

      bool check = productResponse.data; // var data = response.data;
      print("check " + check.toString());
      return check;
    } catch (ex) {
      rethrow;
    }
  }

  Future RemoveProduct(productModel product,String id, String userId, String productId) async {
    try {
        print(product.images);
       await api.sendRequest.delete("/images/delete",
          data: {"images": product.images,});
  
      Response response = await api.sendRequest.post("/product/RemoveProduct",
          data: {"id": id, "userId": userId, "productId": productId});


      ApiResponse productResponse = ApiResponse.fromResponse(response);

      if (!productResponse.success) {
        throw productResponse.message.toString();
      }
      Get.snackbar("Product", productResponse.message.toString());
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<productModel>> fetchProduct() async {
    try {
      Response response = await api.sendRequest.get("/product");

      ApiResponse productResponse = ApiResponse.fromResponse(response);

      if (!productResponse.success) {
        throw productResponse.message.toString();
      }

      return (productResponse.data as List<dynamic>)
          .map((jsonObject) => productModel
              .fromJson(jsonObject)) //jsonObject.key Or jsonObject.value
          .toList(); //add all streams of json object
    } catch (ex) {
      rethrow;
    }
  }

   Future<String> renewProduct({required String productId}) async {
    try {
      Response response = await api.sendRequest.post("/product/renew",
      data: {
        "id":productId
      }
      );

      ApiResponse productResponse = ApiResponse.fromResponse(response);

      if (!productResponse.success) {
        throw productResponse.message.toString();
      }

      return productResponse.data ;//add all streams of json object
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<productModel>> fetchProductByUserId(String userId) async {
    try {
      print("id repo " + userId);

      Response response =
          await api.sendRequest.get("/product/userId/${userId}");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();//server error throw
      }

      if (apiResponse.data != null) {
        return (apiResponse.data as List<dynamic>)
            .map((json) => productModel.fromJson(json))
            .toList();
      } else
        return [];
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<productModel>> fetchProductByCategory(String catId) async {
    try {
      Response response = await api.sendRequest.get("/product/category/$catId");

      ApiResponse productResponse = ApiResponse.fromResponse(response);

      if (!productResponse.success) {
        throw productResponse.message.toString();
      }

      return (productResponse.data as List<dynamic>)
          .map((jsonObject) => productModel
              .fromJson(jsonObject)) //jsonObject.key Or jsonObject.value
          .toList(); //add all streams of json object
    } catch (ex) {
      rethrow;
    }
  }

   Future updateProduct({required String productId,required String name,required int price,required String specs,required String quantity}) async {
    try {
      Response response = await api.sendRequest.post("/product/updateProduct",
      data: {
        "productId":productId,
        "name":name,
        "price":price,
        "specs":specs,
        "quantity":quantity,
      }
      );

      ApiResponse productResponse = ApiResponse.fromResponse(response);

      if (!productResponse.success) {
        throw productResponse.message.toString();
      }

    } catch (ex) {
      rethrow;
    }
  }
   Future updateSoldQty({required String productId,required int soldqty}) async {
    try {
      Response response = await api.sendRequest.post("/product/soldqty",
      data: {
        "productId":productId,
        "soldqty":soldqty,
      }
      );

      ApiResponse productResponse = ApiResponse.fromResponse(response);

      if (!productResponse.success) {
        throw productResponse.message.toString();
      }

    } catch (ex) {
      rethrow;
    }
  }
}
