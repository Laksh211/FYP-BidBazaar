import 'dart:convert';

import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/core/api.dart';
import 'package:bidbazar/data/models/order_model.dart';
import 'package:dio/dio.dart';

class OrderRepo {
  Api api = Api();

  Future createOrder({
    required List<Items> items,
    required String buyerId,
  }) async {
    // Map<String, dynamic> data = cart.toJson();
    // data["user"] = userId;
    // // print("newCart");
    // // print(data);

    try {
      Response response = await api.sendRequest.post(
        "/order/create",
        data: jsonEncode({
          // "seller": sellerId,
          "buyer": buyerId,
          "items": items
        }),
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      print("new order");
      print(apiResponse.data);
      // return apiResponse.data == [];
    } on DioException catch (_) {
      rethrow;
    }
  }


   Future<List<OrderModel>> fetchOrders({required String Id}) async {
    try {
      Response response =AuthenticateController.userdata.first.usertype! == "Seller"?
         await api.sendRequest.get("/order/fetchForSeller/$Id")
       : await api.sendRequest.get("/order/fetch/$Id");//fetch for buyer

      ApiResponse orderResponse = ApiResponse.fromResponse(response);

      if (!orderResponse.success) {
        throw orderResponse.message.toString();
      }
      print(orderResponse.data);

      return (orderResponse.data as List<dynamic>)
          .map((jsonObject) => OrderModel
              .fromJson(jsonObject)) //jsonObject.key Or jsonObject.value
          .toList(); //add all streams of json object
    } catch (ex) {
      rethrow;
    }
  }


 Future<String> orderStatus({required String status,required String orderId,required String buyerId}) async {
    try {
      Response response = await api.sendRequest.post("/order/statusupdate",
      data: {
            "status":status,
            "orderId":orderId,
            "buyerId":buyerId
      }
      );

      ApiResponse orderResponse = ApiResponse.fromResponse(response);

      if (!orderResponse.success) {
        throw orderResponse.message.toString();
      }
      print(orderResponse.data);

      return  orderResponse.data; //jsonObject.key Or jsonObject.value
           //add all streams of json object
    } catch (ex) {
      rethrow;
    }
  }
}
