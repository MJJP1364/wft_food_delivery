import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wft_food_delivery_code/Core/models/product_model.dart';
import 'package:wft_food_delivery_code/pages/favorite/favorit_controller.dart';
import 'package:wft_food_delivery_code/pages/viewAll_Screen/view_all_screen_controller.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({super.key});

  final FavoritesController favoriteController = Get.find();
  final ViewAllScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('علاقه‌مندی‌ها'), centerTitle: true),
      body: Obx(() {
        if (favoriteController.favorites.isEmpty) {
          return const Center(child: Text('لیست علاقه‌مندی‌ها خالی است.'));
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
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          // تصویر محصول
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: product.imageCard,
                              width: 80,
                              height: 80,
                              fit: BoxFit.fill,
                              placeholder:
                                  (context, url) =>
                                      const CircularProgressIndicator(),
                              errorWidget:
                                  (context, url, error) =>
                                      const Icon(Icons.error),
                            ),
                          ),

                          const SizedBox(width: 20),

                          // نام محصول
                          Expanded(
                            child: Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          // دکمه حذف
                          IconButton(
                            onPressed: () {
                              favoriteController.removeFromFavorites(
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
              );
            },
          ),
        );
      }),
    );
  }
}
