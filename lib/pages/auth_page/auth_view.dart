import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wft_food_delivery_code/pages/app_main_screen/app_main_screen.dart';
import 'package:wft_food_delivery_code/pages/auth_page/auth_controller.dart';

import '../start_page/start_page.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return controller.user == null ? StartPage() : AppMainScreen();
  }
}
