import 'package:bidbazar/controllers/complaintController.dart';
import 'package:bidbazar/data/models/complaint_model.dart';
import 'package:flutter/material.dart';

import 'package:bidbazar/core/api.dart';
import 'package:bidbazar/data/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ComplaintScreen extends GetView<ComplaintController> {
  ComplaintScreen({super.key,});

  String query = '';
  TextEditingController textEditingController = TextEditingController();
 
  ComplaintController controller=Get.put(ComplaintController());

  @override
  Widget build(BuildContext context) {
    //   print("widget is woriwc");
    //  controller. users.clear();
                 controller.templistOfComplaints.assignAll(controller.listOfComplaints);

   
    return Scaffold(
      appBar: AppBar(
        title: Text("Complaints"),
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
                            itemCount: controller.templistOfComplaints.length,
                            // itemCount: isBuyer == true
                            //     ? controller.listOfBuyer.length
                            //     : controller.listOfSeller.length,
                            itemBuilder: (context, index) {
                              // final allUsers = isBuyer == true
                              //     ? controller.listOfBuyer[index]
                              //     : controller.listOfSeller[index];
                              final complaints = controller.templistOfComplaints[index];
                              return buildComplaints(
                                complaints,context
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          onEmpty: const Center(child: Text("There is no Complaints to display")),
          onLoading: const Center(child: CircularProgressIndicator())),
    );
  }

  Widget buildComplaints(
    ComplainModel complaint,
    BuildContext context
  ) =>
      ListTile(
        title: Text(complaint.buyer!.fullname!),
        leading: SizedBox(
          width: 40,
          height: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
              fit: BoxFit.contain,
              errorWidget: (context, url, error) {
                return const Icon(
                  Icons.person, // Or any other icon
                  size: 24,
                );
              },
              imageUrl: "${Api.BASE_URL}/images/${complaint.buyer!.profileimages![0]}",
            ),
          ),
        ),
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
               
                      Expanded(
                       
                        child: ListTile(leading: Text("Explanation"),
                        title: Text("Reason "+ complaint.reason!),
                        subtitle: Text(complaint.explanation!),
                        )
                      ),

                    ],
                  ),
                );
              },
            );
        },
      
        // trailing: TextButton(
        //   onPressed: () {
           
        //   },
        //   style: TextButton.styleFrom(
        //     shape: const ContinuousRectangleBorder(
        //       borderRadius: BorderRadius.all(
        //         Radius.circular(5),
        //       ),
        //       side: BorderSide(
        //         color: Color.fromARGB(255, 158, 158, 158),
        //       ),
        //     ),
        //   ),
        //   child:const Text(
        //           'check',
        //           style: TextStyle(
        //               color: Colors.black54,
        //               fontSize: 16.0,
        //               fontWeight: FontWeight.w700),
        //         ),
        // ),
      );

  searchuser({String? query}) {
    // controller.users.clear();
    List<ComplainModel> filtered;
   
        
          filtered = controller.listOfComplaints.where((complaints) {
              final reason = complaints.reason!.toLowerCase();
              final fullname = complaints.buyer!.fullname!.toLowerCase();
              final cnic = complaints.buyer!.cnic!.toLowerCase();
              final searchLower = query!.toLowerCase();

              return fullname.contains(searchLower) ||
                  reason.contains(searchLower) ||
                  cnic.contains(searchLower);
            }).toList();

    controller.templistOfComplaints.value = filtered;

 
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
          icon: const Icon(
            Icons.search,
          ),
          suffixIcon: const Icon(Icons.close),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black),
          border: InputBorder.none,
        ),
        style: const TextStyle(color: Colors.black),
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
