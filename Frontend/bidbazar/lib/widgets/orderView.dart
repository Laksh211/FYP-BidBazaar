import 'package:bidbazar/widgets/orderTile.dart';
import 'package:flutter/material.dart';
import 'package:bidbazar/controllers/order_controller.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class OrderView extends GetView<OrderController> {
  OrderView({super.key});
  OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Order Logs"),
      ),
      body: controller.obx(
        (state) => RefreshIndicator(
          onRefresh: () async {
            orderController.fetchOrders();
            controller.update();
          },
          child: ListView.builder(
            itemCount: orderController.orderList.length,
            itemBuilder: (context, index) {
              var order = orderController.orderList[index];
              var date = order.createdat!.split("/").getRange(0, 3).toList();

              return OrderTile(order: order, date: date, index: index, orderController: orderController);
            },
          ),
        ),
        onEmpty: const Center(
          child: Text("There is no product to display"),
        ),
        onError: (error) => Center(
          child: Text("$error"),
        ),
      ),
    );
  }
}
