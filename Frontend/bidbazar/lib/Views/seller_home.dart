import 'package:bidbazar/controllers/bidController.dart';
import 'package:bidbazar/controllers/wishList_controller.dart';
import 'package:bidbazar/core/api.dart';
// import 'package:bidbazar/data/models/user_model.dart';
import 'package:bidbazar/widgets/bidView.dart';
import 'package:bidbazar/widgets/category.dart';
import 'package:bidbazar/Views/home.dart';
import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/widgets/orderView.dart';
import 'package:bidbazar/widgets/order_status.dart';
import 'package:bidbazar/widgets/profile.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Seller extends StatelessWidget {
  Seller({super.key});

  static const String routeName = '/sellerScreen';

  AuthenticateController controller = Get.put(AuthenticateController());
  BidController bidController = Get.put(BidController());

  List<Widget> screens = [
    Home(),
    Category(),
    // Library(),
    // hotlist(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Obx(
        () => IndexedStack(
          children: screens,
          index: controller.screenIndex.value,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (value) {
            controller.screenIndex.value = value;
          },
          showUnselectedLabels: false,
          // backgroundColor: Colors.white12,
          showSelectedLabels: true,
          selectedIconTheme: IconThemeData(color: Colors.amber[900]),
          selectedItemColor: Colors.amber[900],
          currentIndex: controller.screenIndex.value,
          selectedFontSize: 10,
          // showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,

          // landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
          unselectedIconTheme: const IconThemeData(
            color: Colors.black54,
          ),
          iconSize: 27,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_rounded),
              label: 'Category',
            ),
          ],
        ),
      ),
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: Colors.white,
      //   automaticallyImplyLeading: true,
      //   foregroundColor: Colors.black,
      //   centerTitle: true,
      //   title: Text("Bidbazar"),
      // ),
      drawer: Drawer(
        width: 250,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 80,
            ),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: AuthenticateController
                          .userdata.first.profileimages!.isNotEmpty
                      ? Image.network(
                          "${Api.BASE_URL}/images/${AuthenticateController.userdata.first.profileimages![0]}",
                          fit: BoxFit.fitWidth,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const Icon(
                              Icons.person,
                              size: 48,
                            );
                          },
                        )
                      : const Icon(
                          Icons.person,
                          size: 48,
                        )),
            ),
            const SizedBox(
              height: 40,
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: Image.asset(
                'assets/favourite.png',
                width: 38,
                height: 25,
                fit: BoxFit.contain,
              ),
              title: const Text('WishList'),
              // selected: true,
              onTap: () {
                WishListController wishListController =
                    Get.put(WishListController());
                wishListController.fetchWishListItems();
                Get.toNamed("wishListScreen");
              },
            ),

            ListTile(
              leading: Image.asset(
                'assets/order.png',
                width: 38,
                height: 25,
                fit: BoxFit.contain,
              ),
              title: const Text('Order Logs'),
              // selected: true,
              onTap: () {
                // OrderController orderController = Get.put(OrderController());
                // orderController.fetchOrders();
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => OrderView(),
                  ),
                );
              },
            ),
            // ListTile(
            //   leading: Image.asset(
            //     'assets/order.png',
            //     width: 38,
            //     height: 25,
            //     fit: BoxFit.contain,
            //   ),
            //   title: const Text('Order Pending'),
            //   // selected: true,
            //   onTap: () async {
            //     //   OrderController orderController = Get.put(OrderController());
            //     //  await orderController.fetchOrders();
            //     //  await orderController.pendingOrderFilter();
            //     // ignore: use_build_context_synchronously
            //     Navigator.push(
            //         context,
            //         CupertinoPageRoute(
            //           builder: (context) =>
            //               OrderFilter(title: "Pending Orders"),
            //         ));
            //   },
            // ),
            // ListTile(
            //   leading: Image.asset(
            //     'assets/order.png',
            //     width: 38,
            //     height: 25,
            //     fit: BoxFit.contain,
            //   ),
            //   title: const Text('Order Delivered'),
            //   // selected: true,
            //   onTap: () async {
            //     //   OrderController orderController = Get.put(OrderController());
            //     //  await orderController.fetchOrders();
            //     //    orderController.deliveredOrderFilter();
            //     Navigator.push(
            //         context,
            //         CupertinoPageRoute(
            //           builder: (context) =>
            //               OrderFilter(title: 'Order Delivered'),
            //         ));
            //   },
            // ),
            // ListTile(
            //   leading: Image.asset(
            //     'assets/order.png',
            //     width: 38,
            //     height: 25,
            //     fit: BoxFit.contain,
            //   ),
            //   title: const Text('Order Canceled'),
            //   // selected: true,
            //   onTap: () async {
            //     //   OrderController orderController = Get.put(OrderController());
            //     //  await orderController.fetchOrders();
            //     //   orderController.canceldOrderFilter();
            //     Navigator.push(
            //         context,
            //         CupertinoPageRoute(
            //           builder: (context) =>
            //               OrderFilter(title: 'Order Canceled'),
            //         ));
            //   },
            // ),
            ListTile(
              leading: Image.asset(
                'assets/order.png',
                width: 38,
                height: 25,
                fit: BoxFit.contain,
              ),
              title: const Text('Order Status'),
              // selected: true,
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => OrderStatus(),
                    ));
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: ListTile(
                // leading: Icon(Icons.receipt),
                leading:
                    const Icon(Icons.person, size: 32, color: Colors.black),
                title: const Text('Profile'),
                selected: false,
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => Profile(),
                      ));

                  // Navigator.push(context,MaterialPageRoute(builder: (context) => BidView(controller: bidController, approvedBid:false ),),);
                  // bidController.dispose();
                },
              ),
            ),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Icon(Icons.receipt, size: 26, color: Colors.black),
              ),
              title: const Text('Bid Logs'),
              selected: false,
              onTap: () async {
                // print("working recent bid :");
                BidController bd = Get.put(BidController());
                await bd.fetchBidItems();
                // ignore: use_build_context_synchronously
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => BidView(
                          items: bidController.bidItemsList.isEmpty
                              ? []
                              : bidController.bidItemsList.first.items!,
                          approvedBid: false,
                          buyerId: bidController.bidItemsList.isEmpty
                              ? ""
                              : bidController.bidItemsList.first.buyer!),
                    ));

                // Navigator.push(context,MaterialPageRoute(builder: (context) => BidView(controller: bidController, approvedBid: false),),);
                // bidController.dispose();
              },
            ),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Icon(Icons.receipt, size: 26, color: Colors.black),
              ),
              title: const Text('Approved Bids'),
              selected: false,
              onTap: () async {
                // print("working recent bid :");
                BidController bd = Get.put(BidController());
                await bd.fetchBidItems();
                // ignore: use_build_context_synchronously
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => BidView(
                          items: bidController.bidItemsList.isEmpty
                              ? []
                              : bidController.bidItemsList.first.items!,
                          approvedBid: true,
                          buyerId: bidController.bidItemsList.isEmpty
                              ? ""
                              : bidController.bidItemsList.first.buyer!),
                    ));

                // Navigator.push(context,MaterialPageRoute(builder: (context) => BidView(controller: bidController, approvedBid: false),),);
                // bidController.dispose();
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app_rounded),
              title: const Text('Logout'),
              selected: false,
              onTap: () {
                controller.clearfields();
                controller.isLoading.value = false;
                Get.offAllNamed('loginScreen');
              },
            ),
          ],
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        heroTag: UniqueKey(),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        enableFeedback: true,
        backgroundColor: Colors.orange[800],
        // shape: CircleBorder(
        //     side: BorderSide(
        //         color: const Color.fromARGB(96, 255, 255, 255),
        //         width: 5,
        //         strokeAlign: 0)),

        onPressed: () {
          AuthenticateController.userdata.first.verification == false
              ? Get.snackbar(
                  AuthenticateController.userdata.first.fullname.toString(),
                  "Your profile is not verified")
              : Get.toNamed("addProduct");
        },
        child: const Icon(
          Icons.add,
          size: 42,
        ),
      ),
    );
  }
}
