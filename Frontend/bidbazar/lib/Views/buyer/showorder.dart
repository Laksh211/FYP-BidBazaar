// import 'package:flutter/material.dart';







// class ShowOrders extends StatelessWidget {
//   const ShowOrders({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Colors.white,foregroundColor: Colors.black,),
//       body:  ListView.builder(
//       itemCount: controller.bidItemsList.length,
//       itemBuilder:(context, index) {
//         return InkWell(
//                   onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BidView(approvedBid: false,items: controller.bidItemsList[index].items!,buyerId: controller.bidItemsList[index].buyer!, ), ),),
//           child: Card(
            
//             margin: const EdgeInsets.all(5),
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Row(
                
//                 children: [
//                     Expanded(flex: 3,child: Text(style:const TextStyle(fontSize: 16)  , maxLines: 1, "Seller: "+controller.bidItemsList[index].seller!.fullname!.toLowerCase())),
//                     Expanded(flex: 1,child: Text("Bids: "+controller.bidItemsList[index].items!.length.toString())),
//                     const Expanded(flex: 1,child: Icon(Icons.arrow_forward_ios)
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }, 
    
//     ),
//     );
//   }
// }

