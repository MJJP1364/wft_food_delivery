import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wft_food_delivery_code/pages/shopping_page/shopping_controller.dart';

class ShoppingPage extends StatelessWidget {
  ShoppingPage({super.key});

  final ShoppingController shoppingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('shopping')));
  }
}
