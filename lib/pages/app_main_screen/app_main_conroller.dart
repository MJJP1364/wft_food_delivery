import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wft_food_delivery_code/pages/favorite/favorite.dart';
import 'package:wft_food_delivery_code/pages/home_page/home_view.dart';
import 'package:wft_food_delivery_code/pages/profile/profile.dart';
import 'package:wft_food_delivery_code/pages/shopping_page/shopping.dart';

class AppMainController extends GetxController {
  // final bottomNavCurrentIndex = RxInt(0);
  RxInt bottomNavCurrentIndex = 0.obs;
  final List<Widget> pages =
      [
        const HomePage(),
        FavoritePage(),
        ProfilePage(),
        const ShoppingPage(),
      ].obs;
}
