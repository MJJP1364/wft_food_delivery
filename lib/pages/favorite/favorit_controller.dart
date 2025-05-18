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
    final uid = userId;
    if (uid == null) {
      Get.snackbar('خطا', 'برای مشاهده علاقه‌مندی‌ها ابتدا وارد حساب شوید.');
      return;
    }

    try {
      final response = await supabase
          .from('favorites')
          .select()
          .eq('user_id', uid);

      favorites.assignAll(
        response.map((json) => FavoriteModel.fromJson(json)).toList(),
      );
    } catch (e) {
      Get.snackbar('خطا', 'بارگذاری علاقه‌مندی‌ها با مشکل مواجه شد.');
    }
  }

  Future<void> addToFavorites(FoodModel product) async {
    if (userId == null || userId!.isEmpty) {
      Get.snackbar("خطا", "ابتدا وارد حساب کاربری شوید.");
      return;
    }

    if (product.id.isEmpty) {
      Get.snackbar("خطا", "شناسه محصول معتبر نیست.");
      return;
    }

    final exists = favorites.any((f) => f.productId == product.id);
    if (exists) return;

    final newFav = FavoriteModel(
      id: '',
      userId: userId!,
      productId: product.id,
    );

    favorites.add(newFav);

    try {
      await supabase.from('favorites').insert({
        'user_id': userId,
        'product_id': product.id,
      });
      Get.snackbar('موفقیت', 'افزودن به علاقه‌مندی‌ها موفق بود.');
    } catch (e) {
      favorites.remove(newFav);
      Get.snackbar("خطا", "افزودن به علاقه‌مندی‌ها ناموفق بود.");
      print("Add to favorites failed: $e");
    }
  }

  Future<void> removeFromFavorites(String productId) async {
    final uid = userId;
    if (uid == null) {
      Get.snackbar('خطا', 'لطفاً ابتدا وارد حساب کاربری شوید.');
      return;
    }

    try {
      await supabase
          .from('favorites')
          .delete()
          .eq('user_id', uid)
          .eq('product_id', productId);

      // بدون درخواست مجدد، مستقیم از لیست حذف کن
      favorites.removeWhere((fav) => fav.productId == productId);

      Get.snackbar('موفقیت', 'از لیست علاقه‌مندی‌ها حذف شد.');
    } catch (e) {
      Get.snackbar('خطا', 'حذف از علاقه‌مندی‌ها با مشکل مواجه شد.');
    }
  }

  bool isFavorite(String productId) {
    return favorites.any((fav) => fav.productId == productId);
  }

  void toggleFavorite(FoodModel product) {
    if (isFavorite(product.id)) {
      print("Product removed from favorites: ${product.name}");
      removeFromFavorites(product.id);
    } else {
      addToFavorites(product);
      print("Product added to favorites: ${product.name}");
    }
  }
}
