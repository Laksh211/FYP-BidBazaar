import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/controllers/bidController.dart';
import 'package:bidbazar/controllers/cart_controller.dart';
import 'package:bidbazar/core/api.dart';
import 'package:bidbazar/data/models/bid_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class BidView extends GetView<BidController> {
   BidView({super.key,required this.items ,required this.buyerId, required this.approvedBid});

  
  final bool approvedBid;
  List<Items> items=[];
  String buyerId;
  // BidController controller=Get.put(BidController());
  String status='';
  RxList<Items>   bidList=<Items>[].obs;


  void approvedBids(){

    items!.forEach((element) {
      if(element.status=="bid approved and closed"){
      bidList.add(element);
      }
    });
  }


  Widget build(BuildContext context) {
    print(controller.bidItemsList);
    approvedBid? approvedBids():null;
    // print("object");
    // print(controller.bidlist.first.items!.first.product!.name);
    return Scaffold(
      appBar: AppBar(
      
        title:approvedBid?const Text("Approved Bids") :const Text("BID LOG"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body:   
        
        
        RefreshIndicator(
          onRefresh: ()async {
            controller.fetchBidItems();
            bidList.refresh();
            // controller.update();
          },
          child: controller.obx(
            (_) =>  ListView.builder(
              itemCount:approvedBid?bidList.value.length:items.length ,
              itemBuilder: (context, index) {
                
                var item=approvedBid?bidList.value[index]: items[index];
                status=item.status!;
              return Card(
          
                margin: const EdgeInsets.all(5),
                
             child: Column(
               children: [
              //  Text( "Bid status: $status" , style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600)),
                 ListTile(
                  visualDensity: const VisualDensity(vertical: 4),
                                contentPadding: const EdgeInsets.all(5),
                    
                                title: Text(
                                  
                                  item.product!.name.toString().toLowerCase() 
                                      
                                ),
                                subtitle: Text(
                                  maxLines: 1,
                                  "Rs"+
                                  item.product!.price.toString()
                                  // style: TextStyle(),
                                ),
                                
                                leading: Container(
                                  width: Get.width * 0.24,
                                  // height: Get.height*1,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(0),
                                        bottom: Radius.circular(0)
                                        ),
                                    child: CachedNetworkImage(
                                      // fit: BoxFit.scaleDown,
                                      fit: BoxFit.contain,
                  
                                      // width: Get.width * .25,
                                      imageUrl: "${Api.BASE_URL}/images/"+item.product!.images!.first,
                                          // controller
                                              // .cartlist[index].product!.images!.first
                                              // .toString(),
                                    ),
                                    // "https://i.postimg.cc/nzdgXrFC/anh-nhat-Pd-ALQmf-Eqv-E-unsplash.jpg"
                                  ),
                                ),
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        
                                        "Bid Price: "+item.bidprice.toString()),
                                    ),
                                     
            
                                  ],
                                ),
                              ),
          
                              // SizedBox(height: 5,),
                              // Spacer(),
                             AuthenticateController.userdata.first.usertype=='Seller'?
                               Row(                  children: [
                                const SizedBox(width: 5),
                              
                                approvedBid?SizedBox.shrink() :
                                ElevatedButton.icon(
                                  style:  ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orangeAccent[400]
                                  ),
                                  onPressed: () {
                                    print(buyerId);
                                    controller.updateBidStatus(buyerId:buyerId,productId: item.product!.sId!,status: 'bid approved and closed');
        
                                  // controller.updateBidStatus(buyerId: controller.biditems.value.buyer! ,productId: controller.biditems.value.items![index].product!.sId!,status: 'bid approved and closed');
                                  status='bid approved and closed';
                                  controller.bidItemsList.first.items![index].status=status;
                                  controller.update();
                                      controller.bidItemsList.refresh();
                                      Get.snackbar("Bid", "bid successful Accept");
                                }, icon: const Icon(CupertinoIcons.checkmark_alt_circle), label: const Text("accept"),),
                                const SizedBox(width: 5),
                                approvedBid?SizedBox.shrink() :
                                Expanded(
                  
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orangeAccent[400]
                                    ),
                                    onPressed: () {
                                    controller.updateBidStatus(buyerId:buyerId,productId:item.product!.sId!,status: 'bid rejected');
                                      status='bid rejected';
          
                                      controller.bidItemsList.first.items![index].status=status;
                                      controller.update();
                                      controller.bidItemsList.refresh();
                                      Get.snackbar("Cancel", "bid  Cancel");
                                  }, icon: const Icon(Icons.cancel_outlined), label: const Text("cancel"),),
                                ),
                                const SizedBox(width: 5),
                                approvedBid?
                                 Expanded(
                                   child: ElevatedButton.icon(
                                    style:  ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orangeAccent[400]
                                    ),
                                    onPressed: () {
                                     
                                 
                                         controller.deletebidForSeller(bidId:bidList[index].sId!);
                                        bidList.removeAt(index);
                                        
                                        // BidController().bidItemsList.removeAt(index);
                                        // bidList.refresh();
                                        controller.fetchBidItems();
                                        controller.update();
                                    // controller.updateBidStatus(buyerId: controller.biditems.value.buyer! ,productId: controller.biditems.value.items![index].product!.sId!,status: 'bid approved and closed');
                                    // status='bid approved and closed';
                                                                 }, icon: const Icon(CupertinoIcons.delete), label: const Text("remove"),),
                                 ):const SizedBox.shrink(),
                                const SizedBox(width: 15),

                               ],
                               ):
        
                               Row(                  children: [
                                const SizedBox(width: 5),
                                ElevatedButton.icon(
                                  style:  ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orangeAccent[400]
                                  ),
                                  onPressed: () {
                                       controller.deleteBid(bidId: bidList[index].sId!);
                                      bidList.removeAt(index);
                                      // BidController().bidItemsList.removeAt(index);
                                      // bidList.refresh();
                                      controller.fetchBidItems();
                                      controller.update();
                                  // controller.updateBidStatus(buyerId: controller.biditems.value.buyer! ,productId: controller.biditems.value.items![index].product!.sId!,status: 'bid approved and closed');
                                  // status='bid approved and closed';
                                }, icon: const Icon(CupertinoIcons.delete), label: const Text("remove"),),
                                const SizedBox(width: 5),
          
                              
                                
                                Expanded(
                  
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orangeAccent[400]
                                    ),
                                    onPressed: ()async {
                                        cartController cartcontroller=Get.put(cartController());
                                        
                                      cartcontroller.addToCart(bidList[index].product!, 1);
                                      // cartController().fetchCartItems();
                                      print("cart list data ");
                                      print(bidList.first.sId);
                                      BidController().deleteBid(bidId: bidList[index].sId!);
                                      bidList.removeAt(index);
                                      BidController().fetchBidItems();
                                      // bidList.refresh();
                                      controller.update();
        
                                      //
                                      //delete bid 
                                      // cartController().cartlist.refresh();
                                  }, icon: const Icon(Icons.shopping_cart), label: const Text("add to cart"),),
                                ),
                                const SizedBox(width: 5),
            
                               ],
                               ),
                              
               ],
             ),
                          
            );
                  
            },),
          
               onEmpty:const Center(child:  Text("There is no bid to display")),
               onError: (error) => Text("${error}"),
          ),
        ),
    );
      
      
      
      
    
 
        }
}
