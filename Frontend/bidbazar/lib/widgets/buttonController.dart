// import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum userType { Buyer, Seller, Admin }

class ButtonController extends GetxController {
  userType? _userType = userType.Seller;

  get getUserType => _userType;

  get getUserName => getUserTypeAsString().toString();

  String getUserTypeAsString() {
    switch (_userType) {
      case userType.Buyer:
        return 'Buyer';
      case userType.Seller:
        return 'Seller';
      case userType.Admin:
        return 'Admin';
      default:
        return 'Buyer';
    }
  }

  void setOrderType(dynamic type) {
    _userType = type;
    update();

    // print("type = " + getUserTypeAsString().toString());
  }
}
