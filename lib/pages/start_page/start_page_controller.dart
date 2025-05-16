import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartPageController extends GetxController {
  final PageController pageController = PageController();

  final currentPsge = Rx<int>(0);
  final data = RxList<Map<String, String>>(
    [
      {
        'title1': 'The Fastest In Delivery ',
        'title2': 'Food',
        'description':
            'Order food from your favorite restaurants and track it to your doorstep',
      },
      {
        'title1': 'Fresh Ingredients',
        'title2': 'Great Taste',
        'description':
            'Only The best for you plate. Fast, fresh and flavourful',
      },
      {
        'title1': 'Order Nowy',
        'title2': 'Eat Happily',
        'description': 'Get your favorite food delivered to your doorstep',
      }
    ],
  ).obs;
}
