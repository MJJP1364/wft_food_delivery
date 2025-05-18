import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';
import 'package:wft_food_delivery_code/pages/viewAll_Screen/view_all_screen_controller.dart';
import 'package:wft_food_delivery_code/pages/widgets/products_items_display.dart';

class ViewAllProductScreen extends StatelessWidget {
  ViewAllProductScreen({super.key});
  final ViewAllScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    int columnCount = 2;
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
          return AnimationLimiter(
            child: GridView.count(
              childAspectRatio: 0.8,
              crossAxisCount: columnCount,
              // children: List.generate(100, (int index) {
              children: List.generate(controller.products.length, (index) {
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 1000),
                  columnCount: columnCount,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      // child: NewWidget(controller: controller),
                      child: ProductsItemsDisplay(
                        foodModel: controller.products[index],
                      ),
                    ),
                  ),
                );
              }),
            ),
            // NewWidget(controller: controller),
          );
        }
      }),
    );
  }
}
