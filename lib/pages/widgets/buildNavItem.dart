import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wft_food_delivery_code/Core/Utils/consts.dart';
import 'package:wft_food_delivery_code/pages/app_main_screen/app_main_conroller.dart';

class BuildNavItem extends StatelessWidget {
  final IconData icon;
  final String lable;
  final int index;
  // final VoidCallback? onTap;

  BuildNavItem({
    super.key,
    required this.icon,
    required this.lable,
    required this.index,
    // this.onTap,
  });
  final AppMainController controller = Get.put(AppMainController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () {
          controller.bottomNavCurrentIndex.value = index;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 28,
              color:
                  controller.bottomNavCurrentIndex.value == index
                      ? Consts.red
                      : Colors.grey,
            ),
            const SizedBox(height: 3),
            CircleAvatar(
              radius: 3,
              // ignore: unrelated_type_equality_checks
              backgroundColor:
                  controller.bottomNavCurrentIndex == index
                      ? Consts.red
                      : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
