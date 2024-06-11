import 'dart:convert';

import 'package:bidbazar/core/api.dart';
import 'package:bidbazar/data/models/category_model.dart';
// import 'package:bidbazar/data/models/user_model.dart';
import 'package:dio/dio.dart';

class categoryRepo {
  Api api = Api();

  Future<categoryModel> createCategory({
    required String title,
    String? description,
  }) async {
    try {
      Response response = await api.sendRequest.post("/category",
          data: jsonEncode({"title": title, "description": description}));

      final categoryResponse = ApiResponse.fromResponse(response);

      if (!categoryResponse.success) {
        throw categoryResponse.message.toString();
      }

      return categoryModel.fromJson(categoryResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<categoryModel>> fetchCategory() async {
    try {
      Response response = await api.sendRequest.get("/category");

      ApiResponse categoryResponse = ApiResponse.fromResponse(response);

      if (!categoryResponse.success) {
        throw categoryResponse.message.toString();
      }

      return (categoryResponse.data as List<dynamic>)
          .map((jsonObject) => categoryModel
              .fromJson(jsonObject)) //jsonObject.key Or jsonObject.value
          .toList(); //add all streams of json object
    } catch (ex) {
      rethrow;
    }
  }
}
