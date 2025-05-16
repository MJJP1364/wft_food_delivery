import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../signin_signup_page/controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final AuthController1 controller = Get.put(AuthController1());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () async {
              controller.signOut();
            },
          )
        ],
        leading: const Icon(Icons.abc_outlined, color: Colors.black),
      ),
    );
  }
}
