import 'package:bidbazar/controllers/bidController.dart';
import 'package:bidbazar/widgets/bidView.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BidViewForBuyer extends StatelessWidget {
  BidViewForBuyer({super.key, required this.controller});
  BidController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bid Logs"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: controller.bidItemsList.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BidView(
                        approvedBid: false,
                        items: controller.bidItemsList[index].items!,
                        buyerId: controller.bidItemsList[index].buyer!,
                      ),
                    ),
                  ),
              child: Card(
                //           margin: EdgeInsets.all(5),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            const CircleAvatar(
                                // minRadius: 10,
                                backgroundColor: Colors.black,
                                radius: 15,
                                child: Icon(Icons.person,color:Colors.white  )),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(controller
                                        .bidItemsList[index].seller!.fullname!
                                        .substring(
                                            0, 1) // Get the first character
                                        .toUpperCase() // Convert it to uppercase
                                    +
                                    controller
                                        .bidItemsList[index].seller!.fullname!
                                        .substring(
                                            1) // Get the rest of the string
                                        .toLowerCase() // Convert it to lowercase
                                ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Text("Bids: ${controller.bidItemsList[index].items!.length}")),
                      const Expanded(
                          flex: 1, child: Icon(Icons.arrow_forward_ios , size: 15, )),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}

 //  Row(
                
                // children: [
                    // Expanded(flex: 3,child: Text(style:TextStyle(fontSize: 16)  , maxLines: 1, "Seller: "+controller.bidItemsList[index].seller!.fullname!.toLowerCase())),
                    // Expanded(flex: 1,child: Text("Bids: "+controller.bidItemsList[index].items!.length.toString())),
                    // Expanded(flex: 1,child: Icon(Icons.arrow_forward_ios)
                    // ),
                // ],
              // ),


  //              Card(
            
  //           margin: EdgeInsets.all(5),
  //           child: ListTile(dense: true, 
  //           trailing:const Icon(Icons.arrow_forward_ios) ,
  //           title: Text("   Bids: ${controller.bidItemsList[index].items!.length}"),
  //           leading: Row(

  //             children: [
  //               const CircleAvatar(
  //                 // minRadius: 10,
  //                 radius: 15,
  //                 child: Icon(Icons.person)),
  //               Text(
  //   controller.bidItemsList[index].seller!.fullname!
  //     .substring(0, 1) // Get the first character
  //     .toUpperCase() // Convert it to uppercase
  //   +
  //   controller.bidItemsList[index].seller!.fullname!
  //     .substring(1) // Get the rest of the string
  //     .toLowerCase() // Convert it to lowercase
  // ),
  //             ],
  //           ),

        
  //         ),
  //       )