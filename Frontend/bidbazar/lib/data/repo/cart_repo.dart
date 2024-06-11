import 'dart:convert';
// import 'dart:html';

import 'package:bidbazar/core/api.dart';
import 'package:bidbazar/data/models/cart_model.dart';
import 'package:bidbazar/data/models/product_model.dart';
import 'package:dio/dio.dart';

class cartRepo {
  Api api = Api();

  // UserRepository user= UserRepository();

  Future<List<cartModel>> addToCart(cartModel cart, String userId) async {
    // Map<String, dynamic> data = cart.toJson();
    // data["user"] = userId;
    print("newCart 5");
    print(cart);
    try {
      Response response = await api.sendRequest.post(
        "/cart",
        data:{
          "user":userId,
          "product":cart.product ,
          "quantity": cart.quantity,
        } 
        // jsonEncode(data),
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      // print("newdata " + apiResponse.data.toString());
      // return [];
      return (apiResponse.data["items"] as List<dynamic>)
          .map((json) => cartModel.fromJson(json))
          .toList();
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future removeFromCartItem(String productId, String userId) async {
    Map<String, dynamic> data = {
      "product": productId,
      "user": userId,
    };

    try {
      Response response = await api.sendRequest.delete(
        "/cart",
        data: jsonEncode(data),
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      // return (apiResponse.data["items"] as List<dynamic>)
      //     .map((json) => cartModel.fromJson(json))
      //     .toList();
      // return [];
    } on DioException catch (_) {
      rethrow ;
    }
  }

      Future removeAllFromCart(String userId) async {
        Map<String, dynamic> data = {
          "user": userId,
          };

    try {
      Response response = await api.sendRequest.post(
        "/cart/removeAllFromCart",
        data: jsonEncode(data),
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }else{
        
      }
    } on DioException catch (_) {
      rethrow ;
    }
  }



// userId = 655bc3739287689f923902f5
  Future<List<cartModel>> fetchCart(String userId) async {
    try {
      print("id repo " + userId);

      Response response = await api.sendRequest.get("/cart/${userId}");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      // if (!apiResponse.success) {
      //   throw apiResponse.message.toString();
      // }

      if (apiResponse.data != null) {
        return (apiResponse.data as List<dynamic>)
            .map((json) => cartModel.fromJson(json))
            .toList();
      } else {
        return [];
      }
    } catch (ex) {
      rethrow;
    }
  }
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