import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wft_food_delivery_code/pages/favorite/favorit_controller.dart';
import 'package:wft_food_delivery_code/pages/viewAll_Screen/view_all_screen_controller.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({super.key});

  final FavoritesController favoriteController = Get.find();
  final ViewAllScreenController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites'), centerTitle: true),
      body: Obx(() {
        if (favoriteController.favorites.isEmpty) {
          return const Center(child: Text('No favorites yet'));
        }
        return ListView.builder(
          itemCount: favoriteController.favorites.length,
          itemBuilder: (context, index) {
            final favorite = favoriteController.favorites[index];
            final product = controller.products[index];
            return Row(
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: Row(
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,

                          child: Image(
                            image: CachedNetworkImageProvider(
                              product.imageCard,
                            ),
                          ),
                        ),

                        // Image.network(product.imageCard),
                        SizedBox(width: 20),
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            // Remove the item from the favorites list
                            // and update the UI
                            favoriteController.removeFromFavorites(
                              favorite
                                  .productId, // or product.name, depending on what removeFromFavorites expects
                            );

                            favoriteController.favorites.removeAt(index);
                            favoriteController.fetchFavorites();
                          },
                          icon: Icon(Icons.delete_forever_sharp, size: 50),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
