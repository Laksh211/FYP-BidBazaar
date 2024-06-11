import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/data/models/bid_model.dart';
// import 'package:bidbazar/data/models/cart_model.dart';
// import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/data/repo/bid.dart';
// import 'package:bidbazar/data/models/user_model.dart';
import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BidController extends GetxController with StateMixin {
  // RxList<BidModel> bidlist = (List<BidModel>.of([])).obs;
  Rx<BidModel> biditems = BidModel().obs;
  RxList<BidModel> bidItemsList = <BidModel>[].obs;
  var value;
  BidRepo bid = BidRepo();

  @override
  void onClose() {
    // TODO: implement onClose

    super.onClose();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    //  AuthenticateController.userdata.first.usertype=='Seller'?
    // await  fetchBidItems():null;
    await fetchBidItems();
  }

  Future fetchBidItems() async {
    try {
      change(bidItemsList, status: RxStatus.loading());
      // String id = user.userdata.first.sId.toString();
      bidItemsList.clear();
      AuthenticateController.userdata.first.usertype == 'Seller'
          ? value = await bid
              .fetchBidBySellerID(AuthenticateController.userdata.first.sId!)
          : value = await bid
              .fetchBidByBuyerID(AuthenticateController.userdata.first.sId!);

      List<dynamic> v = value;
      // print("bid value ${v.isEmpty}");

      if (v.isNotEmpty) {
        AuthenticateController.userdata.first.usertype == 'Seller'
            ? bidItemsList.add(value[0])
            : bidItemsList.addAll(value);
        change(bidItemsList, status: RxStatus.success());
      } else {
        // print(" else bid value ${v.isEmpty}");

        change(bidItemsList, status: RxStatus.empty());
      }
      // print("checking items ");
      // print(biditems.value.items?.isEmpty);
      // if(biditems.value.items!.isEmpty){
      // print('working 123');
      //  change(biditems, status: RxStatus.error("there is no item to display"), );
      // change(biditems.value, status: RxStatus.error("There is no item to bid"));
      // }
    } on DioException catch (ex) {
      change(bidItemsList, status: RxStatus.error(ex.toString()));
    }
  }

  Future addBid(String productId, String sellerId, int bidprice) async {
    try {
      change(biditems.value, status: RxStatus.loading());
      // String id = user.userdata.first.sId.toString();

      biditems.value = await bid.createBid(
          productId: productId,
          buyerId: AuthenticateController.userdata.first.sId!,
          sellerId: sellerId,
          bidprice: bidprice);
      if (!biditems.value.isBlank!) {
        change(biditems, status: RxStatus.error("There is no item to bid"));
      }

      change(biditems.value, status: RxStatus.success());
    } on DioException catch (ex) {
      change(biditems.value, status: RxStatus.error(ex.toString()));
    }
  }

  Future updateBidStatus(
      {required String buyerId,
      required String productId,
      required String status}) async {
    await bid.updateBidStatus(
        buyerId: buyerId, productId: productId, status: status);
  }

  void deleteBid({
    required String bidId,
  }) {
    bid.deletebid(bidId: bidId);
  }

   void deletebidForSeller({
    required String bidId,
  }) {
    bid.deletebidForSeller(bidId: bidId);
  }


}
