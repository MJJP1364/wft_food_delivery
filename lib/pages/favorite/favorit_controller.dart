import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wft_food_delivery_code/Core/models/favoriteModel.dart';
import 'package:wft_food_delivery_code/Core/models/product_model.dart';

class FavoritesController extends GetxController {
  RxList<FavoriteModel> favorites = <FavoriteModel>[].obs;
  final supabase = Supabase.instance.client;

  String? get userId => supabase.auth.currentUser?.id;

  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    if (userId == null) return;

    try {
      final response = await supabase
          .from('favorites')
          .select()
          .eq('user_id', userId!);

      favorites.value =
          response.map((json) => FavoriteModel.fromJson(json)).toList();
      print("favorites: $favorites");
    } catch (e) {
      Get.snackbar('خطا', 'بارگذاری علاقه‌مندی‌ها با مشکل مواجه شد.');
    }
  }

  Future<void> addToFavorites(FoodModel product) async {
    if (userId == null) return;

    final exists = favorites.any((f) => f.productId == product.id);
    if (exists) return;

    try {
      await supabase.from('favorites').insert({
        'user_id': userId,
        'product_id': product.id,
      });

      await fetchFavorites();
    } catch (e) {
      Get.snackbar('خطا', 'افزودن به علاقه‌مندی‌ها با مشکل مواجه شد.');
    }
  }

  Future<void> removeFromFavorites(String productId) async {
    if (userId == null) return;

    try {
      await supabase
          .from('favorites')
          .delete()
          .eq('user_id', userId!)
          .eq('product_id', productId);

      await fetchFavorites();
    } catch (e) {
      Get.snackbar('خطا', 'حذف از علاقه‌مندی‌ها با مشکل مواجه شد.');
    }
  }

  bool isFavorite(String productId) {
    return favorites.any((fav) => fav.productId == productId);
  }

  void toggleFavorite(FoodModel product) {
    if (isFavorite(product.id)) {
      removeFromFavorites(product.id);
    } else {
      addToFavorites(product);
    }
  }
}
