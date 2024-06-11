import 'dart:convert';

import 'package:bidbazar/core/api.dart';
// import 'package:bidbazar/data/models/user_model.dart';
import 'package:dio/dio.dart';

class EmailRepo {
  
  final Api api = Api();

  Future<String> sendOtp({required String email}) async {
    try {
      Response response = await api.sendRequest.post('/email/sentEmail',
          data: jsonEncode({"email": email}));

      final apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      var otp=apiResponse.data;
      //if successfull then we convert raw data to user model
      return  otp['otp'];//return object of user
    } on DioException catch (ex) {
      throw ex.message.toString();
    }
  }

}
