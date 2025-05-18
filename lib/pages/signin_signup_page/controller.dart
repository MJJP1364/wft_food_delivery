import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wft_food_delivery_code/pages/signin_signup_page/signin.dart';

import '../home_page/home_view.dart';

class AuthController1 extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool passwordSufixIcon = true.obs;
  RxBool confrimPasswordSufixIcon = true.obs;

  RxBool signInLoading = false.obs;
  RxBool signUpLoading = false.obs;

  void passwordSufixIconMethod() {
    passwordSufixIcon.value = !passwordSufixIcon.value;
  }

  //-----------signup method---------------------------
  Future<void> signup(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'SignUp',
        'Please enter email and password',
        snackPosition: SnackPosition.BOTTOM,
        // backgroundColor: Colors.red,
        // colorText: Colors.white,
        // margin: const EdgeInsets.all(15),
      );
      signUpLoading.value = false;
      return;
    }
    signUpLoading.value = true;
    try {
      await supabase.auth.signUp(email: email, password: password).then((
        value,
      ) {
        Get.offAll(() => SignIn());
        Get.snackbar(
          'SignUp',
          'Success to SignUp',
          snackPosition: SnackPosition.BOTTOM,
          // backgroundColor: Colors.green,
          // colorText: Colors.black,
          // margin: const EdgeInsets.all(15),
        );
        signUpLoading.value = false;
      });
    } catch (e) {
      Get.snackbar(
        'SignUp',
        'Failed to SignUp',
        snackPosition: SnackPosition.BOTTOM,
        // backgroundColor: Colors.red,
        // colorText: Colors.white,
        // margin: const EdgeInsets.all(15),
      );
      signUpLoading.value = false;
    } finally {
      signUpLoading.value = false;
    }
  }

  //-----------signin method---------------------------
  Future<void> logIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'SignIn',
        'Please enter email and password',
        snackPosition: SnackPosition.BOTTOM,
        // backgroundColor: Colors.red,
        // colorText: Colors.white,
        // margin: const EdgeInsets.all(15),
      );
      signUpLoading.value = false;
      return;
    }

    try {
      signInLoading.value = true;
      await supabase.auth
          .signInWithPassword(email: email, password: password)
          .then((value) {
            Get.offAll(() => const HomePage());

            Get.snackbar(
              'SignIn',
              'Success to SignIn',
              snackPosition: SnackPosition.BOTTOM,
              // backgroundColor: Colors.green,
              // colorText: Colors.black,
              // margin: const EdgeInsets.all(15),
            );
            signUpLoading.value = false;
          });
    } catch (e) {
      Get.snackbar(
        'SignIn',
        'Failed to SignIn',
        snackPosition: SnackPosition.BOTTOM,
        // backgroundColor: Colors.red,
        // colorText: Colors.white,
        // margin: const EdgeInsets.all(15),
      );
      signUpLoading.value = false;
    } finally {
      signUpLoading.value = false;
    }
  }

  //-----------signout method---------------------------
  Future<void> signOut() async {
    emailController.text = '';
    passwordController.text = '';

    signInLoading.value = false;
    signUpLoading.value = false;
    // googlesignInLoading.value = false;
    try {
      await supabase.auth.signOut().then((value) {
        Get.off(() => SignIn());
        Get.snackbar(
          'SignOut',
          'Success to SignOut',
          snackPosition: SnackPosition.BOTTOM,
          // backgroundColor: Colors.green,
          // colorText: Colors.black,
          // margin: const EdgeInsets.all(15),
        );
      });
    } catch (e) {
      Get.snackbar(
        'SignOut',
        'Failed to SignOut',
        snackPosition: SnackPosition.BOTTOM,
        // backgroundColor: Colors.red,
        // colorText: Colors.white,
        // margin: const EdgeInsets.all(15),
      );
    }
  }

  // @override
  // void onClose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.onClose();
  // }

  // void confrimPasswordSufixIconMethod() {
  //   confrimPasswordSufixIcon.value = !confrimPasswordSufixIcon.value;
  // }
}
