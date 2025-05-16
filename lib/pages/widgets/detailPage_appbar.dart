import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppbarParts extends StatelessWidget implements PreferredSizeWidget {
  const AppbarParts(
    BuildContext context, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      leadingWidth: 80,
      forceMaterialTransparency: true,
      actions: [
        const SizedBox(width: 27),
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 18,
            ),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: const Icon(
              Icons.more_horiz_rounded,
              color: Colors.black,
              size: 18,
            ),
          ),
        ),
        const SizedBox(width: 27)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
