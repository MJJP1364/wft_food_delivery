import 'package:flutter/material.dart';
import 'package:wft_food_delivery_code/Core/Utils/consts.dart';
import 'package:wft_food_delivery_code/pages/home_page/home_controller.dart';
import 'package:get/get.dart';
import 'package:wft_food_delivery_code/pages/widgets/app_banner.dart';
import 'package:wft_food_delivery_code/pages/widgets/category_builder.dart';
import 'package:wft_food_delivery_code/pages/widgets/home_product.dart';
import 'package:wft_food_delivery_code/pages/widgets/view_all.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  // فرض: قبلاً با Get.put ایجاد شده
  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Container(
              height: 45,
              width: 45,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Consts.grey1,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset('assets/food-delivery/icons/dash.png'),
            ),
          ),
          const Spacer(),
          const Row(
            children: [
              Icon(Icons.location_on_outlined, size: 18, color: Consts.red),
              Text(
                'Tehran, Iran',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 5),
              Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 18,
                color: Consts.orange,
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Container(
              height: 45,
              width: 45,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Consts.grey1,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset('assets/food-delivery/profile.png'),
            ),
          ),
        ],
      ),
      body: AnimationLimiter(
        child: Column(
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 1000),
            childAnimationBuilder:
                // (widget) => SlideAnimation(
                (widget) => SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(child: widget),
                ),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBanner(),
                    SizedBox(height: 20),
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40, child: BuildHomeCategory()),
              const SizedBox(height: 20),
              const ViewAll(),
              const SizedBox(height: 10),
              BuildHomeProduct(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
