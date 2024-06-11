import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/core/api.dart';
import 'package:bidbazar/data/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:bidbazar/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockUnblockUser extends GetView<AuthenticateController> {
  BlockUnblockUser({super.key, this.isBuyer});
  final bool? isBuyer;

  String query = '';
  AuthenticateController controller = Get.put(AuthenticateController());
  TextEditingController textEditingController = TextEditingController();
  // @override
  // void initState() {
  //   super.initState();
  //   widget.isBuyer==true?
  //   controller.fetchBuyers():controller.fetchSellers();
  // }

  @override
  Widget build(BuildContext context) {
    //   print("widget is woriwc");
    //  controller. users.clear();

    isBuyer == true ? controller.fetchBuyers() : controller.fetchSellers();
    print("list of sellers ${controller.listOfSeller.length}");
    return Scaffold(
      appBar: AppBar(
        title: Text(isBuyer == true ? "Buyer Accounts" : "Seller Accounts"),
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: controller.obx(
          (state) => RefreshIndicator(
                onRefresh: () async {
                  controller.update();
                },
                child: Column(
                  children: <Widget>[
                    customSearch(
                        textcontroller: textEditingController,
                        hintText: "Enter Name or Phone no and Cnic."),
                    Expanded(
                      child: PageStorage(
                        bucket: PageStorageBucket(),
                        child: Obx(
                          () => ListView.builder(
                            itemCount: controller.users.length,
                            // itemCount: isBuyer == true
                            //     ? controller.listOfBuyer.length
                            //     : controller.listOfSeller.length,
                            itemBuilder: (context, index) {
                              // final allUsers = isBuyer == true
                              //     ? controller.listOfBuyer[index]
                              //     : controller.listOfSeller[index];
                              final allUsers = controller.users[index];
                              return buildBuyer(
                                allUsers,
                                context
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          onEmpty: const Center(child: Text("There is no user to display")),
          onLoading: const Center(child: CircularProgressIndicator())),
    );
  }

  Widget buildBuyer(
    userModel buyer,
    BuildContext context
  ) =>
      ListTile(
        onTap: () async {
           showBottomSheet (
            enableDrag: true,

              context: context,
              builder: (context) {
                return Container(
                  width: Get.width*1,
                  height: 400,
                  color: Colors.white,
                  child: Column(
                    
                    children: [
                      // const Center(child: Text("Profile")),
                      // SizedBox(
                      //  width: 200,
                      //  height: 100,
                      //   child: Image.network(
                      //     "${Api.BASE_URL}/images/${buyer.profileimages![0]}",
                      //     fit: BoxFit.cover,
                      //     errorBuilder: (BuildContext context, Object exception,
                      //         StackTrace? stackTrace) {
                      //       return const Column(
                      //         children: [
                      //            Icon(
                      //           Icons.error, // Or any other icon
                      //           size: 50.0,
                               
                      //         ),
                      //         Text("No Image")
                      //         ],
                      //       );
                      //     },
                      //   ),
                      // ),

                       
                      Expanded(
                       
                        child: Image.network(
                          "${Api.BASE_URL}/images/${buyer.cnicimages![0]}",
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const Column(
                              children: [
                                 Icon(
                                Icons.error, // Or any other icon
                                size: 50.0,
                               
                              ),
                              Text("user not upload cnic 1 img")
                              ],
                            );
                          },
                        ),
                      ),
                      Expanded(
                       
                        child: CachedNetworkImage(
                          imageUrl: 
                          buyer.cnicimages!.length>1==true?
                          "${Api.BASE_URL}/images/${buyer.cnicimages![1] }":"",
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return const Column(
                              children: [
                                 Icon(
                                Icons.error, // Or any other icon
                                size: 50.0,
                               
                              ),
                              Text("user not upload cnic 2 img")
                              ],
                            );
                          },
                          
                        ),
                      ),

                    ],
                  ),
                );
              },
            );
        },
        // leading: Image.network(
        //   buyer.urlImage,
        //   fit: BoxFit.cover,
        //   width: 50,
        //   height: 50,
        // ),
        leading: SizedBox(
          width: 40,
          height: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                return const Icon(
                  Icons.person, // Or any other icon
                  size: 24,
                );
              },
              imageUrl: "${Api.BASE_URL}/images/${buyer.profileimages![0]}",
            ),
          ),
        ),
        title: Text(buyer.fullname!.toLowerCase()),
        subtitle: Text("${buyer.mobile!} - ${buyer.cnic!}"),
        trailing: TextButton(
          onPressed: () {
            // Your action here
            controller.blockUsers(userId: buyer.sId!);
            buyer.block = buyer.block == true ? false : true;
            // AuthenticateController controller=Get.put(AuthenticateController());
            controller.update();
          },
          style: TextButton.styleFrom(
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              side: BorderSide(
                color: Color.fromARGB(255, 158, 158, 158),
              ),
            ),
          ),
          child: Text(
            buyer.block == true ? 'Unblock' : 'Block',
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 16.0,
                fontWeight: FontWeight.w700),
          ),
        ),
      );

  searchuser({String? query}) {
    // controller.users.clear();
    List<userModel> filtered;
    isBuyer == true
        ? {
            filtered = controller.listOfBuyer.where((buyer) {
              final fullname = buyer.fullname!.toLowerCase();
              final mobile = buyer.mobile!.toLowerCase();
              final cnic = buyer.cnic!.toLowerCase();
              final searchLower = query!.toLowerCase();

              return fullname.contains(searchLower) ||
                  mobile.contains(searchLower) ||
                  cnic.contains(searchLower);
            }).toList()
          }
        : {
            filtered = controller.listOfSeller.where((buyer) {
              final fullname = buyer.fullname!.toLowerCase();
              final mobile = buyer.mobile!.toLowerCase();
              final cnic = buyer.cnic!.toLowerCase();
              final searchLower = query!.toLowerCase();
              return fullname.contains(searchLower) ||
                  mobile.contains(searchLower) ||
                  cnic.contains(searchLower);
            }).toList()
          };

    controller.users.value = filtered;

    // users.value = filteredUsers;
    print(
        "users ${controller.users} ${isBuyer} filtered ${filtered}  query ${query}");
    // users.refresh();
    // ignore: invalid_use_of_protected_member
    // controller.refresh();
    //  controller. users.refresh();

    // setState(() {
    //   this.query = query;
    //   this.users = filteredBuyers; // Update the state variable with filtered results
    // });
  }

  Widget customSearch({
    required TextEditingController textcontroller,
    required String hintText,
  }) {
// final AuthenticateController? controller;
    // final TextEditingController textcontroller;
    // final String hintText;
    // final String isBuyer;

    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.black26),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: textcontroller,
        decoration: InputDecoration(
          icon: Icon(
            Icons.search,
          ),
          suffixIcon: Icon(Icons.close),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black),
          border: InputBorder.none,
        ),
        style: TextStyle(color: Colors.black),
        onChanged: (value) {
          // function
          // bu.searchuser(query: textcontroller.text , isBuyer:isBuyer);
          searchuser(query: textEditingController.text);
        },
        // onChanged: widget.onChanged,
      ),
    );
  }
}

// class customSearch extends StatelessWidget {
//    customSearch({
//     super.key,
//     required this.textcontroller,
//     required this.hintText,
//     this.controller,
//     required this.isBuyer,
//     this.function
//   });
//   final AuthenticateController? controller;
//   final TextEditingController textcontroller;
//   final String hintText;
//   final bool isBuyer;
//   final Function? function;
//   // BlockUser bu= BlockUser();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 42,
//       margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: Colors.white,
//         border: Border.all(color: Colors.black26),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: TextField(
//         controller: textcontroller,
//         decoration: InputDecoration(
//           icon: Icon(Icons.search, ),
//           suffixIcon: Icon(Icons.close),
//           hintText: hintText,
//           hintStyle: TextStyle(color: Colors.black),
//           border: InputBorder.none,
//         ),
//          style: TextStyle(color: Colors.black),
//         onChanged: (value) {
//           // function
//           // bu.searchuser(query: textcontroller.text , isBuyer:isBuyer);
//       // searchuser(query: textEditingController.text , isBuyer:isBuyer);
//         },
//         // onChanged: widget.onChanged,
//       ),
//     );
//   }
// }
