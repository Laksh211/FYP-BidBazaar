import 'dart:convert';

import 'package:bidbazar/core/api.dart';
// import 'package:bidbazar/data/models/cart_model.dart';
// import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/data/models/wishListModel.dart';
// import 'package:bidbazar/data/repo/user_repo.dart';
import 'package:dio/dio.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

// ignore: camel_case_types
class wishListRepo {
  Api api = Api();

  // UserRepository user= UserRepository();
// Future<List<wishListModel>>
  Future wishListItem(String productId, String userId) async {
    Map<String, dynamic> data = {};
    data["user"] = userId;
    data["product"] = productId;
    print(data);
    try {
      Response response = await api.sendRequest.post(
        "/wishList",
        data: jsonEncode(data),
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      // print(apiResponse.success.toString());

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      } else {
        Get.snackbar("WishList", apiResponse.message.toString());
      }

      // return (apiResponse.data["items"] as List<dynamic>)
      //     .map((json) => wishListModel.fromJson(json))
      //     .toList();
      // ignore: unused_catch_clause
    } on DioException catch (ex) {
      rethrow;
    }
  }

  Future<List<wishListModel>> fetchWishList(String userId) async {
    try {
      Response response = await api.sendRequest.get("/wishList/${userId}");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      // if (!apiResponse.success) {
      //   throw apiResponse.message.toString();
      // }
      //       print("object working");

      // print(apiResponse.data);
 
      if (apiResponse.data != null) { // remainig condition if product is delete then wishlist also delete

        return (apiResponse.data as List<dynamic>)
            .map((json) => wishListModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        return [];
      }
    } catch (ex) {
      rethrow;
    }
  }

//   Future removeFromCartItem(String productId, String userId) async {
//     Map<String, dynamic> data = {
//       "product": productId,
//       "user": userId,
//     };

//     try {
//       Response response = await api.sendRequest.delete(
//         "/cart",
//         data: jsonEncode(data),
//       );
//       ApiResponse apiResponse = ApiResponse.fromResponse(response);

//       if (!apiResponse.success) {
//         throw apiResponse.message.toString();
//       }

//       // return (apiResponse.data["items"] as List<dynamic>)
//       //     .map((json) => cartModel.fromJson(json))
//       //     .toList();
//       // return [];
//     } on DioException catch (ex) {
//       rethrow;
//     }
//   }

// // userId = 655bc3739287689f923902f5
//   Future<List<cartModel>> fetchCart(String userId) async {
//     try {
//       print("id repo " + userId);

//       Response response = await api.sendRequest.get("/cart/${userId}");

//       ApiResponse apiResponse = ApiResponse.fromResponse(response);

//       if (!apiResponse.success) {
//         throw apiResponse.message.toString();
//       }

//       if (apiResponse.data != null) {
//         return (apiResponse.data as List<dynamic>)
//             .map((json) => cartModel.fromJson(json))
//             .toList();
//       } else
//         return [];
//     } catch (ex) {
//       rethrow;
//     }
//   }
}













//  Future<List<cartModel>> addToCart(cartModel cart, String productId) async {
//     try {
//       Response response = await api.sendRequest.post(
//         "/cart",
//         data: jsonEncode(
//           {
//             "user": cart.product?.sId,
//             "product": productId,
//           },
//         ),
//       );
//       ApiResponse apiResponse = ApiResponse.fromResponse(response);

//       if (!apiResponse.success) {
//         throw apiResponse.message.toString();
//       }

//       return (apiResponse.data as List<dynamic>)
//           .map((json) => cartModel.fromJson(json))
//           .toList();
//     } on DioException catch (ex) {
//       rethrow;
//     }
//   }