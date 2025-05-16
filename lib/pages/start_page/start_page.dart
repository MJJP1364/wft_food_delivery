import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wft_food_delivery_code/Core/Utils/consts.dart';
import 'package:wft_food_delivery_code/pages/start_page/start_page_controller.dart';
import 'package:wft_food_delivery_code/pages/widgets/custom_clipper.dart';

import '../signin_signup_page/signin.dart';

class StartPage extends StatelessWidget {
  StartPage({super.key});

  final StartPageController controller = Get.put(StartPageController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            child: Container(
              height: size.height,
              width: size.width,
              color: Consts.imageBackground,
              child: Image.asset(
                'assets/food-delivery/food-pattern.png',
                fit: BoxFit.cover,
                color: Colors.transparent.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.05,
            left: 0,
            right: 0,
            child: SizedBox(
              height: size.height * 0.6,
              width: size.width * 0.8,
              child: Image.asset('assets/food-delivery/chef.png'),
            ),
          ),
          Positioned(
            top: size.height * 0.1,
            // left: 0,
            right: 20,
            child: SizedBox(
              height: size.height * 0.2,
              width: size.width * 0.2,
              child: Image.asset('assets/food-delivery/leaf.png'),
            ),
          ),
          Positioned(
            top: size.height * 0.45,
            right: 40,
            child: SizedBox(
              height: size.height * 0.15,
              width: size.width * 0.2,
              child: Image.asset('assets/food-delivery/chili.png'),
            ),
          ),
          Positioned(
            top: size.height * 0.15,
            left: 5,
            child: SizedBox(
              height: size.height * 0.25,
              width: size.width * 0.3,
              child: Image.asset('assets/food-delivery/ginger.png'),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: CustomClip(),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 50,
                  horizontal: 75,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 200,
                      child: PageView.builder(
                        onPageChanged: (value) {
                          controller.currentPsge.value = value;
                        },
                        controller: controller.pageController,
                        itemCount: controller.data.value.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          controller
                                              .data
                                              .value[index]['title1'],
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          controller
                                              .data
                                              .value[index]['title2'],
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                textAlign: TextAlign.center,
                                controller.data.value[index]['description']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        controller.data.value.length,
                        (index) => Obx(
                          () => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width:
                                controller.currentPsge.value == index ? 20 : 10,
                            height: 10,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color:
                                  controller.currentPsge.value == index
                                      ? Colors.orange
                                      : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    MaterialButton(
                      onPressed:
                          () => Get.to(
                            () => SignIn(),
                            transition: Transition.rightToLeft,
                            duration: const Duration(milliseconds: 500),
                          ),
                      color: Colors.red,
                      height: 65,
                      minWidth: 250,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
