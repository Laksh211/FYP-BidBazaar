import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/controllers/image_controller.dart';
import 'package:bidbazar/core/api.dart';
import 'package:bidbazar/data/repo/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  ImageController imgcontroller = ImageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text(AuthenticateController.userdata.first.fullname.toString()),
          actions: [
            AuthenticateController.userdata.first.verification == false
                ? const Row(
                    children: [
                      Icon(Icons.cancel),
                      Text(
                        "verified",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                : const Icon(Icons.verified_sharp),
            const SizedBox(
              width: 20,
            )
          ],
          backgroundColor: Colors.white,
          foregroundColor: Colors.black),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 100,
          ),
          ImagesWidget(
            imgcontroller: imgcontroller,
            isCnic: false,
          ),
          ImagesWidget(
            imgcontroller: imgcontroller,
            isCnic: true,
          ),
          // Container(
          //   height: 160,
          //   child: Stack(
          //     children: [
          //       Center(
          //         child: Card(
          //           semanticContainer: true,
          //           child: SizedBox(
          //             width: 170,
          //             height: 120,
          //             child: Column(
          //               // fit: StackFit.loose,
          //               // mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 // const Text("Profile Images", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey )),
          //                 const SizedBox(height: 20),
          //                 Center(
          //                   child: TextButton.icon(
          //                     onPressed: () {},
          //                     icon: const Icon(
          //                       Icons.upload_file,
          //                       color: Colors.black38,
          //                     ),
          //                     label: Obx(
          //                       () => Text(
          //                         "Images ${imgcontroller.imageList.length}",
          //                         style: const TextStyle(
          //                           fontSize: 20,
          //                           wordSpacing: 2,
          //                           color: Colors.black38,
          //                           leadingDistribution:
          //                               TextLeadingDistribution.proportional,
          //                           fontWeight: FontWeight.w700,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   width: 160,
          //                   child: TextButton(
          //                     onPressed: () {
          //                       imgcontroller.pickImages(); //pick images
          //                       //push user images
          //                       UserRepository().uploadCnicPicture(
          //                           images: imgcontroller.uploadImageList);
          //                       //create user api to insert images in cnic and  profile
          //                       imgcontroller.imageList.clear();
          //                       imgcontroller.uploadImageList.clear();
          //                     },
          //                     style: TextButton.styleFrom(
          //                       shape: const ContinuousRectangleBorder(
          //                         borderRadius: BorderRadius.all(
          //                           Radius.circular(5),
          //                         ),
          //                         side: BorderSide(
          //                           color: Color.fromARGB(255, 158, 158, 158),
          //                         ),
          //                       ),
          //                     ),
          //                     child: const Text(
          //                       'Upload Cnic',
          //                       style: TextStyle(
          //                           color: Colors.black54,
          //                           fontSize: 16.0,
          //                           fontWeight: FontWeight.w700),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //       const Align(
          //         alignment: Alignment.topCenter,
          //         child: CircleAvatar(
          //             radius: 24,
          //             backgroundColor: Colors.grey,
          //             child: Icon(
          //               Icons.recent_actors,
          //               size: 34,
          //               color: Colors.black,
          //             )),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

class ImagesWidget extends StatelessWidget {
  ImagesWidget({
    super.key,
    required this.imgcontroller,
    required this.isCnic,
    // required this.imageType
  });

  final ImageController imgcontroller;
  final bool isCnic;
  // final String imageType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isCnic == true ? 250 : 200,
      child: Stack(
        children: [
          Positioned.fromRect(
            rect: Rect.fromCenter(
                center: const Offset(190, 80), width: 190, height: 130),
            child: Card(
              semanticContainer: true,
              child: SizedBox(
                width: 190,
                height: 120,
                child: Column(
                  // fit: StackFit.loose,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const Text("Profile Images", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey )),
                    const SizedBox(height: 20),
                    Center(
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.upload_file,
                          color: Colors.black38,
                        ),
                        label: Obx(
                          () => Text(
                            isCnic == true
                                ? "Select Images ${imgcontroller.uploadCnicList.length}"
                                : "Select Images ${imgcontroller.uploadProfileList.length}",
                            style: const TextStyle(
                              fontSize: 18,
                              // wordSpacing: 2,
                              color: Colors.black38,
                              leadingDistribution:
                                  TextLeadingDistribution.proportional,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160,
                      child: TextButton(
                        onPressed: () async {
                          //pick images

                          isCnic == true
                              ? {
                                  await imgcontroller
                                      .pickImages(), //pick a image
                                  await imgcontroller
                                      .uploadCnic(), //upload image
                                  await UserRepository().uploadCnicPicture(
                                      //upload picture string to user
                                      images: imgcontroller.uploadCnicList),
                                  AuthenticateController.userdata.first
                                      .cnicimages = imgcontroller.uploadCnicList
                                }
                              : {
                                  await imgcontroller.pickImages(),
                                  await imgcontroller.uploadProfile(),
                                  await UserRepository().uploadProfilePicture(
                                      images: imgcontroller.uploadProfileList),
                                  AuthenticateController
                                          .userdata.first.profileimages =
                                      imgcontroller.uploadProfileList
                                };
                          //create user api to insert images in cnic and  profile
                          print(imgcontroller.uploadCnicList);
                          imgcontroller.imageList.clear();
                          // imgcontroller.uploadImageList.clear();
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
                          isCnic == true ? 'Upload Cnic' : 'Upload Profile',
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fromRect(
            rect: Rect.fromCenter(
                center: Offset(190, isCnic == true ? 200 : 25),
                width: isCnic == true ? 180 : 50,
                height: isCnic == true ? 180 : 50),
            // alignment: Alignment.topCenter,
            child: isCnic == false
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      "${Api.BASE_URL}/images/${AuthenticateController.userdata.first.profileimages![0]}",
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return const CircleAvatar(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.black87,
                          radius: 30,
                          child: Icon(Icons.person, // Or any other icon
                              size: 30.0,
                              color: Colors.white),
                        );
                      },
                    ),
                  )
                : Image.network(
                    fit: BoxFit.contain,
                    "${Api.BASE_URL}/images/${AuthenticateController.userdata.first.cnicimages![0]}",
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const Icon(
                        Icons.recent_actors, // Or any other icon
                        size: 50.0,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
