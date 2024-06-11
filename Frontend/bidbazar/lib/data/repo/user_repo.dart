import 'dart:convert';

import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/core/api.dart';
import 'package:bidbazar/data/models/user_model.dart';
import 'package:dio/dio.dart';

class UserRepository {
  // get data from repo/api and set to user model
  final Api api = Api();

  Future<userModel?> createAccount(String name, String email, String phone,
      String cnic, String address, String password, String usertype) async {
    try {
      Response response = await api.sendRequest.post('/user/createAccount',
          data: jsonEncode({
            "fullname": name,
            "email": email,
            "mobile": phone,
            "cnic": cnic,
            "address": address,
            "password": password,
            "usertype": usertype
          }));
      final apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      //if successfull then we convert raw data to user model
      return userModel.fromJson(apiResponse.data); //return object of user
    } catch (ex) {
      rethrow;
    }
  }

  Future<userModel> findUserById(String Id) async {
    try {
      var user = await api.sendRequest.post("/user/find", data: {
        "id": Id,
      });
      ApiResponse apiResponse = ApiResponse.fromResponse(user);

      return userModel.fromJson(apiResponse.data);
    } catch (ex) {
      throw ex;
    }
  }

    Future<userModel> blockUser({required String Id}) async {
    try {
      var user = await api.sendRequest.post("/user/block", data: {
        "id": Id,
      });
      ApiResponse apiResponse = ApiResponse.fromResponse(user);

      return userModel.fromJson(apiResponse.data);
    } catch (ex) {
      throw ex;
    }
  }

   Future<List<userModel>> findAllSellers() async {
    try {
      var user = await api.sendRequest.get("/user/sellers");
      ApiResponse apiResponse = ApiResponse.fromResponse(user);
      
      if (apiResponse.data != null) {
      return (apiResponse.data as List<dynamic>)
          .map((jsonObject) => userModel.fromJson(jsonObject)) //jsonObject.key Or jsonObject.value
          .toList();  
            } else {
        return [];
      }
    } catch (ex) {
      throw ex;
    }
  }
   Future<List<userModel>> findAllBuyers() async {
    try {
      var user = await api.sendRequest.get("/user/buyers");

      ApiResponse apiResponse = ApiResponse.fromResponse(user);

      if (apiResponse.data != null) {

      return (apiResponse.data as List<dynamic>)
          .map((jsonObject) => userModel.fromJson(jsonObject)) //jsonObject.key Or jsonObject.value
          .toList(); 
  } else {
        return [];
      }
    } catch (ex) {
      throw ex;
    }
  }

    Future<userModel> userVerification({required String Id}) async {
    try {
      var user = await api.sendRequest.post("/user/verification", data: {
        "id": Id,
      });
      ApiResponse apiResponse = ApiResponse.fromResponse(user);

      return userModel.fromJson(apiResponse.data);
    } catch (ex) {
      throw ex;
    }
  }

 Future<userModel> uploadCnicPicture({required List<String> images,}) async {
    try {
      var user = await api.sendRequest.post("/user/uploadcnic", data: {
        "id": AuthenticateController.userdata.first.sId,
        "images":images
      });
      ApiResponse apiResponse = ApiResponse.fromResponse(user);

      return userModel.fromJson(apiResponse.data);
      
    } catch (ex) {
      throw ex;
    }
  }
   Future<userModel> uploadProfilePicture({required List<String> images}) async {
    try {
      var user = await api.sendRequest.post("/user/uploadprofile", data: {
        "id": AuthenticateController.userdata.first.sId,
        "images":images
      });
      ApiResponse apiResponse = ApiResponse.fromResponse(user);

      return userModel.fromJson(apiResponse.data);
    } catch (ex) {
      throw ex;
    }
  }

   Future<String> forgot({required email,required password}) async {
    try {
      var user = await api.sendRequest.post("/user/forgot", data: {
        "email": email,
        "password":password
      });
      ApiResponse apiResponse = ApiResponse.fromResponse(user);

      return apiResponse.data;
    }  catch (ex) {
      throw ex;
    }
  }





  Future<userModel?> signIn(String email, String password) async {
    try {
      Response response = await api.sendRequest.post('/user/signIn',
          data: jsonEncode({"email": email, "password": password}));
      final apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      //if successfull then we convert raw data to user model
      return userModel.fromJson(apiResponse.data); //return object of user
    } on DioException catch (ex) {
      throw ex.message.toString();
    }
  }
}
