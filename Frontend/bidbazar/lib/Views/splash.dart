import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = '/splashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //if user login in future and data is safed in sqlite then splash screen callback usertype function
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersive); //hide navigator and topbar

    Future.delayed(const Duration(seconds: 2), () {
      // dispose();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
      Get.offAllNamed('loginScreen'); //can't goback to screen
      // AppRoutes.login;

      // Navigator.pushNamed(context, 'login');
    });

    // _delaySplash();
  }

  // @override
  // void dispose() {
  //   super.dispose();

  //   // remove system immersive
  // }

  // _delaySplash() async {
  //   await Future.delayed(Duration(seconds: 2), () {});
  //   dispose();
  //   Navigator.pushNamed(context, 'login');
  //   // Navigator.push(
  //   //   context,
  //   //   MaterialPageRoute(
  //   //     builder: (context) => loginScreen(),
  //   //   ),
  //   // );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logobb.png',
                width: 350,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
