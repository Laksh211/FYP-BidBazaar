// import 'dart:convert';

import 'package:bidbazar/core/api.dart';
// import 'package:bidbazar/data/models/user_model.dart';
import 'package:dio/dio.dart';

class ImageRepository {
  // get data from repo/api and set to user model
  final Api api = Api();

  Future<List<dynamic>> uploadImage(
    List<String> image,
  ) async {
    try {
      List<MultipartFile> files = [];
      // Convert image paths to MultipartFiles
      for (String path in image) {
        files.add(
          await MultipartFile.fromFile(path, filename: path.split('/').last),
        );
      }

      FormData formData = FormData.fromMap({
        'images': files,
      });

      // FormData images = await FormData.fromMap({'images': image});

      Response response =
          await api.sendRequest.post('/images/upload', data: formData);
      final apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      // print("response of najeeb");
      print(apiResponse.data);

      return apiResponse.data; //return object of user
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<dynamic>> uploadcnic(List<String> image,) async {
    try {
      List<MultipartFile> files = [];
      // Convert image paths to MultipartFiles
      for (String path in image) {
        files.add(
          await MultipartFile.fromFile(path, filename: path.split('/').last),
        );
      }
      FormData formData = FormData.fromMap({
        'images': files,
      });
      // FormData images = await FormData.fromMap({'images': image});
      Response response =
          await api.sendRequest.post('/images/cnicImages', data: formData);
      final apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      // print("response of najeeb");
      print(apiResponse.data);
      return apiResponse.data; //return object of user
    } catch (ex) {
      rethrow;
    }
  }
  Future<List<dynamic>> uploadprofile(List<String> image,) async {
    try {
      List<MultipartFile> files = [];
      // Convert image paths to MultipartFiles
      for (String path in image) {
        files.add(
          await MultipartFile.fromFile(path, filename: path.split('/').last),
        );
      }
      FormData formData = FormData.fromMap({
        'images': files,
      });
      // FormData images = await FormData.fromMap({'images': image});
      Response response =
          await api.sendRequest.post('/images/profileImages', data: formData);
      final apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      // print("response of najeeb");
      print(apiResponse.data);
      return apiResponse.data; //return object of user
    } catch (ex) {
      rethrow;
    }
  }
}
