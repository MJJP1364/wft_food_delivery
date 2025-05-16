
import 'package:get/get.dart';
import 'package:wft_food_delivery_code/pages/favorite/favorit_controller.dart';
import 'package:wft_food_delivery_code/pages/home_page/home_controller.dart';
import 'package:wft_food_delivery_code/pages/viewAll_Screen/view_all_screen_controller.dart';

class AllBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ViewAllScreenController>(() => ViewAllScreenController(),
        fenix: true);
    Get.lazyPut<FavoritesController>(() => FavoritesController(), fenix: true);
  }
}
