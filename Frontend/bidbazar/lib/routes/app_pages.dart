import 'package:bidbazar/Views/Login.dart';
import 'package:bidbazar/Views/Signup.dart';
import 'package:bidbazar/Views/admin_home.dart';
import 'package:bidbazar/Views/buyer_home.dart';
import 'package:bidbazar/Views/seller_home.dart';
import 'package:bidbazar/Views/splash.dart';
// import 'package:bidbazar/controllers/ControllerBinding.dart';
// import 'package:bidbazar/controllers/ControllerBinding.dart';
// import 'package:bidbazar/controllers/wishList_controller.dart';
// import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/routes/app_routesnames.dart';
import 'package:bidbazar/widgets/addproduct.dart';
import 'package:bidbazar/widgets/filter.dart';
import 'package:bidbazar/widgets/product_detail_screen.dart';
import 'package:bidbazar/widgets/search.dart';
import 'package:bidbazar/widgets/wishList.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => loginScreen(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 200),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => signUp(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 200),
    ),
    GetPage(
      name: AppRoutes.admin,
      page: () => Admin(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 200),
    ),
    GetPage(
      name: AppRoutes.buyer,
      page: () => Buyer(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 200),
    ),
    GetPage(
      name: AppRoutes.seller,
      page: () => Seller(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 200),
    ),
    GetPage(
      name: AppRoutes.productdetailscreen,
      page: () => ProductDetailScreen(),
      // transition: Transition.cupertino,
      // transitionDuration: Duration(milliseconds: 200),
    ),
    GetPage(
      name: AppRoutes.addproduct,
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 200),
      page: () => addProduct(),
    ),
    GetPage(
      name: AppRoutes.search,
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 200),
      page: () => CustomSearch(isScrolledColor: true),
    ),
    GetPage(
      name: AppRoutes.wishlist,
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 200),
      page: () => WishList(),
      // binding: WishListControllerBinding(),
    ),
    GetPage(
      name: AppRoutes.filter,
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 200),
      page: () => FilterProduct(),
      // binding: WishListControllerBinding(),
    ),
  ];
}
