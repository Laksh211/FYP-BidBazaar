import 'dart:convert';
// import 'dart:html';

import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/core/api.dart';
import 'package:bidbazar/data/models/bid_model.dart';
// import 'package:bidbazar/data/models/cart_model.dart';
// import 'package:bidbazar/data/models/product_model.dart';
import 'package:dio/dio.dart';

class BidRepo {
  Api api = Api();

  // UserRepository user= UserRepository();

  // Future<List<cartModel>> addToCart(cartModel cart, String userId) async {
  //   Map<String, dynamic> data = cart.toJson();
  //   data["user"] = userId;
  //   // print("newCart");
  //   // print(data);
  //   try {
  //     Response response = await api.sendRequest.post(
  //       "/cart",
  //       data: jsonEncode(data),
  //     );
  //     ApiResponse apiResponse = ApiResponse.fromResponse(response);
  //     if (!apiResponse.success) {
  //       throw apiResponse.message.toString();
  //     }
  //     // print("newdata " + apiResponse.data.toString());
  //     // return [];
  //     return (apiResponse.data["items"] as List<dynamic>)
  //         .map((json) => cartModel.fromJson(json))
  //         .toList();
  //   } on DioException catch (ex) {
  //     rethrow;
  //   }
  // }
  // Future removeFromCartItem(String productId, String userId) async {
  //   Map<String, dynamic> data = {
  //     "product": productId,
  //     "user": userId,
  //   };
  //   try {
  //     Response response = await api.sendRequest.delete(
  //       "/cart",
  //       data: jsonEncode(data),
  //     );
  //     ApiResponse apiResponse = ApiResponse.fromResponse(response);
  //     if (!apiResponse.success) {
  //       throw apiResponse.message.toString();
  //     }
  //     // return (apiResponse.data["items"] as List<dynamic>)
  //     //     .map((json) => cartModel.fromJson(json))
  //     //     .toList();
  //     // return [];
  //   } on DioException catch (ex) {
  //     rethrow ;
  //   }
  // }

// userId = 655bc3739287689f923902f5
  Future<List<BidModel>> fetchBidBySellerID(String sellerId) async {
    try {

      Response response = await api.sendRequest.get("/bid/fetchAllBidsForSeller/$sellerId");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      // if (!apiResponse.success) {
      //   throw apiResponse.message.toString();
      // }
     
      // print(BidModel.fromJson(apiResponse.data));
      
      // if (apiResponse.data != null) {

      //   return   
      //   (apiResponse.data as List<dynamic>)
      //       .map((json) => BidModel.fromJson(json))
      //       .toList();
      // } else
        
        // if(!apiResponse.success){
        //   throw Error();
        // }else{
        // List<BidModel> item=[];
        // item.add(BidModel.fromJson(apiResponse.data));
        // return item;
        // }
        print("bid value repo  ${apiResponse.data}" );
        

        if(!apiResponse.success ){
        print("bid value repo  ${apiResponse.data}" );

          // throw Exception("There is no item in your bid");
        return  [];
        }else
        return (apiResponse.data as List<dynamic>).map((e) => BidModel.fromJson(e)).toList();

    } catch (ex) {
      rethrow;
    }
  }

  Future<List<BidModel>> fetchBidByBuyerID(String BuyerId) async {
    try {

      Response response = await api.sendRequest.get("/bid/fetchAllBidsForBuyer/${BuyerId}");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
       
       
        if(!apiResponse.success){
          return [];
          // throw apiResponse.message.toString();
        }else {
          return (apiResponse.data as List<dynamic>)
          .map((json) => BidModel.fromJson(json))
          .toList();
        }
    } catch (ex) {
      rethrow;
    }
  }

   Future<BidModel> createBid({required String productId, required String buyerId,required String sellerId,required int bidprice}) async {
    // Map<String, dynamic> data = cart.toJson();
    // data["user"] = userId;
    // // print("newCart");
    // // print(data);
    try {
      Response response = await api.sendRequest.post(
        "/bid",
        data: jsonEncode({
          
      "seller": sellerId,
      "buyer": buyerId,
      "product":productId,
      "bidprice":bidprice

        }),
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return BidModel.fromJson(apiResponse.data);
    } on DioException catch (_) {
      rethrow;
    }
  }

   Future updateBidStatus({required String productId,required String buyerId,required String status}) async {
    try {
      Response response = await api.sendRequest.post(
        "/bid/updateStatus",
        data: jsonEncode({
      "productId": productId,
      "buyerId": buyerId,
      "status": status,
        }),
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

       if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      
    } on DioException catch (_) {
       rethrow;
    }
  }

    Future deletebid({required String bidId,}) async {
    try {
      Response response = await api.sendRequest.delete(
        "/bid/delete/$bidId/${AuthenticateController.userdata.first.sId}",
    
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

       if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      
    } on DioException catch (_) {
       rethrow;
    }
  }
   Future deletebidForSeller({required String bidId,}) async {
    try {
      Response response = await api.sendRequest.delete(
        "/bid/deletebidForSeller/$bidId/${AuthenticateController.userdata.first.sId}",
    
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

       if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      
    } on DioException catch (_) {
       rethrow;
    }
  }


}
