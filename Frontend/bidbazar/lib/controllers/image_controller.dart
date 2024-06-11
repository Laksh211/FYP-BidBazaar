// import 'dart:convert';
// import 'dart:io';

import 'package:bidbazar/data/repo/image_repo.dart';
// import 'package:dio/src/form_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController with StateMixin {
  ImageRepository imageRepo = ImageRepository();

  List<String> imageList = RxList(<String>[].obs);
  List<String> uploadImageList = [];
  List<String> uploadCnicList = RxList(<String>[].obs);
  List<String> uploadProfileList = RxList(<String>[].obs);


  // RxList<String> uploadImageList = RxList(<String>[].obs);
  final productKey = GlobalKey<FormState>();


  //pick images 
  Future pickImages() async {
    change(imageList, status: RxStatus.loading());

    List<XFile> pickedImage;
    final picker = ImagePicker();

    pickedImage = await picker.pickMultiImage(
      imageQuality: 50,
      // maxHeight: 500, // <- reduce the image size
      // maxWidth: 500,
    );
    // _image = pickedFile;
    List<XFile> images = [];

    images.addAll(pickedImage);
    
    for (var xFile in images) {
      String filePath = xFile.path;
      imageList.add(filePath);
    }
    print(imageList);
    change(imageList, status: RxStatus.success());
  }

//  Future cnicImageUpload()async {
//     await pickImages();
//     uploadCnicList.addAll(imageList);
//   }
//   Future profileImageUpload() async{
//         await pickImages();
//     uploadProfileList.addAll(imageList);
//   }



  Future upload() async {
    var image = await imageRepo.uploadImage(imageList);
    List<String> img = List<String>.from(image);
    uploadImageList.addAll(img);
    // print("done images");
  }
Future uploadCnic() async {
    var image = await imageRepo.uploadcnic(imageList);
    List<String> img = List<String>.from(image);
    uploadCnicList.addAll(img);
    // print("done images");
  }

  Future uploadProfile() async {
    var image = await imageRepo.uploadprofile(imageList);
    List<String> img = List<String>.from(image);
    uploadProfileList .addAll(img);
    // print("done images");
  }
  // void _upload(List<XFile> file) async {
  //   print("upload image");
  //   print(file.first);
  //   FormData data = await FormData.fromMap({"images": await file});

  //   print("upload image");
  //   print(data.fields);
  //   // Future<List<String>> image = imageRepo.uploadImage(data);

  //   // images = await image;

  //   // images.assignAll(image);

  //   print("My images");
  //   print(images);

  //   // dio
  //   //     .post("http://192.168.43.225/api/media", data: data)
  //   //     .then((response) => print(response))
  //   //     .catchError((error) => print(error));
  // }
}
