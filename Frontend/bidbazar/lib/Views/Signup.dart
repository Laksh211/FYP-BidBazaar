import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/widgets/customRadioButton.dart';
import 'package:bidbazar/widgets/customTextFormField.dart';
import 'package:bidbazar/widgets/custombtn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class signUp extends StatelessWidget {
  signUp({super.key});
  // Rx<bool> isObscure = true.obs;
  static const String routeName = '/signupScreen';

  // void toggleVisibility() {
  //   isObscure == true ? isObscure.value = false : isObscure.value = true;
  // }

  @override
  Widget build(BuildContext context) {
    AuthenticateController controller = Get.put(AuthenticateController());
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: Form(
                key: controller.signupFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/login.png',
                          width: 200.0,
                          height: 200.0,
                        ),
                        // Text(
                        //   'BidBazar',
                        //   style: TextStyle(
                        //       fontSize: 25.0,
                        //       fontWeight: FontWeight.w700,
                        //       color: Colors.orange[800]),
                        // ),
                        // const SizedBox(
                        //   height: 25.0,
                        // ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Create Your account',
                            style: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        customTextFormField(
                          controller: controller.nameController,
                          labelText: 'Full Name',
                          hintText: '',
                          autofocus: false,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          prefixIconData: Icons.person,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        customTextFormField(
                          controller: controller.emailController,
                          labelText: 'Email',
                          hintText: 'Email Address',
                          prefixIconData: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autofocus: false,
                          validator: (value) =>
                              controller.validateEmail(value!.trim()),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        customTextFormField(
                          controller: controller.phoneController,
                          labelText: 'Phone number',
                          autofocus: false,
                          hintText: '03-XXX-XXXX-XX',
                          textInputAction: TextInputAction.next,
                          prefixIconData: Icons.phone,
                          validator: (value) {
                            return controller.validatePhone(value!.trim());
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        customTextFormField(
                          controller: controller.cnicController,
                          labelText: 'Cnic number',
                          autofocus: false,
                          hintText: 'XXXXX-XXXXXXX-X',
                          textInputAction: TextInputAction.next,
                          prefixIconData: Icons.badge,
                          validator: (value) {
                           return controller.validateCNIC(value!.trim());
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        customTextFormField(
                          controller: controller.addressController,
                          labelText: 'Address',
                          hintText: 'Currrent location',
                          prefixIconData: Icons.home,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autofocus: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Obx(
                          () => customTextFormField(
                            controller: controller.passwordController,
                            autofocus: false,
                            labelText: 'Password',
                            hintText: "Ex: laksh12#",
                            obscureText: controller.isObscure
                                .value, //use obs to listen the changes made in isObscure
                            prefixIconData: Icons.vpn_key_rounded,
                            suffixIconData: controller.isObscure.value
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            onSuffixTap:
                                controller.toggleVisibility, //change icon
                            textInputAction: TextInputAction.done,

                            validator: (value) {
                              return controller.validatePassword(value!);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0, 10.0, 0),
                          child: customRadioBtn(
                            isVisible: false,
                          ),
                        ),
                        // Text('null'),
                        // SafeArea(child: RadioButton()),
                        SizedBox(
                          height: 5.0,
                        ),
                        Obx(
                          () => Text(
                            controller.ErrorMessage.value,
                            style:
                                TextStyle(color: Colors.red[900], fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Obx(
                          () => CustomButton(
                              loadingWidget: controller.isLoading.value
                                  ? CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          const Color.fromARGB(
                                              255, 255, 255, 255)))
                                  : null,
                              color: Colors.orange.shade700,
                              textColor: Colors.white,
                              text: 'Sign up',
                              onPressed: () async {
                                // bool isValid = controller.validateEmail(
                                //         controller.emailController.text
                                //             .toString()) &&
                                //     controller.validatePhone(controller
                                //         .phoneController.text
                                //         .toString()) &&
                                //     controller.validatePassword(controller
                                //         .passwordController.text
                                //         .toString());

                                if (controller.signupFormKey.currentState!
                                    .validate()) {
                                  controller.signup(
                                    name: controller.nameController.text,
                                    email: controller.emailController.text,
                                    password:
                                        controller.passwordController.text,
                                    phonenum: controller.phoneController.text,
                                    address: controller.addressController.text,
                                    cnic: controller.cnicController.text,
                                  );
                                  // print('data is valid');
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   const SnackBar(
                                  //       content: Text('Processing Data')),
                                  // );
                                  print("signup done");
                                }
                              },
                              hasInfiniteWidth: true),
                        ),
                        Row(
                          //Don't have an account?Register row
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                            ),
                            Text(
                              "Already have an account?",
                              style: TextStyle(fontSize: 15.0),
                            ),
                            InkWell(
                              onTap: () {
                                controller.clearfields();
                                // emailController.clear();
                                // passwordController.clear();
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => loginScreen(),
                                //     ));
                                controller.ErrorMessage.value = "";
                                Get.offNamed('loginScreen');
                              },
                              child: const Text(
                                ' Login',
                                style: TextStyle(
                                    color: Color.fromARGB(218, 255, 153, 0),
                                    fontSize: 15.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
