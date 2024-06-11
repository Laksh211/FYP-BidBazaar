import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/controllers/order_controller.dart';
import 'package:bidbazar/core/api.dart';
import 'package:bidbazar/data/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


// ignore: must_be_immutable
class OrderTile extends StatelessWidget {
   OrderTile({super.key ,required this.order,required this.date,required this.index , required this.orderController});
  final Items order;
  final List<String> date;
  int index;
  final OrderController orderController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Image.network(
                      fit: BoxFit.contain,
                      "${Api.BASE_URL}/images/${order.orderedProduct!.first.productid!.images!.first}",
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.orderedProduct!.first.productid!.name!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Actual price: ${order.orderedProduct!.first.productid!.price}",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "Bid price: ${order.orderedProduct!.first.bidprice.toString()}",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Total price: ${order.totalprice}",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Date: ${date[0]}/${date[1]}/${date[2]}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Obx(
                      () => Text(
                        order.status == orderController.orderStatus.value
                            ? "Status: ${orderController.orderStatus.value}"
                            : "Status: ${order.status}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Total Qty: ${order.totalquantity}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AuthenticateController.userdata.first.usertype == "Seller"
              ?
              // const SizedBox(height: 10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print(order.orderedProduct![index]);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Order Details'),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Buyer Info Section
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              "${Api.BASE_URL}/images/${order.orderedProduct![index].buyer!.profileimages!.first}"),
                                          radius: 40,
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${order.orderedProduct![index].buyer!.fullname}",
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Address: ${order.orderedProduct![index].buyer!.address}",
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              "Contact: ${order.orderedProduct![index].buyer!.mobile}",
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                        height: 20,
                                        thickness: 1,
                                        color: Colors.grey),
                                    // Order Info Section
                                    Text(
                                        "Product: ${order.orderedProduct!.first.productid!.name!}"),
                                    Text(
                                        "Actual Price: ${order.orderedProduct!.first.productid!.price}"),
                                    Text(
                                        "Bid Price: ${order.orderedProduct!.first.bidprice.toString()}"),
                                    Text("Total Price: ${order.totalprice}"),
                                    Text(
                                        "Date: ${date[0]}/${date[1]}/${date[2]}"),
                                    Text("Status: ${order.status}"),
                                    Text("Total Qty: ${order.totalquantity}"),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Close'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('More Info'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Implement the status change logic here
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Order Status'),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Buyer Info Section
                                    Obx(
                                      () => DropdownButton<String>(
                                        items: <String>[
                                          'Order Placed',
                                          'Pending',
                                          'Delivered',
                                          'Canceld',
                                        ].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        value:
                                            orderController.orderStatus.value,
                                        onChanged: (value) {
                                          order.status = orderController
                                              .orderStatus
                                              .value = value ?? "Order Placed";
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Close'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    order.status ==
                                            orderController.orderStatus.value
                                        ? {
                                            orderController.orderStatusUpdate(
                                                status: orderController
                                                    .orderStatus.value,
                                                orderId: order.sId!,
                                                buyerId: order.orderedProduct!
                                                    .first.buyer!.sId
                                                    .toString()),
                                            Navigator.of(context).pop()
                                          }
                                        : Get.snackbar("Order",
                                            "please change the order status");
                                  },
                                  child: const Text('Update'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Change Status'),
                    ),
                  ],
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}