
import 'package:get/get.dart';
import 'package:wft_food_delivery_code/pages/auth_page/auth_view.dart';
import 'package:wft_food_delivery_code/pages/home_page/home_view.dart';
import 'package:wft_food_delivery_code/pages/viewAll_Screen/view_all_screen.dart';

List<GetPage> routes = [
  GetPage(name: '/Auth', page: () => AuthPage()),
  GetPage(
    name: '/Home',
    page: () => const HomePage(),
  ),
  GetPage(name: '/ViewAll', page: () => ViewAllProductScreen()),
];
