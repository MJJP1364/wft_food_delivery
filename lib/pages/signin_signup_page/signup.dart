// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:wft_food_delivery_code/pages/signin_signup_page/signin.dart';
// import '../widgets/my_botton.dart';
// import '../widgets/text_field_widget.dart';
// import 'controller.dart';

// class Signup extends StatelessWidget {
//   Signup({super.key});

//   // final AuthController1 controller = Get.put(AuthController1());
//   final AuthController1 controller = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Image.asset('assets/4707071.jpg'),
//             Column(
//               children: [
//                 const Text('Sign Up', style: TextStyle(fontSize: 30)),
//                 const SizedBox(height: 20),
//                 InputText(
//                   hint: 'Email',
//                   controller: controller.emailController,
//                   lable: 'Email',
//                   obsecured: false,
//                   icon: Icons.email,
//                 ),
//                 const SizedBox(height: 20),
//                 Obx(() {
//                   return InputText(
//                     hint: 'Enter Password',
//                     controller: controller.passwordController,
//                     lable: 'password',
//                     icon: Icons.password_rounded,
//                     obsecured: controller.passwordSufixIcon.value,
//                     onTap: controller.passwordSufixIconMethod,
//                     sufixe:
//                         controller.passwordSufixIcon.value == false
//                             ? Icons.remove_red_eye
//                             : Icons.remove_red_eye_outlined,
//                   );
//                 }),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: Obx(
//                       () =>
//                           controller.signUpLoading.value == true
//                               ? const Center(child: CircularProgressIndicator())
//                               : MyBotton(
//                                 bottonText: 'Sign Up',
//                                 onTap: () async {
//                                   controller.signup(
//                                     controller.emailController.text.trim(),
//                                     controller.passwordController.text.trim(),
//                                   );
//                                 },
//                               ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text('Already have an account?'),
//                     GestureDetector(
//                       onTap:
//                           () => Get.off(
//                             () => SignIn(),
//                             transition: Transition.rightToLeft,
//                             duration: const Duration(milliseconds: 500),
//                           ),
//                       child: const Text(
//                         'Login here',
//                         style: TextStyle(color: Colors.blue),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wft_food_delivery_code/pages/signin_signup_page/signin.dart';
import 'package:wft_food_delivery_code/pages/signin_signup_page/controller.dart';
import 'package:wft_food_delivery_code/pages/widgets/my_botton.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  final AuthController1 controller = Get.find();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset('assets/4707071.jpg'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text('ثبت نام', style: TextStyle(fontSize: 30)),
                    const SizedBox(height: 20),

                    // Email Field
                    TextFormField(
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'ایمیل',
                        hintText: 'ایمیل خود را وارد کنید',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'لطفاً ایمیل را وارد کنید';
                        }
                        if (!GetUtils.isEmail(value)) {
                          return 'ایمیل معتبر نیست';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Password Field with visibility toggle
                    Obx(() {
                      return TextFormField(
                        controller: controller.passwordController,
                        obscureText: controller.passwordSufixIcon.value,
                        decoration: InputDecoration(
                          labelText: 'رمز عبور',
                          hintText: 'رمز عبور خود را وارد کنید',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.passwordSufixIcon.value
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.remove_red_eye,
                            ),
                            onPressed: controller.passwordSufixIconMethod,
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لطفاً رمز عبور را وارد کنید';
                          }
                          if (value.length < 6) {
                            return 'رمز عبور باید بیشتر از 6 کاراکتر باشد';
                          }
                          return null;
                        },
                      );
                    }),

                    const SizedBox(height: 20),

                    // Sign Up Button
                    Obx(() {
                      return SizedBox(
                        width: double.infinity,
                        child:
                            controller.signUpLoading.value
                                ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                                : MyBotton(
                                  bottonText: 'ثبت نام',
                                  onTap: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      controller.signup(
                                        controller.emailController.text.trim(),
                                        controller.passwordController.text
                                            .trim(),
                                      );
                                    }
                                  },
                                ),
                      );
                    }),

                    const SizedBox(height: 20),

                    // Already have an account?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('حساب دارید؟'),
                        TextButton(
                          onPressed:
                              () => Get.off(
                                () => SignIn(),
                                transition: Transition.rightToLeft,
                                duration: const Duration(milliseconds: 500),
                              ),
                          child: const Text(
                            'وارد شوید',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
