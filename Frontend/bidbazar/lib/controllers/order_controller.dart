import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/controllers/cart_controller.dart';
import 'package:bidbazar/controllers/product_controller.dart';
import 'package:bidbazar/data/models/order_model.dart';
import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/data/models/user_model.dart';
import 'package:bidbazar/data/repo/order_repo.dart';
import 'package:bidbazar/data/repo/product_repo.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class OrderController extends GetxController with StateMixin {
  Rx<OrderModel> order = OrderModel().obs;
  OrderRepo orderRepo = OrderRepo();
  List<OrderedProduct> orderProducts = [];
  productRepo productrepo = productRepo();
  RxList<Items> orderList = (List<Items>.of([])).obs;
  product_controller productController = Get.put(product_controller());
  RxString orderStatus = "Order Placed".obs;
  RxList<Items> OrdersFilters = <Items>[].obs;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    await fetchOrders();
    super.onInit();
  }

  Future pendingOrderFilter() async {
    OrdersFilters.clear();
    for (var element in orderList) {
      if (element.status == "Pending") {
        OrdersFilters.add(element);
      }
    }
  }

  Future deliveredOrderFilter() async {
    OrdersFilters.clear();
    for (var element in orderList) {
      if (element.status == "Delivered") {
        OrdersFilters.add(element);
      }
    }
  }

  Future canceldOrderFilter() async {
    OrdersFilters.clear();
    for (var element in orderList) {
      if (element.status == "Canceld") {
        OrdersFilters.add(element);
      }
    }
  }

    Future OrderPlacedFilter() async {
    OrdersFilters.clear();
    for (var element in orderList) {
      if (element.status == "order placed") {
        OrdersFilters.add(element);
      }
    }
  }

  Future placeOrder(
      {required double totalprice, required int totalquantity}) async {
    try {
      change(order.value, status: RxStatus.loading());

      cartController controller = Get.put(cartController());
      for (var element in controller.cartlist) {
        print("Start working");
        orderProducts.add(
          OrderedProduct(
              productid: productModel(
                  sId: element.product!.sId!, user: element.product!.user!),
              quantity: element.quantity!,
              buyer: AuthenticateController.userdata.first,
              seller: userModel(sId: element.product!.user!),
              bidprice: element.product!.price!),
        );
        //product sold added
        productrepo.updateSoldQty(
            productId: element.product!.sId!, soldqty: element.quantity!);
        print("product qty updated ");
      }
      print("order product works ");
      print(orderProducts.length);

      // convert order item into json format
      // List<Map<String, dynamic>> orderedProductsJson = orderProducts.map((product) => product.toJson()).toList();
      print("complete order product works ");

      await orderRepo.createOrder(
        items: [
          Items(
            orderedProduct: orderProducts,
            totalquantity: totalquantity,
            totalprice: totalprice.toInt(),
          )
        ],
        buyerId: AuthenticateController.userdata.first.sId!,
        //  sellerId: sellerId
      );
      // if(!hasdata){
      // change(order, status: RxStatus.error("There is no item to bid"));
      //   }
      await productController.fetchProducts();
      productController.productList.refresh();
      change(order.value, status: RxStatus.success());
    } on DioException catch (ex) {
      change(order.value, status: RxStatus.error(ex.toString()));
    }
  }

  Future fetchOrders() async {
    orderList.clear();
    OrdersFilters.clear();
    try {
      change(orderList, status: RxStatus.loading());
      List<OrderModel> orders = await orderRepo.fetchOrders(
          Id: AuthenticateController.userdata.first.sId!);
      print("working order data");
      print(orders);
      // orderList.assignAll(orders);
      if (orders.isEmpty) {
        change(orderList, status: RxStatus.empty());
      } else {
        // for (var i in orders){
        orderList.addAll(orders[0].items!);
        change(orderList, status: RxStatus.success());
      }
    } catch (ex) {
      change(orderList, status: RxStatus.error(ex.toString()));
    }
  }

  Future orderStatusUpdate(
      {required String status,
      required String orderId,
      required String buyerId}) async {
    try {
      var order = orderRepo.orderStatus(
          status: status, orderId: orderId, buyerId: buyerId);
      print(order);
    } catch (ex) {
      change(orderList, status: RxStatus.error(ex.toString()));
    }
  }
  //   Future updateBidStatus({required String buyerId,required String productId,required String status}) async {
  //         await bid.updateBidStatus(buyerId:buyerId , productId: productId, status: status) ;
  // }
}
