import 'package:flutter/material.dart';
import 'package:wft_food_delivery_code/pages/home_page/home_controller.dart';
import 'package:get/get.dart';

class BuildHomeCategory extends StatelessWidget {
  BuildHomeCategory({super.key});

  final HomeController controller = Get.find();
  // استفاده از همان نمونه اصلی

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.categories.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SizedBox(
          height: 20,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final category = controller.categories[index];
              return GestureDetector(
                onTap: () {
                  controller.selectedCategory.value = category.name;
                  controller.fetchAndSetProducts(category.name);
                },
                child: Obx(
                  () => Container(
                    height: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:
                          controller.selectedCategory.value == category.name
                              ? Colors.orange
                              : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.transparent,
                          child: Image.network(
                            category.image,
                            scale: 2.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          category.name,
                          style: TextStyle(
                            color:
                                controller.selectedCategory.value ==
                                        category.name
                                    ? Colors.white
                                    : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
