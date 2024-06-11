import 'package:bidbazar/widgets/orderfilter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Order Status"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OrderCard(
                title: 'Order Placed',
                onPressed: () {
                   Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => OrderFilter(title:'Order Placed' ),
                    ));
                },
                icon: const Icon(Icons.shopping_basket_outlined, size: 54),
              ),
              const SizedBox(
                width: 5,
              ),
              OrderCard(
                title: 'Order Pending',
                onPressed: () {
                   Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => OrderFilter(title: "Pending Orders" ),
                    ),);
                },
                icon: const Icon(Icons.shopping_basket_outlined, size: 54),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OrderCard(
                title: 'Order Delivered',
                onPressed: () {
                    Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => OrderFilter(title: 'Order Delivered'),
                    ));
                },
                icon: const Icon(Icons.shopping_basket_outlined, size: 54),
              ),
              const SizedBox(
                width: 5,
              ),
              OrderCard(
                title: 'Order Canceld',
                onPressed: () {
                    Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => OrderFilter(title:'Order Canceled' ),
                    ));
                },
                icon: const Icon(Icons.shopping_basket_outlined, size: 54),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  OrderCard({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.title,
  });
  final VoidCallback onPressed;
  final Icon icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 150,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 10),
            TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                  shape: const ContinuousRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      side: BorderSide(
                          color: Color.fromARGB(255, 158, 158, 158)))),
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}
