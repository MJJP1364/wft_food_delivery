import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wft_food_delivery_code/pages/viewAll_Screen/view_all_screen_controller.dart';
import 'package:wft_food_delivery_code/pages/widgets/products_items_display.dart';

class ViewAllProductScreen extends StatelessWidget {
  ViewAllProductScreen({super.key});
  final ViewAllScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue[50],
        elevation: 0,
        title: const Text(
          'View All Product',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.products.isEmpty) {
          return const Center(child: Text("No products available."));
        } else {
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: controller.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              // crossAxisSpacing: 5,
              // mainAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {
              return ProductsItemsDisplay(
                foodModel: controller.products[index],
              );
            },
          );
        }
      }),
    );
  }
}
