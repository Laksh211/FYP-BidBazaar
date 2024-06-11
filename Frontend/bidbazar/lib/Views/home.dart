import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/controllers/cart_controller.dart';
import 'package:bidbazar/controllers/product_controller.dart';
import 'package:bidbazar/controllers/wishList_controller.dart';
import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/widgets/filter.dart';
import 'package:bidbazar/widgets/productView.dart';
import 'package:bidbazar/widgets/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({super.key});

  // void favourite() {
  //   // for (var element in controller.productList) {

  //   // }
  //   controller.productList.forEach((element) {
  //     print(wishListController.wishlist.contains(element));
  //     // print();
  //   });
  // }
  cartController cart =
      AuthenticateController.userdata.first.usertype == "Buyer"
          ? Get.put(cartController())
          : cartController();

  RxMap<String, bool> categoryCheck = {
    "Samsung": false,
    "Apple": false,
    "Xiaomi": false,
    "Oppo": false,
    "Qmobile": false,
    "House": false,
    "Bike": false,
    "Car": false,
  }.obs;

  product_controller controller = Get.put(product_controller());
  RxList<productModel> filterProducts = (<productModel>[].obs);
  final SearchController search = SearchController();
  RxList<productModel> searchProducts =
      (<productModel>[].obs); // AuthenticateController

  RangeValues values = const RangeValues(0, 1000000);
  WishListController wishListController = Get.put(WishListController());

  List<productModel> getSearchProducts() {
    return controller.productList
        .where(
          (element) => element.name!.toLowerCase().contains(
                search.text.toLowerCase(),
              ),
        )
        .toList();
  }

  List<productModel> getCategoryProducts(String Category) {
    print("66240a0ad4e14c0c3ac5cdc3");
    return controller.productList
        .where(
          (element) => element.category!.contains(Category),
        )
        .toList();
  }

  void setListOfCategoryProduct() {
    filterProducts.addAllIf(categoryCheck["Apple"],
        getCategoryProducts("657a009a97fc47d6213e770e"));
    filterProducts.addAllIf(
      categoryCheck["Samsung"],
      getCategoryProducts("6556628c382b1a3cca976166"),
    );
    filterProducts.addAllIf(
      categoryCheck["Oppo"],
      getCategoryProducts("655ce3088c13da238261e355"),
    );
    filterProducts.addAllIf(
      categoryCheck["Xiaomi"],
      getCategoryProducts("655cd3d88c13da238261e353"),
    );
    filterProducts.addAllIf(
      categoryCheck["Qmobile"],
      getCategoryProducts("655662a8382b1a3cca976169"),
    );
    filterProducts.addAllIf(
      categoryCheck["House"],
      getCategoryProducts("662409ded4e14c0c3ac5cdc2"),
    );
    filterProducts.addAllIf(
      categoryCheck["Bike"],
      getCategoryProducts("66240a16d4e14c0c3ac5cdc4"),
    );
    filterProducts.addAllIf(
      categoryCheck["Car"],
      getCategoryProducts("66240a0ad4e14c0c3ac5cdc3"),
    );
  }

  List<productModel> filterByPrice(double start, double end) {
    if (!filterProducts.isEmpty) {
      print("filter run");
      return filterProducts.where(
        (element) {
          if (element.price! > start && element.price! < end) {
            return true;
          } else {
            return false;
          }
        },
        // search.text.toLowerCase(),
        // ),
      ).toList();
    } else {
      return [];
      // return controller.productList.where(
      //   (element) {
      //     if (element.price! > start && element.price! < end) {
      //       return true;
      //     } else {
      //       return false;
      //     }
      //   },
      //   // search.text.toLowerCase(),
      //   // ),
      // ).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    // favourite();
    // final size = MediaQuery.of(context).size;

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          // forceElevated: true,
          // excludeHeaderSemantics: true,
          // iconTheme: IconThemeData(color: Colors.white),
          // snap: true,
          // forceMaterialTransparency: false,

          iconTheme: IconThemeData(
              color: innerBoxIsScrolled
                  ? const Color.fromARGB(255, 0, 0, 0)
                  : const Color.fromARGB(255, 255, 255, 255)),
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,

            // title: Text('Hi Laksh ajeet',style: TextStyle(color: Colors.white)),
            stretchModes: const [
              StretchMode.fadeTitle,
              // StretchMode.blurBackground,
              // StretchMode.zoomBackground
            ],
            background: Stack(
              children: [
                Container(
                  // height: 150,
                  // width: double.infinity,
                  color: Colors.orange,
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 60,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  height: 200,
                  bottom: 0,
                  // right: 0,
                  width: Get.width * 1,
                  child: Image.asset(
                    'assets/sale.jpg',
                    fit: BoxFit.fitWidth,
                    // height: 400,
                  ),
                ),
              ],
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          foregroundColor: innerBoxIsScrolled ? Colors.black : Colors.white,
          centerTitle: true,
          title: SearchAnchor(
            // viewHintText: ,
            // viewLeading: Text("back"),
            viewTrailing: List.generate(
              1,
              (index) => TextButton(
                onPressed: () {
                  if (!search.text.isEmpty) {
                    var list =
                        getSearchProducts(); //get strams of search products

                    if (list.isNotEmpty) {
                      searchProducts.assignAll(list);

                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => CustomSearch(
                            isScrolledColor: innerBoxIsScrolled,
                            onlySearch: false,
                            searchProducts: searchProducts,
                            userType: controller.usertypes,
                          ),
                        ),
                      );
                      // Get.toNamed("customSearch", arguments: [
                      //   {"searchProducts": searchProducts},
                      //   {"onlySearch": false}
                      // ]);
                      // customSearch(
                      //   onlySearch: false,
                      //   searchProducts: searchProducts,
                      // );
                    }
                  }
                  // gridItem(product: searchProducts, index: index)
                },
                child: const Text("Search"),
              ),
            ),
            searchController: search,
            builder: (context, search) {
              return SizedBox(
                height: Get.height * 0.1 / 2.5,
                child: CustomSearch(
                  isScrolledColor: innerBoxIsScrolled,
                  onlySearch: true,
                  OnTap: () {
                    search.openView();
                  },
                ),
              );
            },
            suggestionsBuilder: (context, search) {
              if (!search.isOpen) {
                print("not open ");
                search.clear();
              }

              // print(search.text.isEmpty);
              if (search.isOpen == true && !(search.text.isEmpty)) {
                var list = getSearchProducts(); //get strams of search products
                //  print("list");
                if (list.isEmpty) {
                  return List.generate(
                      1,
                      (index) => const ListTile(
                            title: Text("No product found"),
                          ));
                }
                print(list);
                searchProducts.assignAll(list);
              } else {
                searchProducts.clear();
              }

              // showSearch(context: context, delegate)
              return List.generate(
                //search list
                // searchProducts.length ?? 0,
                searchProducts.length,
                (index) {
                  productModel product = searchProducts[index];
                  return Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(searchProducts[index].name!),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {
                          

                          Get.toNamed(
                            "productDetailScreen",
                            arguments: [
                              product,
                              controller.usertypes,
                              null,
                              true
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            },
            // viewBuilder: (suggestions) {
            //   return ListTile(
            //     title: Text("history"),
            //   );
            // },
          ),
          expandedHeight: 200,
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: Container(
            color: Colors.orange[800],
            width: 100,
            height: 20,
            child: const Center(
              child: Text('Welcom to over bidbazar App',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],

      // floatHeaderSlivers: true,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          // borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))
        ),
        // width: size.width * 1,
        // height: size.height * 1,
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Column(
          children: [
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 15),
            //   child:,
            // ),
            //    SizedBox(
            //   height: Get.height * 0.1 / 2,
            //   child: SearchBar(
            //     hintText: "Search",
            //     textStyle: MaterialStatePropertyAll(TextStyle(fontSize: 17)),
            //     elevation: MaterialStatePropertyAll(0),
            //     leading: Icon(Icons.search_rounded),
            //     padding: MaterialStatePropertyAll(
            //         EdgeInsets.symmetric(horizontal: 15)),
            //     backgroundColor:
            //         MaterialStatePropertyAll(Color.fromARGB(255, 238, 238, 238)),
            //     onTap: () {
            //       Get.toNamed("searchScreen");
            //     },
            //   ),
            // ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: InkWell(
                        child: ListTile(
                            dense: true,
                            leading: Icon(
                              Icons.filter_list,
                              color: Colors.amber[900],
                            ),
                            title: const Text("Filter")),
                        onTap: () {
                          // RangeLabels labels = RangeLabels(
                          //     values.start.toString(), values.end.toString());

                          showModalBottomSheet(
                            isScrollControlled: true,
                            enableDrag: true,
                            anchorPoint: const Offset(100, 100),
                            routeSettings: CupertinoPage(
                              child: Container(
                                height: Get.height * 1,
                                width: Get.width * 1,
                                child: const Text("data"),
                              ),
                            ),
                            context: context,
                            builder: (context) {
                              //filter products
                              return Wrap(
                                children: [
                                  const Center(
                                      // child: Icon(Icons.filter_list),
                                      ),
                                  // ListTile(
                                  //   title: Text(
                                  //     'Filter',
                                  //     style: TextStyle(),
                                  //   ),
                                  //   // tileColor: theme.colorScheme.primary,
                                  // ),,
                                  const Divider(),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      "Price",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  Obx(
                                    () {
                                      print("Slider working");
                                      return RangeSlider(
                                        labels: RangeLabels(
                                            controller.startLabel.string,
                                            controller.endLabel.string),
                                        // min: 0,
                                        // max: 100000,
                                        divisions: 100,
                                        activeColor: Colors.orange[900],
                                        inactiveColor: Colors.orange[700],
                                        min: 0,
                                        max: 1000000,
                                        values: RangeValues(
                                            values.start, values.end),
                                        onChanged: (value) {
                                          values = value;
                                          // controller.values.end = value.end;

                                          controller.startLabel.value =
                                              value.start.toInt().toString();

                                          controller.endLabel.value =
                                              value.end.toInt().toString();
                                        },
                                      );
                                    },
                                  ),
                                  const Divider(),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Text("Category"),
                                  ),
                                  Container(
                                    width: Get.width * 0.95,
                                    height: 50,
                                    child: Obx(
                                      () => ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ChoiceChip(
                                              // showCheckmark: true,
                                              label: const Text("Samsung"),
                                              // selectedColor: Colors.orange[200],
                                              selected:
                                                  categoryCheck["Samsung"]!,
                                              onSelected: (value) {
                                                categoryCheck["Samsung"] =
                                                    categoryCheck["Samsung"] ==
                                                            true
                                                        ? false
                                                        : true;
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ChoiceChip(
                                              // showCheckmark: true,
                                              label: const Text("Apple"),
                                              selected: categoryCheck["Apple"]!,
                                              onSelected: (value) {
                                                categoryCheck["Apple"] =
                                                    categoryCheck["Apple"] ==
                                                            true
                                                        ? false
                                                        : true;

                                                // .assignAll(items);
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ChoiceChip(
                                              // showCheckmark: true,
                                              label: const Text("Xiaomi"),
                                              selected:
                                                  categoryCheck["Xiaomi"]!,
                                              onSelected: (value) {
                                                categoryCheck["Xiaomi"] =
                                                    categoryCheck["Xiaomi"] ==
                                                            true
                                                        ? false
                                                        : true;
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ChoiceChip(
                                              // showCheckmark: true,
                                              label: const Text("Oppo"),
                                              selected: categoryCheck["Oppo"]!,
                                              onSelected: (value) {
                                                categoryCheck["Oppo"] =
                                                    categoryCheck["Oppo"] ==
                                                            true
                                                        ? false
                                                        : true;
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ChoiceChip(
                                              // showCheckmark: true,
                                              label: const Text("Qmobile"),
                                              selected:
                                                  categoryCheck["Qmobile"]!,
                                              onSelected: (value) {
                                                categoryCheck["Qmobile"] =
                                                    categoryCheck["Qmobile"] ==
                                                            true
                                                        ? false
                                                        : true;
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ChoiceChip(
                                              // showCheckmark: true,
                                              label: const Text("House"),
                                              selected: categoryCheck["House"]!,
                                              onSelected: (value) {
                                                categoryCheck["House"] =
                                                    categoryCheck["House"] ==
                                                            true
                                                        ? false
                                                        : true;
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ChoiceChip(
                                              // showCheckmark: true,
                                              label: const Text("Bike"),
                                              selected: categoryCheck["Bike"]!,
                                              onSelected: (value) {
                                                categoryCheck["Bike"] =
                                                    categoryCheck["Bike"] ==
                                                            true
                                                        ? false
                                                        : true;
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ChoiceChip(
                                              // showCheckmark: true,
                                              label: const Text("Car"),
                                              selected: categoryCheck["Car"]!,
                                              onSelected: (value) {
                                                categoryCheck["Car"] =
                                                    categoryCheck["Car"] == true
                                                        ? false
                                                        : true;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.orange[800],
                                      ),
                                      onPressed: () {
                                        // Get.toNamed("filterScreen",
                                        //     arguments: );
                                        filterProducts.clear();
                                        setListOfCategoryProduct();

                                        // filterProducts.addAll(items);
                                        filterProducts.assignAll(filterByPrice(
                                            values.start, values.end));
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) {
                                              return FilterProduct(
                                                  productList: filterProducts);
                                            },
                                          ),
                                        );
                                        // Get.toNamed("filterScreen",
                                        //     arguments: controller.productList);
                                      },
                                      child: const Text("Filter"),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                          // showBottomSheet(
                          //   enableDrag: true,
                          //   context: context,
                          //   builder: (context) {
                          //     // final theme = Theme.of(context);
                          //     return Wrap(
                          //       children: [
                          //         ListTile(
                          //           title: Text(
                          //             'Header',
                          //             style: TextStyle(),
                          //           ),
                          //           // tileColor: theme.colorScheme.primary,
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 15,
                child:
                    AuthenticateController.userdata.first.usertype == "Seller"
                        ? productView(
                            productList: controller.productList,
                            isProductDelete: true, //show delete option
                          )
                        : productView(
                            cart: cart,
                            productList: controller.productList,
                            isProductDelete: false,
                          ))
          ],
        ),
      ),
    );
  }
}
