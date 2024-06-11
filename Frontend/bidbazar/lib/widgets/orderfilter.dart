import 'package:bidbazar/widgets/orderTile.dart';
import 'package:flutter/material.dart';
import 'package:bidbazar/controllers/order_controller.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class OrderFilter extends GetView<OrderController> {
  OrderFilter({super.key, required this.title});
  final String title;

  OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    checkOrder(title);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: controller.obx(
            (state) => ListView.builder(
                  itemCount: orderController.OrdersFilters.length,
                  itemBuilder: (context, index) {
                    var order = orderController.OrdersFilters[index];
                    var date =
                        order.createdat!.split("/").getRange(0, 3).toList();
                    return OrderTile(
                        order: order,
                        date: date,
                        index: index,
                        orderController: orderController);
                  },
                ),
            onLoading:const Center(child: CircularProgressIndicator()),
            onEmpty: Text("there is no $title")),
      ),
    );
  }

  void pending() async {
    await orderController.fetchOrders();
    await orderController.pendingOrderFilter();
  }
    void delivered() async {
    await orderController.fetchOrders();
    await orderController.deliveredOrderFilter();
  }

    void cancelOrder() async {
    await orderController.fetchOrders();
    await orderController.canceldOrderFilter();
  }
   void orderPlaced() async {
    await orderController.fetchOrders();
    await orderController.OrderPlacedFilter();
  }

  void checkOrder(String title){
    switch(title){
      case "Order Placed":
      orderPlaced();
      break;
      case "Pending Orders":
      pending();
      break;
      case "Order Delivered":
      delivered();
      break;
      case "Order Canceled":
      cancelOrder();
      break;
      
      
    }
    

  }
}
