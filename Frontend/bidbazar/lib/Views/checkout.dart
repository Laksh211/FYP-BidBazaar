

import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/controllers/cart_controller.dart';
import 'package:bidbazar/controllers/order_controller.dart';
import 'package:bidbazar/controllers/product_controller.dart';
import 'package:bidbazar/core/api.dart';
import 'package:bidbazar/widgets/customTextFormField.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bidbazar/Views/home.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AddAddressPage extends StatelessWidget {
   AddAddressPage({super.key});

  
      cartController controller = Get.put(cartController());

  @override
  Widget build(BuildContext context) {
    

    


    // Widget finishButton = InkWell(
    //   onTap:()=> Navigator.of(context).push(
    //       MaterialPageRoute(
    //           builder: (_) => Home())),
    //   child: Container(
    //     height: 80,
    //     width: MediaQuery.of(context).size.width / 1.5,
    //     decoration: BoxDecoration(
    //         // gradient: mainButton,
    //         boxShadow: const [
    //           BoxShadow(
    //             color: Color.fromRGBO(0, 0, 0, 0.16),
    //             offset: Offset(0, 5),
    //             blurRadius: 10.0,
    //           )
    //         ],
    //         borderRadius: BorderRadius.circular(9.0)),
    //     child: const Center(
    //       child: Text("Finish",
    //           style: TextStyle(
    //               color: Color(0xfffefefe),
    //               fontWeight: FontWeight.w600,
    //               fontStyle: FontStyle.normal,
    //               fontSize: 20.0)),
    //     ),
    //   ),
    // );




    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomSheet:  Container(
        padding: EdgeInsets.all(5),
  width: Get.width,
  height: 60,
  
  decoration:  const BoxDecoration(
    boxShadow: [
  BoxShadow(color: Color.fromARGB(255, 189, 189, 189), spreadRadius: 1 , blurRadius: 0 ),
  BoxShadow(color: Colors.black12, spreadRadius: 1 , blurRadius: 0 ),
  BoxShadow(color: Colors.white, spreadRadius: 1 , blurRadius: 0 )
],

    borderRadius: BorderRadius.only(
      
      topLeft: Radius.circular(20.0), // Adjust the radius as needed
      topRight: Radius.circular(20.0), // Adjust the radius as needed
    ),
    
  ),
  child: Stack(
    children: [
       Positioned(
        left: 10,
        bottom: 15,
        child: Row(
          children: [
            const Text("Total: " , style: TextStyle(color: Colors.black54, fontSize: 16.0 ,fontWeight: FontWeight.w500 , ),),

            Text("Rs - ${controller.totalAmount.value}" , style: const TextStyle(color: Color.fromARGB(255, 230, 81, 0), fontSize: 18.0 ,fontWeight: FontWeight.w700 , ),),
          ],
        )),
      Positioned(
        right: 5,
        bottom: 0,
        child: ElevatedButton(
              style: ElevatedButton.styleFrom(    
                backgroundColor: Colors.orange[900]
              ),
              onPressed: () {

                OrderController orderController=OrderController();
                orderController.placeOrder( totalprice:controller.totalAmount.value, totalquantity: controller.totalQty );
                controller.removeAllFromCart();// remove all items from cart 
                Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => const PlaceOrder(),));
                // product_controller()
              },
              child: const Text(
                'Place order',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              // color: Colors.redAccent,
            )
      )
    ],
  )
),
      
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.grey),
        title: const Text(
          'Buy Now',
          style: TextStyle(
              color:Colors.grey,
              fontWeight: FontWeight.w500,
              fontFamily: "Montserrat",
              fontSize: 18.0),
        ),
      ),
      body:    SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 

                SizedBox(
                  width: Get.width*0.98,
                  height: 250,
                  child:  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Deliver to: ${AuthenticateController.userdata.first.fullname!.toUpperCase()}"  ,style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
                         Card(
                          
                          margin: EdgeInsets.symmetric(vertical: 3),
                           child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            
                            dense: true,
                            leading: const Icon(Icons.home_filled),
                            title: const Text("Address"),
                            subtitle:Text(AuthenticateController.userdata.first.address!.toLowerCase()) ,
                            trailing: const Icon(Icons.arrow_forward_ios_outlined),
                                                   ),
                         ),

                          Card(
                          
                          margin: EdgeInsets.symmetric(vertical: 3),

                           child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            
                            dense: true,
                            leading: const Icon(Icons.phone),
                            title: const Text("Contact"),
                            subtitle:Text(AuthenticateController.userdata.first.mobile!) ,
                            // trailing: const Icon(Icons.arrow_forward_ios_outlined),
                                                   ),
                         ),
                         Card(
                          margin: EdgeInsets.symmetric(vertical: 5),
                           child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            
                            dense: true,
                            leading: const Icon(Icons.email),
                            title: const Text("Email"),
                            subtitle:Text(AuthenticateController.userdata.first.email!) ,
                            // trailing: const Icon(Icons.arrow_forward_ios_outlined),
                                                   ),
                         )
                      ],
                    ),
                  ),
                  
                ),
                const Text("  Products"  ,style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
                SizedBox(
                  height: 300,
                  width: Get.width*0.98,
                  child: Card(
                    child: Items(controller: controller),
                  ),
                ) , 

                  Card(
                   margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                   child: SizedBox(
                     width: Get.width*0.4,
                     height: 70,
                     child:const Padding(

                       padding:  EdgeInsets.all(8.0),
                       child:  Wrap(
                        
                     
                        children: [
                            Text("Standard COD \nRs - 220"  ,style: TextStyle(fontSize: 16,color: Colors.black54, fontWeight: FontWeight.w700),)
                        ],
                                         ),
                     ),
                   ),
                 )    
            // AddAddressForm(),
            // Center(child: finishButton)
          ],
        ),
      ),
    );
  }
}




class Items extends StatelessWidget {
  const Items({super.key,required this.controller});
  final cartController controller;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
                itemCount: controller.cartlist.length,
                itemBuilder: (context, index) {
                  // print(
                  //   "${index} " + controller.amount.toString(),
                  // );
                  return Card(
                    child: ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(vertical: 0),
                      contentPadding: const EdgeInsets.all(2),
                      // dense: true,
                      // autofocus: true,
                      title: Text(
                        // maxLines: 3,
                        "${controller.cartlist[index].product!.name} \nRs - ${controller.cartlist[index].product!.price}",
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            maxLines: 1,
                            controller.cartlist[index].product!.specs.toString(),
                            style: const TextStyle(),
                          ),
                          Text(
                        maxLines: 1,
                        "Quantity ${controller.cartlist[index].product!.qty!}",
                        style: const TextStyle(),
                      ),
                        ],
                      ),
                      
                      leading: SizedBox(
                        width: Get.width * 0.24,
                        child: ClipRRect(
                          
                              // top: Radius.circular(10),
                          child:     // bottom: Radius.circular(15)),
                           CachedNetworkImage(
                             // fit: BoxFit.scaleDown,
                             fit: BoxFit.contain,
                          
                             // width: Get.width * .25,
                             imageUrl: "${Api.BASE_URL}/images/${controller
                                     .cartlist[index].product!.images!.first}",
                           ),
                          // "https://i.postimg.cc/nzdgXrFC/anh-nhat-Pd-ALQmf-Eqv-E-unsplash.jpg"
                        
                      ),
                      
                    ),
                  ));
                },
              );
  }
}



class PlaceOrder extends StatelessWidget {
  const PlaceOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          
          decoration: const BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle
          ),
          child: const Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Order Successfully Placed"  ,style: TextStyle(fontSize: 18,color: Colors.black54, fontWeight: FontWeight.w700) ),
           
            ],
          )),
        ),
      ),
    );
  }
}







class AddAddressForm extends StatelessWidget {

   AddAddressForm({super.key});

  final TextEditingController flatController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController nameOnParcelController = TextEditingController();
  final TextEditingController areaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
  
    
  List<DropdownMenuItem> Area = List<DropdownMenuItem>.of([]);
  RxString dropdownValue ="Clifton block 1".obs;
  
  Area.add(const DropdownMenuItem(value: "Clifton block 1", child: Text("Clifton block 1")));
  Area.add(const DropdownMenuItem(value: "Clifton block 2", child: Text("Clifton block 2")));
  Area.add(const DropdownMenuItem(value: "Clifton block 3", child: Text("Clifton block 3")));
  Area.add(const DropdownMenuItem(value: "Clifton block 4", child: Text("Clifton block 4")));
  Area.add(const DropdownMenuItem(value: "Clifton block 5", child: Text("Clifton block 5")));
  Area.add(const DropdownMenuItem(value: "Clifton block 6", child: Text("Clifton block 6")));
  Area.add(const DropdownMenuItem(value: "Clifton block 7", child: Text("Clifton block 7")));
  Area.add(const DropdownMenuItem(value: "Clifton block 8", child: Text("Clifton block 8")));
  Area.add(const DropdownMenuItem(value: "Clifton block 9", child: Text("Clifton block 9")));
    
    
    
    return  Form(
    
      child: Padding(

        padding: const EdgeInsets.symmetric(horizontal:10 ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: <Widget>[
            customTextFormField(
                      controller: flatController,
                      labelText: 'Flat Number/House Number',
                      hintText: 'Flat Number/House Number',
                      prefixIconData: Icons.home,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofocus: false,
                     
                    ),
            const SizedBox(
              height: 10,
            ),
             customTextFormField(
                      controller: streetController,
                      labelText: 'Street',
                      hintText: 'Street',
                      prefixIconData: Icons.home,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofocus: false,
                     
                    ),
            
            
            const SizedBox(
              height: 10,
            ),

             customTextFormField(
            
                      controller: nameOnParcelController,
                      labelText: 'Name on Parcel',
                      hintText: 'Name on Parcel',
                      prefixIconData: Icons.home,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofocus: false,
                     
                    ),
              const SizedBox(
              height: 10,
            ),
                        Card(
                          shape:const BeveledRectangleBorder(
                            side: BorderSide(
                              color: Colors.black,
                              width: 1
                            )
                          ) ,
                          margin: const EdgeInsets.all(10),
                          child: Padding(
                            
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                const Text(
                                  'Area :',
                                  style: TextStyle(fontSize: 15,),
                                ),
                                const SizedBox(width: 5,),
                                 Obx(
                                 () => DropdownButton(
                                  
                                                    enableFeedback: true,
                                                    value: dropdownValue.value,
                                                    items: Area,
                                                    onChanged: (value) {
                                                      dropdownValue.value=value;
                                                    },
                                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),

            
            // ClipRRect(
            //   borderRadius: const BorderRadius.only(
            //       topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            //   child: Container(
            //     padding: const EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
            //     decoration: const BoxDecoration(
            //       border: Border(bottom: BorderSide(color: Colors.red, width: 1)),
            //       color: Colors.white,
            //     ),
            //     child: customTextFormField(
            //           labelText: "Postal code",
            //           prefixIconData: Icons.code,
            //           hintText: 'Postal code'),
                
            //     ),
            //   ),
            
            // Row(
            //   children: <Widget>[
            //     Checkbox(
            //       value: true,
            //       onChanged: (_) {},
            //     ),
            //     const Text('Add this to address bookmark')
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}









// ignore_for_file: prefer_const_literals_to_create_immutables



class CustomerInfoScreen extends StatefulWidget {
  const CustomerInfoScreen({super.key});

  @override
  State<CustomerInfoScreen> createState() => _CustomerInfoScreenState();
}

class _CustomerInfoScreenState extends State<CustomerInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final fullnameController = TextEditingController();
  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // if (AuthProvider().isSignInCustomer) {
    //   // AuthProvider().getStorageCustomer().then((data) {
    //   //   if (data.isEmpty) {
    //   //     return;
    //   //   }
    //   //   Customer customer = data['customer'];
    //   //   fullnameController.text = '${customer.first_name} ${customer.last_name}';
    //   //   address1Controller.text = customer.address;
    //   //   address2Controller.text = customer.address2;
    //   //   phoneController.text = customer.phone;
    //   //   emailController.text = customer.email;
    //   // });
    // }
  }

  // @override
  // void dispose() {
  //   fullnameController.dispose();
  //   address1Controller.dispose();
  //   address2Controller.dispose();
  //   phoneController.dispose();
  //   emailController.dispose();
  //   super.dispose();
  // }

  // void _checkout(context) {
  //   var customer = Customer();
  //   var names = fullnameController.text.trim().split(' ');
  //   customer.first_name = names[0];
  //   customer.last_name = names.isNotEmpty ? names[names.length - 1] : '';
  //   customer.address = address1Controller.text;
  //   customer.address2 = address2Controller.text;
  //   customer.phone = phoneController.text;
  //   customer.email = emailController.text;
  //   CheckoutProvider().setCustomer(customer);
  //   // print('handle: $handle');
  //   // print(customer.toJson());

  //   if (AuthProvider().isSignInCustomer) {
  //     AuthProvider().getStorageCustomer().then((data) {
  //       if (data.isNotEmpty) {
  //         CheckoutProvider().setCustomerHandle(data['handle']).then((value) {
  //           _navigateCheckout();
  //         });
  //       }
  //     });
  //     return;
  //   }

  //   CheckoutProvider().setCustomerHandle('').then((value) {
  //     _navigateCheckout();
  //   });
  // }

  void _navigateCheckout() {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => AddAddressForm(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer'),
      ),
      body: customerForm(context),
    );
  }

  Widget customerForm(context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Full name",
                    ),
                  ),
                  TextFormField(
                    controller: fullnameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      hintText: 'Full name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter full name';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Address line 1",
                    ),
                  ),
                  TextFormField(
                    controller: address1Controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      hintText: 'Address line 1',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter address';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Address line 2",
                    ),
                  ),
                  TextFormField(
                    controller: address2Controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      hintText: 'Floor, door etc.',
                    ),
                    validator: (value) {
                      // if (value == null || value.isEmpty) {
                      //   return 'Please enter address';
                      // }
                      return null;
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Phone number",
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: phoneController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      hintText: 'Phone number',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phone number';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "E-mail",
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      hintText: 'E-mail',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter e-mail';
                      } else {
                        bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                        if (!emailValid) {
                          return 'Please enter valid e-mail';
                        }
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                  width: 400,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF1cb080),
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // _checkout(context);
                      }
                    },
                    child: const Text(
                      'Next',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}