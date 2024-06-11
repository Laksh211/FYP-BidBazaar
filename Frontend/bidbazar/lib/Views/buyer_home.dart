import 'package:bidbazar/Views/bidviewforbuyer.dart';
import 'package:bidbazar/Views/buyer/cart.dart';
import 'package:bidbazar/Views/complaint.dart';
import 'package:bidbazar/controllers/bidController.dart';
import 'package:bidbazar/controllers/wishList_controller.dart';
import 'package:bidbazar/core/api.dart';
import 'package:bidbazar/widgets/bidView.dart';
import 'package:bidbazar/widgets/category.dart';
import 'package:bidbazar/Views/home.dart';
import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/widgets/orderView.dart';
import 'package:bidbazar/widgets/order_status.dart';
import 'package:bidbazar/widgets/profile.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:bidbazar/widgets/wishList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Buyer extends StatelessWidget {
  Buyer({super.key});
  static const String routeName = '/buyerScreen';
  BidController bidController = Get.put(BidController());

  List<Widget> screens = [
    Home(),
    // message(),
    Category(),
    Cart(),
    // Library(),
    // hotlist(),
  ];
  AuthenticateController controller = Get.put(AuthenticateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => IndexedStack(
          // ignore: sort_child_properties_last
          children: screens,
          index: controller.screenIndex.value,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (value) {
            controller.screenIndex.value = value;
            // print('naj $value');
          },
          showSelectedLabels: true,
          selectedIconTheme: IconThemeData(color: Colors.amber[900]),
          // selectedLabelStyle: TextStyle(
          // ),
          selectedItemColor: Colors.amber[900],
          currentIndex: controller.screenIndex.value,
          selectedFontSize: 10,
          unselectedIconTheme: const IconThemeData(
            color: Colors.black54,
          ),
          iconSize: 27,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.message),
            //   label: 'Message',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_rounded),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Add to cart',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.person),
            //   label: 'Profile',
            // ),
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
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child:
                   AuthenticateController
                          .userdata.first.profileimages!.isNotEmpty
                      ? 
                      Image.network(
                          "${Api.BASE_URL}/images/${AuthenticateController.userdata.first.profileimages![0]}",
                          fit: BoxFit.cover,
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
            // Center(child: Text(AuthenticateController.userdata.first.fullname.toString(), style: Theme.of(context).textTheme.headlineSmall,)),
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
              // leading: Icon(Icons.receipt),
              leading: Image.asset(
                fit: BoxFit.contain,
                'assets/bidIcon.png',
                width: 35,
                height: 35,
              ),
              title: const Text('Bid Logs'),
              selected: false,
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => BidViewForBuyer(
                        controller: bidController,
                      ),
                    ));

                // Navigator.push(context,MaterialPageRoute(builder: (context) => BidView(controller: bidController, approvedBid:false ),),);
                // bidController.dispose();
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
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => OrderView(),
                    ));
              },
            ),
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
             ListTile(
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: const Icon(Icons.edit_document , size: 28 , color: Colors.black,),
              ),
              title: const Text('Complain'),
              // selected: true,
              onTap: () {
                 Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ComplaintScreen(),
                    ));
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
            //   onTap: () async{

            //     // ignore: use_build_context_synchronously
            //     Navigator.push(
            //         context,
            //         CupertinoPageRoute(
            //           builder: (context) => OrderFilter(title: "Pending Orders" ),
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
            //   onTap: () async{
            //     OrderController orderController = Get.put(OrderController());

            //    await orderController.fetchOrders();
            //      orderController.deliveredOrderFilter();
            //     Navigator.push(
            //         context,
            //         CupertinoPageRoute(
            //           builder: (context) => OrderFilter(title: 'Order Delivered'),
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
            //   onTap: ()async {
            //     OrderController orderController = Get.put(OrderController());

            //    await orderController.fetchOrders();
            //     orderController.canceldOrderFilter();
            //     Navigator.push(
            //         context,
            //         CupertinoPageRoute(
            //           builder: (context) => OrderFilter(title:'Order Canceled' ),
            //         ));
            //   },
            // ),
            ListTile(
              // leading: Icon(Icons.receipt),
              leading: Image.asset(
                fit: BoxFit.contain,
                'assets/approvedBid.png',
                width: 35,
                height: 45,
              ),
              title: const Text('Approved Bid Log'),
              selected: false,
              onTap: () async {
                bidController.bidItemsList.clear();
                await bidController.fetchBidItems();
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
                            : bidController.bidItemsList.first.buyer!,
                      ),
                    ));

                // Navigator.push(context,MaterialPageRoute(builder: (context) => BidView(controller: bidController , approvedBid: true,
                // ),),);
                // bidController.dispose();
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
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: const Icon(Icons.exit_to_app_rounded ,size: 30, color: Colors.black),
              ),
              title: const Text('Logout'),
              selected: false,
              onTap: () {
                imageCache.clear();
                imageCache.clearLiveImages();
                controller.clearfields();
                controller.isLoading.value = false;
                Get.offAllNamed('loginScreen');
              },
            ),
          ],
        ),
      ),
    );
  }
}
