import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wft_food_delivery_code/pages/app_main_screen/app_main_conroller.dart';
import 'package:wft_food_delivery_code/pages/widgets/buildNavItem.dart';

import '../../Core/Utils/consts.dart';

class AppMainScreen extends StatelessWidget {
  AppMainScreen({super.key});

  final controller = Get.put(AppMainController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() => controller.pages[controller.bottomNavCurrentIndex.value]),
      bottomNavigationBar: Container(
        height: 90,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BuildNavItem(
              icon: Iconsax.home_15,
              lable: 'A',
              index: 0,
            ),
            const SizedBox(width: 10),
            BuildNavItem(
              icon: Iconsax.heart_add,
              lable: 'B',
              index: 1,
            ),
            const SizedBox(width: 90),
            BuildNavItem(
              icon: Icons.person_outline,
              lable: 'C',
              index: 2,
            ),
            const SizedBox(width: 10),
            Stack(
              clipBehavior: Clip.none,
              children: [
                BuildNavItem(
                  icon: Iconsax.shopping_cart,
                  lable: 'D',
                  index: 3,
                ),
                const Positioned(
                  right: -7,
                  top: 16,
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Consts.red,
                    child: Text(
                      '0',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
                Positioned(
                  right: size.width / 2 - 60,
                  top: -25,
                  child: InkWell(
                    onTap: () {},
                    child: const CircleAvatar(
                      backgroundColor: Consts.red,
                      radius: 35,
                      child: Icon(
                        CupertinoIcons.search,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
