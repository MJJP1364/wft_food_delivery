import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wft_food_delivery_code/Core/models/product_model.dart';
import 'package:wft_food_delivery_code/pages/favorite/favorit_controller.dart';
import 'package:wft_food_delivery_code/pages/viewAll_Screen/food_details_screen.dart';
import 'package:wft_food_delivery_code/pages/viewAll_Screen/view_all_screen_controller.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({super.key});

  final FavoritesController favoriteController = Get.find();
  final ViewAllScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body:
          favoriteController.userId == null
              ? const Center(
                child: Text(
                  'برای مشاهده علاقه‌مندی‌ها ابتدا وارد حساب شوید.',
                  style: TextStyle(fontSize: 20),
                ),
              )
              : Obx(() {
                if (favoriteController.favorites.isEmpty) {
                  return const Center(
                    child: Text('لیست علاقه‌مندی‌ها خالی است.'),
                  );
                }

                return AnimationLimiter(
                  child: ListView.builder(
                    itemCount: favoriteController.favorites.length,
                    itemBuilder: (context, index) {
                      final favorite = favoriteController.favorites[index];

                      // پیدا کردن محصول با استفاده از productId
                      final product = controller.products.firstWhere(
                        (p) => p.id == favorite.productId,

                        orElse: () => FoodModel.empty(),
                      );

                      if (product.id.isEmpty) {
                        return const SizedBox(); // یا یک placeholder نمایش بده
                      }

                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 700),
                        child: SlideAnimation(
                          verticalOffset: 50.0,

                          child: FadeInAnimation(
                            child: GestureDetector(
                              onTap:
                                  () => Get.to(
                                    () => FoodDetailScreen(product: product),
                                    transition: Transition.fadeIn,
                                    duration: const Duration(milliseconds: 500),
                                  ),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 3,
                                  horizontal: 16,
                                ),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Material(
                                    color: Colors.white30,
                                    elevation: 25,
                                    child: Row(
                                      children: [
                                        // تصویر محصول
                                        Hero(
                                          tag: product.id,
                                          transitionOnUserGestures: true,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: product.imageCard,
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.contain,
                                              placeholder:
                                                  (context, url) =>
                                                      const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(width: 20),

                                        // نام محصول
                                        Column(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.name,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  product.category,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Row(
                                                  children: [
                                                    Text(
                                                      product.price.toString(),
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      '\$',
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Spacer(),

                                        // دکمه حذف
                                        IconButton(
                                          onPressed: () {
                                            favoriteController
                                                .removeFromFavorites(
                                                  favorite.productId,
                                                );
                                          },
                                          icon: Icon(
                                            Icons.delete_forever,
                                            size: 40,
                                            color: Colors.red[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
    );
  }
}
