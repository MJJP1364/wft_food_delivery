import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wft_food_delivery_code/pages/signin_signup_page/controller.dart';
import 'package:wft_food_delivery_code/pages/widgets/text_field_widget.dart';
import '../widgets/my_botton.dart';
import 'signup.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final AuthController1 controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/3094352.jpg'),
            Column(
              children: [
                const Text('Login', style: TextStyle(fontSize: 30)),
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
                          controller.signInLoading.value == true
                              ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              )
                              : MyBotton(
                                bottonText: 'Login',
                                onTap: () async {
                                  controller.logIn(
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
                    const Text('Don\'t have an account? '),
                    GestureDetector(
                      onTap:
                          () => Get.off(
                            () => Signup(),
                            transition: Transition.leftToRight,
                            duration: const Duration(milliseconds: 500),
                          ),
                      child: const Text(
                        'Sign Up',
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
