import 'package:get/get.dart';
import 'package:wft_food_delivery_code/pages/favorite/favorit_controller.dart';
import 'package:wft_food_delivery_code/pages/home_page/home_controller.dart';
import 'package:wft_food_delivery_code/pages/shopping_page/shopping_controller.dart';
import 'package:wft_food_delivery_code/pages/signin_signup_page/controller.dart';
import 'package:wft_food_delivery_code/pages/viewAll_Screen/view_all_screen_controller.dart';

class AllBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ViewAllScreenController>(
      () => ViewAllScreenController(),
      fenix: true,
    );
    Get.lazyPut<FavoritesController>(() => FavoritesController(), fenix: true);
    Get.lazyPut<AuthController1>(() => AuthController1(), fenix: true);
    Get.lazyPut<ShoppingController>(() => ShoppingController(), fenix: true);
  }
}
