import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wft_food_delivery_code/Core/models/product_model.dart';
import 'package:wft_food_delivery_code/pages/home_page/home_controller.dart';
import 'package:wft_food_delivery_code/pages/viewAll_Screen/food_details_screen.dart';
import 'package:get/get.dart';

class ProductsItemsDisplay extends StatelessWidget {
  final FoodModel foodModel;
  ProductsItemsDisplay({super.key, required this.foodModel});
  // final HomeController controller = Get.put(HomeController());
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap:
          () => Get.to(
            () => FoodDetailScreen(product: foodModel),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 500),
          ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 180,
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(10),
                      spreadRadius: 10,
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: size.width * 0.5,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: foodModel.id,
                  child: Image(
                    image: CachedNetworkImageProvider(foodModel.imageCard),
                    fit: BoxFit.fill,
                    height: 90,
                  ),
                ),

                
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    foodModel.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  foodModel.specialItems,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: ' \$ ',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                            color: Colors.red,
                          ),
                        ),
                        TextSpan(
                          text: foodModel.price.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: SizedBox(
              height: 30,
              child: CircleAvatar(
                backgroundColor: Colors.red[100],
                child: SvgPicture.asset(
                  'assets/food-delivery/icons/fire.svg',
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
