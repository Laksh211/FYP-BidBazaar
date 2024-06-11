// import 'dart:html';

import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/widgets/customTextFormField.dart';
import 'package:bidbazar/widgets/custombtn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

// ignore: must_be_immutable
class loginScreen extends StatelessWidget {
  loginScreen({super.key});
  static const String routeName = '/loginScreen';
  AuthenticateController controller = Get.put(AuthenticateController());


  @override
  Widget build(BuildContext context) {
// dynamic theme=Theme.of(context);
    // Get.create(() {
    //   controller;
    // }, permanent: true, tag: "auth");
    // // userType? _usertype;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: Form(
                key: controller.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/login.png',
                        width: 200.0,
                        height: 200.0,
                      ),
                    ),
                    Text(
                      'BidBazar',
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.orange[800]
                          ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Welcome Back',
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Login to your account',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    customTextFormField(
                      controller: controller.emailController,
                      labelText: 'Email',
                      hintText: 'Email Address',
                      prefixIconData: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofocus: false,
                      validator: (value) {
                        return controller.validateEmail(value!);
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    // customRadioBtn(),
                    // // SafeArea(child: RadioButton()),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Obx(
                      () => customTextFormField(
                        controller: controller.passwordController,
                        autofocus: false,
                        labelText: 'Password',
                        hintText: "***",
                        obscureText: controller.isObscure
                            .value, //use obs to listen the changes made in isObscure
                        prefixIconData: Icons.vpn_key_rounded,
                        suffixIconData: controller.isObscure.value
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        onSuffixTap: controller.toggleVisibility, //change icon
                        textInputAction: TextInputAction.done,

                        validator: (value) {
                          return controller.validatePassword(value!);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!(controller.emailController.text.isEmpty)) {
                            controller.forgot();
                          // controller.resetPassword(controller.emailController.text);
                        } else {
                          controller.ErrorMessage.value =
                              "Please enter email to forgot password";
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.bottomRight,
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Obx(
                      () => Text(
                        controller.ErrorMessage.value,
                        style: TextStyle(color: Colors.red[900], fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Obx(
                      () => CustomButton(
                          loadingWidget: controller.isLoading.value
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color.fromARGB(255, 255, 255, 255)))
                              : null,
                          color: Colors.orange.shade700,
                          textColor: Colors.white,
                          text: 'Login',
                          onPressed: () async {
                            if (controller.loginFormKey.currentState!
                                .validate()) {
                              controller.login(controller.emailController.text,
                                  controller.passwordController.text);
                            }
                          },
                          hasInfiniteWidth: true),
                    ),
                    Row(
                      //Don't have an account?Register row
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                        ),
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(fontSize: 15.0),
                        ),
                        InkWell(
                          onTap: () {
                            controller.clearfields();
                            controller.ErrorMessage.value = "";
                            Get.offNamed('signupScreen');
                          },
                          child: const Text(
                            ' Register',
                            style: TextStyle(
                                color: Color.fromARGB(218, 255, 153, 0),
                                fontSize: 15.0),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}








// class CustomRadiobutton extends StatefulWidget {
//   dynamic? value;
//   dynamic? groupValue;
//   Function(userType?)? onChanged;
//   CustomRadiobutton(
//       {super.key, this.value, this.groupValue, required this.onChanged});

//   @override
//   State<CustomRadiobutton> createState() => _CustomRadiobuttonState();
// }

// class _CustomRadiobuttonState extends State<CustomRadiobutton> {
//   @override
//   Widget build(BuildContext context) {
//     return Radio<userType>(
//       value: widget.value,
//       groupValue: widget.groupValue,
//       onChanged: (value) {},
//     );
//   }
// }
