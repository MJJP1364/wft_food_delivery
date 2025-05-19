import 'package:flutter/material.dart';
// import 'package:food_delivery_wtf_code/Core/models/product_model.dart';
import 'package:wft_food_delivery_code/pages/home_page/home_controller.dart';
import 'package:wft_food_delivery_code/pages/widgets/products_items_display.dart';
import 'package:get/get.dart';

class BuildHomeProduct extends StatelessWidget {
  BuildHomeProduct({super.key});
  final HomeController controller = Get.find();
  // استفاده از همان نمونه اصلی

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.products.isEmpty) {
        // ignore: prefer_const_constructors
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
          child: const Align(
            alignment: Alignment.center,
            child: Text(
              'No Category Found!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        );
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SizedBox(
          height: 230,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final product = controller.products[index];
              return ProductsItemsDisplay(foodModel: product);
            },
          ),
        ),
      );
    });
  }
}
