import 'package:bidbazar/Views/admin/block_unblock_user.dart';
import 'package:bidbazar/Views/admin/user_verification.dart';
import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/data/repo/category_repo.dart';
import 'package:bidbazar/widgets/complaintView.dart';
import 'package:bidbazar/widgets/customTextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// import 'admin/blockuser.dart';

class Admin extends StatelessWidget {
   Admin({super.key});
  static const String routeName = '/adminScreen';
    final TextEditingController brand = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Admin"),
        actions: [
          IconButton(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              onPressed: () {
                Get.offAllNamed('loginScreen');
                // AuthenticateController().dispose();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 170,
                height: 150,
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.people, size: 54),
                      const SizedBox(height: 10),
                      const Text(
                        'Verification',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Your action here
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        userverification(isBuyer: true),
                                  ));
                            },
                            style: TextButton.styleFrom(
                                shape: const ContinuousRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    side: BorderSide(
                                        color: Color.fromARGB(
                                            255, 158, 158, 158)))),
                            child: const Text(
                              'Buyer',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        userverification(isBuyer: false),
                                  ));
                              // Your action here
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
                            child: const Text(
                              'Seller',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                width: 170,
                height: 150,
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.people, size: 54),
                      const SizedBox(height: 10),
                      const Text(
                        'Block',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Your action here
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        BlockUnblockUser(isBuyer: true),
                                  ));
                            },
                            style: TextButton.styleFrom(
                                shape: const ContinuousRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    side: BorderSide(
                                        color: Color.fromARGB(
                                            255, 158, 158, 158)))),
                            child: const Text(
                              'Buyer',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        BlockUnblockUser(isBuyer: false),
                                  ));
                              // Your action here
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
                            child: const Text(
                              'Seller',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 20,),
              SizedBox(
                width: 170,
                height: 150,
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.pageview_outlined , size: 54),
                      const SizedBox(height: 10),
                      const Text(
                        'Complaints',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    ComplaintScreen(),
                              ));
                          // Your action here
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
                        child: const Text(
                          'check complaints',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(width: 5,),
                     
                     
                   
                    ],
                  ),
                ),
              ),
 SizedBox(
  width: 150,
  height: 100,
   child: Card(
     child: Column(children: [
                            Expanded(child: customTextFormField(
                              controller: brand,
                            )),
 
                            TextButton(
                            onPressed: () {
                            categoryRepo repo=categoryRepo();
                            repo.createCategory(title: brand.text,description: "");
                              // Your action here
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
                            child: const Text(
                              'add category',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                          ],),
   ),
 )
            
            ],
          )
          
        ],
      ),
    );
  }
}
