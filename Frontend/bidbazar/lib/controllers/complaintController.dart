// import 'dart:convert';

import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/core/api.dart';
import 'package:bidbazar/data/models/complaint_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:get/get.dart';

class ComplaintController extends GetxController with StateMixin {
  final formKey = GlobalKey<FormState>();

  final complaintController = TextEditingController();
  RxList<ComplainModel> listOfComplaints= (List<ComplainModel>.of([])).obs;
  RxList<ComplainModel> templistOfComplaints= (List<ComplainModel>.of([])).obs;


  Api api = Api();



@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchComplaint();
  }

 Future fetchComplaint() async {
  try {
    change("", status: RxStatus.loading());
    Response response = await api.sendRequest.get("/complaint/get");

    ApiResponse complaintResponse = ApiResponse.fromResponse(response);
    
    if (complaintResponse.success == false) {
      throw Exception("There is an error in the complaint");
    }

    
    List<ComplainModel> complaints = (complaintResponse.data as List<dynamic>)
        .map((item) => ComplainModel.fromJson(item))
        .toList();
    
    listOfComplaints.assignAll(complaints); 
    change("", status: RxStatus.success());
  } catch (ex) {
    change("", status: RxStatus.error(ex.toString()));
  }
}


  Future complaint({required String reason}) async {
    try {
      Response response = await api.sendRequest.post("/complaint/add", data: {
        "buyerid": AuthenticateController.userdata.first.sId,
        "reason": reason,
        "complaintExplanation": complaintController.text
      });

      ApiResponse complaintResponse = ApiResponse.fromResponse(response);
      // print(response.data);
      if (!complaintResponse.success) {
        throw complaintResponse.message.toString();
      }
    } catch (ex) {
      rethrow;
    }
  }

  // List<DropdownMenuItem>? reas = [
  //   const DropdownMenuItem(
  //     value: 'Product not as described',
  //     child: Text('Product not as described'),
  //   ),
  //   const DropdownMenuItem(
  //     value: 'Late delivery',
  //     child: Text('Late delivery'),
  //   ),
  //   const DropdownMenuItem(
  //     value: 'Late delivery',
  //     child: Text('Late delivery'),
  //   ),
  //   const DropdownMenuItem(
  //     value: 'Wrong item delivered',
  //     child: Text('Wrong item delivered'),
  //   ),
  //   const DropdownMenuItem(
  //     value: 'Other',
  //     child: Text('Other'),
  //   ),
  // ];

  // void submitComplaint({required String reason}) async{

  // }
}
