import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wft_food_delivery_code/pages/signin_signup_page/signin.dart';
import '../widgets/my_botton.dart';
import '../widgets/text_field_widget.dart';
import 'controller.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  final AuthController1 controller = Get.put(AuthController1());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/4707071.jpg'),
            Column(
              children: [
                const Text('Sign Up', style: TextStyle(fontSize: 30)),
                const SizedBox(height: 20),
                InputText(
                  hint: 'Email',
                  controller: controller.emailController,
                  lable: 'Email',
                  obsecured: false,
                  icon: Icons.email,
                ),
                const SizedBox(height: 20),
                Obx(() {
                  return InputText(
                    hint: 'Enter Password',
                    controller: controller.passwordController,
                    lable: 'password',
                    icon: Icons.password_rounded,
                    obsecured: controller.passwordSufixIcon.value,
                    onTap: controller.passwordSufixIconMethod,
                    sufixe:
                        controller.passwordSufixIcon.value == false
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined,
                  );
                }),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: Obx(
                      () =>
                          controller.signUpLoading.value == true
                              ? const Center(child: CircularProgressIndicator())
                              : MyBotton(
                                bottonText: 'Sign Up',
                                onTap: () async {
                                  controller.signup(
                                    controller.emailController.text.trim(),
                                    controller.passwordController.text.trim(),
                                  );
                                },
                              ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    GestureDetector(
                      onTap:
                          () => Get.off(
                            () => SignIn(),
                            transition: Transition.rightToLeft,
                            duration: const Duration(milliseconds: 500),
                          ),
                      child: const Text(
                        'Login here',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
