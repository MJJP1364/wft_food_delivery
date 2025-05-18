import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:wft_food_delivery_code/Core/Utils/consts.dart';
import 'package:wft_food_delivery_code/Core/models/product_model.dart';
import 'package:wft_food_delivery_code/pages/favorite/favorit_controller.dart';
import 'package:wft_food_delivery_code/pages/viewAll_Screen/view_all_screen_controller.dart';
import 'package:wft_food_delivery_code/pages/widgets/detailPage_appbar.dart';
import 'package:wft_food_delivery_code/pages/widgets/foodInfo.dart';

class FoodDetailScreen extends StatelessWidget {
  FoodDetailScreen({super.key, required this.product});

  final FoodModel product;
  final ViewAllScreenController controller = Get.find();
  final FavoritesController favoriteController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppbarParts(context),
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            width: size.width,
            height: size.height,
            color: Consts.imageBackground,
            child: Image.asset(
              'assets/food-delivery/food-pattern.png',
              repeat: ImageRepeat.repeatY,
              color: Consts.imageBackground2,
            ),
          ),
          Container(
            width: size.width,
            height: size.height * 0.75,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
          ),
          Container(
            width: size.width,
            height: size.height,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 90),
                  Center(
                    child: Hero(
                      tag: product.id,
                      child:
                          product.imageCard.isNotEmpty
                              ? Image(
                                image: CachedNetworkImageProvider(
                                  product.imageCard,
                                ),
                                fit: BoxFit.fill,
                                height: 200,
                              )
                              : Image.asset(
                                'assets/images/placeholder.png', // اگر داری
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Container(
                      height: 45,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Consts.red,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (controller.quantity.value > 1) {
                                  controller.quantity.value--;
                                }
                              },
                              child: const Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Obx(
                              () => Text(
                                controller.quantity.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                controller.quantity.value++;
                              },
                              child: const Icon(Icons.add, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            product.specialItems,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Consts.red,
                          ),
                          children: [
                            const TextSpan(
                              text: '\$',
                              style: TextStyle(fontSize: 25),
                            ),
                            const TextSpan(text: ' '),
                            TextSpan(
                              text: product.price.toString(),
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FoodInfo(
                        image: 'assets/food-delivery/icons/Star.png',
                        value: product.rate.toString(),
                      ),
                      FoodInfo(
                        image: 'assets/food-delivery/icons/fire.png',
                        value: '${product.kcal} Kcal',
                      ),
                      FoodInfo(
                        image: 'assets/food-delivery/icons/Timer.png',
                        value: product.time,
                      ),
                      Obx(() {
                        final isFav = favoriteController.isFavorite(product.id);
                        return IconButton(
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            favoriteController.toggleFavorite(product);
                          },
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const ReadMoreText(
                    ' fgdsfnfgjdghjg,jhv,h,jv,hjvgcgckhgv,jhkbhkjlnbhvjkmngjnbghjkmnbvjkl,mnbvcghjk,mnbvf\nghjkl.,mnbhlkn.,mcgghlk;.m,nvklm.n,vhlkn.m,vkknbhjkn.l;/n jhyujhbghjnbvghjmnbvcfghjnmbv cghjnmb vcfghjbvcxfghkbvmncb.,jhj',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                      color: Colors.black,
                    ),
                    trimLength: 110,
                    trimCollapsedText: 'Read More',
                    trimExpandedText: 'Read Less',
                    colorClickableText: Consts.red,
                    moreStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Consts.red,
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 350,
        child: FloatingActionButton.extended(
          backgroundColor: Consts.red,
          label: const Text(
            'Add to Cart',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              letterSpacing: 1.3,
            ),
          ),
          onPressed: () {
            controller.addProductToCart(product);
          },
        ),
      ),
    );
  }
}
