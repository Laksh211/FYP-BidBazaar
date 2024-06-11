// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:ui';

import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/controllers/bidController.dart';
import 'package:bidbazar/controllers/cart_controller.dart';
import 'package:bidbazar/controllers/product_controller.dart';
// import 'package:bidbazar/controllers/product_controller.dart';
import 'package:bidbazar/controllers/wishList_controller.dart';
import 'package:bidbazar/core/api.dart';
import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/data/models/user_model.dart';
import 'package:bidbazar/widgets/customTextFormField.dart';
import 'package:bidbazar/widgets/updateproduct.dart';
// import 'package:bidbazar/data/models/wishListModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ProductDetailScreen extends GetView<product_controller> {
  ProductDetailScreen({super.key, this.type});

  static const routeName = "/productDetailScreen";

  BidController bidController = BidController();
  final bidFormKey = GlobalKey<FormState>();
  RxList<DropdownMenuItem> bidMenu = (List<DropdownMenuItem>.of([])).obs;
  RxInt bidPrice = 0.obs;
  final TextEditingController bidPriceController = TextEditingController();
  cartController cartControlle = Get.put(cartController());
  productModel product = Get.arguments[0];
  String? type;
  String userType = Get.arguments[1];
  bool showpersistentFooterButtons = Get.arguments[3] ?? false;
  // WishListController wishlistController;
  bool isProductExpire = false;
  // String currentdate;
  // product_controller productController =
  // Get.arguments[2] ?? product_controller();
  // int? index = Get.arguments[3];
  String imageUrl = "";
  String productName = "";
  String productSpecs = "";
  userModel? user;

  @override
  Widget build(BuildContext context) {
    productSpecs = product.specs!;
    productSpecs = product.specs!;
    imageUrl = "${Api.BASE_URL}/images/${product.images!.first}";
    // var currentDate=(DateTime.now()).toString().split("-").getRange(0, 3).toList();
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;
    int currentDay = DateTime.now().day;

    var date = product.createdat!
        .split("/")
        .getRange(0, 3)
        .toList(); //[0] is day [1] is month [2] is year
    int productExpireDay = int.parse(date[0]);
    int productExpireMonth = int.parse(date[1]);
    int productExpireYear = int.parse(date[2]);

    bool isProductExpired(int currentYear, int currentMonth, int currentDay,
        int productExpireYear, int productExpireMonth, int productExpireDay) {
      DateTime currentDate = DateTime(currentYear, currentMonth, currentDay);
      DateTime productExpireDate =
          DateTime(productExpireYear, productExpireMonth, productExpireDay);

      return currentDate.isAfter(productExpireDate) ||
          currentDate.isAtSameMomentAs(productExpireDate);
    }

    isProductExpire = isProductExpired(
        currentYear,
        currentMonth,
        currentDay,
        productExpireYear,
        productExpireMonth,
        productExpireDay + 3);// add 3 plus day for product expiration

    // currentYear >= productExpireYear &&
    //         currentMonth >= productExpireMonth &&
    //         currentDay >=
    //             productExpireDay +
    //                 3 //product expire plus 3 days of created date
    //     ? isProductExpire = true
    //     : null;
    // if(productExpireYear==currentYear && currentMonth ==
    //  productExpireMonth && productExpireDay+3 == currentDay ){
    // }
    // bidController.text= product.price.toString();

    if (bidMenu.isEmpty) {
      bidPrice.value = product.price!;
      bidMenu.addAll([
        DropdownMenuItem(value: product.price!, child: const Text("0% Down")),
        DropdownMenuItem(
            value: (product.price! - product.price! * 0.05).round(),
            child: const Text("5% Down")),
        DropdownMenuItem(
            value: (product.price! - product.price! * 0.1).round(),
            child: const Text("10% Down")),
        DropdownMenuItem(
            value: (product.price! - product.price! * 0.15).round(),
            child: const Text("15% Down")),
        DropdownMenuItem(
            value: (product.price! - product.price! * 0.2).round(),
            child: const Text("20% Down"))
      ]);
    }

    final size = MediaQuery.of(context).size;
    // print("data");
    // productController.isWishListed.value = product.wishlist!;
    return WillPopScope(
      onWillPop: () async {
        print("back button pressed");

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black87),
          centerTitle: true,
          elevation: 0,
          actions: [
            userType == "Buyer"
                ? SizedBox(
                    width: 40,
                    height: 40,
                    child: SpeedDial(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      direction: SpeedDialDirection.down,
                      //  animatedIcon: AnimatedIcons.view_list,
                      overlayColor: Colors.black,
                      overlayOpacity: 0.5,
                      children: [
                        SpeedDialChild(
                          child: const Icon(
                            Icons.share,
                          ),
                          label: 'Share',
                          onTap: () async {
                            await downloadAndShare();
                          },
                        ),
                        SpeedDialChild(
                          child: const Icon(
                            Icons.call,
                          ),
                          label: 'Phone',
                          onTap: () async {
                            AuthenticateController cartControlle =
                                AuthenticateController();
                            var user = await cartControlle
                                .findUserById("655a7e77876d92cd633d5968");
                            final Uri phone =
                                Uri.parse('tel:+92${user.mobile}');
                            if (await canLaunchUrl(phone)) {
                              await launchUrl(phone);
                            } else {
                              Get.snackbar(
                                  "Could not launch ", user.mobile.toString());
                              // throw 'Could not launch $whatsapp';
                            }
                          },
                        ),
                        SpeedDialChild(
                          child: const Icon(Icons.call),
                          label: 'Whatsapp',
                          onTap: () async {
                            AuthenticateController controller =
                                AuthenticateController();
                            var user = await controller
                                .findUserById("655a7e77876d92cd633d5968");
                            final Uri whatsapp =
                                Uri.parse('http://wa.me/${user.mobile}');
                            await launchUrl(whatsapp);

                            // throw 'Could not launch $whatsapp';
                          },
                        ),
                      ],
                      child: const Icon(
                        Icons.more_vert_outlined,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: controller.obx(
          (state) => Container(
            child: ListView(
              children: [
                Hero(
                  tag: product.sId.toString(),
                  child: PageStorage(
                    bucket: PageStorageBucket(),
                    child: Container(
                      height: Get.height * 0.3 / 1.1,
                      child: CarouselSlider.builder(
                        // image slider widget
                        itemCount: product.images?.length,
                        itemBuilder: (context, index, realIndex) {
                          return CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                "${Api.BASE_URL}/images/${product.images!.elementAt(index)}",
                          );
                        },

                        options: CarouselOptions(
                          // aspectRatio: 16 / 9,

                          // enlargeCenterPage: true,
                          // enlargeFactor: 1,
                          viewportFraction: 1,
                          autoPlay: true,
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 5,
                  thickness: 10,
                ),

                Card(
                  elevation: 2,
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    titleTextStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        product.name!.toUpperCase(),
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        const Text("Rs "),
                        Text(
                          product.price.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    trailing: Column(children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Icon(Icons.timer_sharp),
                      Text(
                          "${isProductExpire ? 0 : productExpireDay + 3 - currentDay}d")
                    ]),
                    //   trailing: userType == "Buyer"
                    //       ? InkWell(
                    //           onTap: () async {
                    //             AuthenticateController controller =
                    //                 AuthenticateController();
                    //             var user = await controller
                    //                 .findUserById("655a7e77876d92cd633d5968");
                    //             final Uri whatsapp =
                    //                 Uri.parse('http://wa.me/${user.mobile}');
                    //             final Uri phone = Uri.parse('tel:+92${user.mobile}');
                    //            showModalBottomSheet(
                    //             context: context,
                    //             builder: (context) {
                    //             return Row(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: [
                    //                 Text("Phone "),
                    //               IconButton(onPressed: ()async {
                    //                if(await canLaunchUrl(phone)){
                    //            await launchUrl(phone);
                    //           }
                    //            else {
                    //             Get.snackbar("Could not launch ", user.mobile.toString());
                    //             // throw 'Could not launch $whatsapp';
                    //           }
                    //               }, icon: Icon(Icons.call),
                    //                     ),
                    //                      Text("whatsapp "),
                    //               IconButton(onPressed: ()async {
                    //                 // if (await  canLaunchUrl(whatsapp)) {
                    //             await launchUrl(whatsapp);
                    //             // launchUrlString(whatsapp.toString());
                    //           // }
                    //           //  else {
                    //             // Get.snackbar("Could not launch ", user.mobile.toString());
                    //             // throw 'Could not launch $whatsapp';
                    //           // }
                    //               }, icon:Icon(Icons.call) )
                    //             ]);
                    //           },);
                    //           // if (await canLaunchUrl(whatsapp)) {
                    //           //   await launchUrl(whatsapp);
                    //           // }else if(await canLaunchUrl(phone)){
                    //           //  await launchUrl(phone);
                    //           // }
                    //           //  else {
                    //           //   Get.snackbar("Could not launch ", user.mobile.toString());
                    //           //     // throw 'Could not launch $whatsapp';
                    //           // }
                    //             print(user.mobile);
                    //             print(product.user);
                    //           },
                    //           child: Icon(
                    //             Icons.call_outlined,
                    //             size: 30,
                    //             // color: Colors.amber[900],
                    //             fill: 1,
                    //           ),
                    //         )
                    //       :
                    //       SizedBox.shrink(),
                    //   // trailing: Obx(
                    //   //   () => productController.isWishListed.value == false
                    //   //       ? Icon(
                    //   //           Icons.favorite_outline_rounded,
                    //   //           size: 30,
                    //   //         )
                    //   //       : Icon(
                    //   //           Icons.favorite_outlined,
                    //   //           size: 30,
                    //   //           color: Colors.amber[900],
                    //   //           fill: 1,
                    //   //         ),
                    //   // ),
                  ),
                ),
                userType == "Seller"
                    ? isProductExpire == true
                        ? Card(
                            elevation: 2,
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              titleTextStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                              title: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  "Product Expired",
                                ),
                              ),
                              subtitle: Text(
                                "Expired Date ${(productExpireDay + 3)}D ${productExpireMonth}M ${productExpireYear}Y",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              trailing: TextButton(
                                  style: TextButton.styleFrom(
                                      shape: const ContinuousRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          side: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 158, 158, 158)))),
                                  onPressed: () async {
                                    await controller.renewProduct(
                                        productId: product.sId!);

                                    product.createdat =
                                        "$currentDay/$currentMonth/$currentYear";
                                    print("New date ${product.createdat}");

                                    // Update the page state
                                    controller.refresh();
                                    // Optionally, you can use Get.back() to pop the screen
                                    // instead of Navigator.of(context).pop();
                                    Get.back();
                                  },
                                  child: const Text(
                                    "Renew product",
                                    style: TextStyle(color: Colors.grey),
                                  )),
                            ),
                          )
                        : const SizedBox.shrink()
                    : const SizedBox.shrink(),

                userType == "Buyer"
                    ? const SizedBox.shrink()
                    : Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Product auto sold price Rs-${product.saleonprice}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                Card(
                  elevation: 1,
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 16,
                            wordSpacing: 2,
                            leadingDistribution:
                                TextLeadingDistribution.proportional,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product.specs.toString(),
                          style: const TextStyle(
                            fontSize: 15,
                            wordSpacing: 2,
                            color: Colors.grey,
                            leadingDistribution:
                                TextLeadingDistribution.proportional,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
                // const ListTile(
                //   title: Text("sellers"),
                //   // dense: true,
                //   leading: CircleAvatar(
                //     backgroundColor: Color.fromARGB(22, 0, 0, 0),
                //     child: Icon(Icons.person,color: Colors.black54,)),
                // )
                FutureBuilder(
                  future: AuthenticateController().findUserById(product.user!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "${Api.BASE_URL}/images/${snapshot.data!.profileimages!.first}",
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.person,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                          title: Text(snapshot.data!.fullname!),
                          subtitle: Text(snapshot.data!.email!),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('No data found'),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),

        // persistentFooterAlignment: AlignmentDirectional.centerStart,

        persistentFooterButtons: isProductExpire
            ? []
            : showpersistentFooterButtons == true
                ? <Widget>[
                    const SizedBox(
                      height: 1,
                    ),
                    SizedBox(
                      height: 35,
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(
                                        Get.width * 0.3, Get.height * 0.1 / 2),
                                    backgroundColor: Colors.amber[900],
                                  ),
                                  onPressed: () {
                                    // productModel Product=productModel(
                                    //   category: product.category,
                                    //   images: product.images,
                                    //   name: product.name,
                                    //   price: int.parse(bidController.text),
                                    //   qty: product.qty??1,
                                    //   sId: product.sId,
                                    //   specs: product.specs,
                                    //   user: product.user,
                                    //   wishlist: product.wishlist,
                                    // );
                                    // product ;
                                    // Product.price=;

                                    userType == "Buyer"
                                        ? {
                                            cartControlle.addToCart(product, 1),
                                            cartControlle.carStateSuccess(),
                                            Get.snackbar("Add to cart",
                                                "Product added to your cart")
                                          }
                                        : Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  UpdateProduct(
                                                product: product,
                                              ),
                                            ));
                                  },
                                  child: userType == "Buyer"
                                      ? const Icon(Icons.shopping_cart_outlined)
                                      : const Text(
                                          "Edit Product",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.009,
                                ),
                                userType == "Buyer"
                                    ? ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(Get.width * 0.49,
                                              Get.height * 0.1 / 2),
                                          backgroundColor: Colors.amber[900],
                                        ),
                                        onPressed: () {
                                          AuthenticateController.userdata.first
                                                      .verification ==
                                                  true
                                              ? Get.defaultDialog(
                                                  confirm: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        minimumSize: Size(
                                                            Get.width * 0.4,
                                                            Get.height *
                                                                0.1 /
                                                                2),
                                                        backgroundColor:
                                                            Colors.amber[900],
                                                      ),
                                                      onPressed: () async {
                                                        print(
                                                            "price of bid product ${bidPriceController.text}");
                                                        if (bidFormKey
                                                            .currentState!
                                                            .validate()) {
                                                          await bidController.addBid(product.sId!,product.user!, int.parse(bidPriceController.text.toString()));

                                                          // if (int.parse(
                                                          //         bidPriceController
                                                          //             .text) >=
                                                          //     product
                                                          //         .saleonprice!) {
                                                          //   print(
                                                          //       "price is less then ${bidPriceController.text} >= ${product.saleonprice}");
                                                          //   await bidController.updateBidStatus(
                                                          //       buyerId:
                                                          //           AuthenticateController
                                                          //               .userdata
                                                          //               .first
                                                          //               .sId!,
                                                          //       productId:
                                                          //           product
                                                          //               .sId!,
                                                          //       status:
                                                          //           "bid approved and closed");
                                                          //   productModel newProduct = productModel(
                                                          //       price: int.parse(
                                                          //           bidPriceController
                                                          //               .text),
                                                          //       category: product
                                                          //           .category,
                                                          //       images: product
                                                          //           .images,
                                                          //       name: product
                                                          //           .name,
                                                          //       qty:
                                                          //           product.qty,
                                                          //       sId:
                                                          //           product.sId,
                                                          //       saleonprice: product
                                                          //           .saleonprice,
                                                          //       soldqty: product
                                                          //           .soldqty,
                                                          //       specs: product
                                                          //           .specs,
                                                          //       user: product
                                                          //           .user,
                                                          //       wishlist: product
                                                          //           .wishlist);
                                                          //   // p=product;
                                                          //   // p.price=;
                                                          //   cartControlle
                                                          //       .addToCart(
                                                          //           newProduct,
                                                          //           1);
                                                          //   cartControlle
                                                          //       .carStateSuccess();
                                                          //   // bidController.bidItemsList.add(BidModel(buyer:AuthenticateController.userdata.first.id , items: [Items(bidprice: int.parse(bidPriceController.text) , product: product, quantity: 1 , status: "bid approved and closed")]));
                                                          //   //  await bidController.fetchBidItems();
                                                          //   // bidController.update();
                                                          //   // bidController.bidItemsList.refresh();
                                                          //   Get.snackbar("Bid",
                                                          //       "Bid Successfully approved");
                                                          //   Navigator.pop(
                                                          //       context);
                                                          // }
                                                          Navigator.pop(context);
                                                          //  bidPriceController.clear();

                                                          // Navigator.pop(context);
                                                        }
                                                      },
                                                      child: const Text(
                                                        "Confirm",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      )),
                                                  title: 'BID',
                                                  // middleText: 'BID',
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        Obx(
                                                          () => DropdownButton(
                                                            enableFeedback:
                                                                true,
                                                            value:
                                                                bidPrice.value,
                                                            items: bidMenu,
                                                            onChanged: (value) {
                                                              bidPrice.value =
                                                                  value;
                                                              bidPriceController
                                                                      .text =
                                                                  value
                                                                      .toString();
                                                              // bidController.text=value.toString();
                                                              //  bidController.text = value.toString();
                                                              // print(value);
                                                              // catController.update();
                                                            },
                                                          ),
                                                        ),
                                                        Center(
                                                          child: Container(
                                                            width: size.width *
                                                                0.6,
                                                            height:
                                                                size.height *
                                                                    0.1,
                                                            child: Form(
                                                              key: bidFormKey,
                                                              child:
                                                                  customTextFormField(
                                                                controller:
                                                                    bidPriceController,
                                                                labelText:
                                                                    'Bid',
                                                                prefixIconData:
                                                                    Icons
                                                                        .price_change,
                                                                // hintText: 'Email Address',
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .next,
                                                                autofocus:
                                                                    false,
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    return "Bid can not be Empty";
                                                                  } else if ((product
                                                                              .price! -
                                                                          product.price! *
                                                                              0.2) >
                                                                      int.parse(
                                                                          bidPriceController
                                                                              .text)) {
                                                                    return "Bid can not lower then 20%";
                                                                  } else if (int.parse(
                                                                          bidPriceController
                                                                              .text) >
                                                                      product
                                                                          .price!) {
                                                                    return "Bid price can not higher then product price.";
                                                                  } else {
                                                                    return null;
                                                                  }

                                                                  // return controller.validateEmail(value!);
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Get.snackbar(
                                                  AuthenticateController
                                                      .userdata.first.fullname
                                                      .toString(),
                                                  "Your profile is not verified.");
                                        },
                                        child: const Text(
                                          "Bid",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      )
                                    : SizedBox.fromSize(
                                        size: Size(Get.width * 0.4, 30)),
                                SizedBox(
                                  width: Get.width * 0.0001,
                                ),
                                InkWell(
                                  onTap: () {
                                    WishListController wishListController =
                                        Get.put(WishListController());
                                    wishListController.Favourite(
                                      // add and delete functionality
                                      product,
                                      product.sId.toString(),
                                    );
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                    child: Icon(
                                      Icons.favorite_border_rounded,
                                      // fill: 10,
                                      size: 32,
                                      color: Color.fromARGB(255, 255, 111, 0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //  IconButton(
                          //         onPressed: () async {
                          //           WishListController wishListController =
                          //               Get.put(WishListController());
                          //           wishListController.Favourite(
                          //             // add and delete functionality
                          //             product,
                          //             product.sId.toString(),
                          //           );

                          //           // wishListController.wishlist.add(wishListModel(
                          //           //   product: product,
                          //           //   user: AuthenticateController.userdata.first.sId,
                          //           // ));
                          //           // wishListController.fetchWishListItems();
                          //           // productController.productList[index].wishlist =
                          //           //     await productController.wishlistProduct(
                          //           //         productId: product.sId!);

                          //           // productController.isWishListed.value;
                          //           // print(productController.isWishListed.value);
                          //         },
                          //         icon:  Icon(
                          //           Icons.favorite_border_rounded,
                          //           // fill: 10,
                          //           size: 32,
                          //           color: Color.fromARGB(255, 255, 111, 0),
                          //         ),
                          //       ),
                        ],
                      ),
                    ),
                  ]
                : [const SizedBox.shrink()],
        // // : null,
        // floatingActionButton: FloatingActionButton.small(
        //   backgroundColor: Colors.orange[800],
        //   onPressed: () {},
        //   child: Icon(Icons.call_outlined),
        // ),
      ),
    );
  }

  Future<void> downloadAndShare() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final tempPath = tempDir.path;

      // image file path set
      final imagePath = '$tempPath/${product.images!.first.split('/').last}';

      // Download image
      final response = await Dio().download(imageUrl, imagePath);

      // Check if download was successful
      if (response.statusCode == 200) {
        // Share the image and text
        await Share.shareFiles(
          [imagePath],
          text: "$imageUrl \n$productName\n specs: $productSpecs",
        );
      } else {
        throw Exception('Failed to download image');
      }
    } catch (e) {
      // Handle any errors
      print('Error downloading and sharing image: $e');
    }
  }
}
