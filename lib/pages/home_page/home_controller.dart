import 'package:wft_food_delivery_code/Core/models/categories_model.dart';
import 'package:wft_food_delivery_code/Core/models/product_model.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  RxList<CategoriesModel> categories = <CategoriesModel>[].obs;
  RxList<FoodModel> products = <FoodModel>[].obs;
  RxString selectedCategory = ''.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    intializeData();
    super.onInit();
  }

  void intializeData() async {
    isLoading.value = true;
    try {
      final fetchedCategories = await fetchCategories();
      if (fetchedCategories.isNotEmpty) {
        categories.assignAll(fetchedCategories);
        selectedCategory.value = categories.first.name;
        final fetchedProducts = await fetchFoodProduct(selectedCategory.value);
        products.assignAll(fetchedProducts);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to initialize data: $e');
      print("Error initializing HomeController: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<CategoriesModel>> fetchCategories() async {
    try {
      final response =
          await Supabase.instance.client.from('category_items').select();
      return response.map((json) => CategoriesModel.fromJson(json)).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load categories: $e');
      print("Error fetching categories: $e");
      return [];
    }
  }

  Future<List<FoodModel>> fetchFoodProduct(String categoryName) async {
    try {
      final response = await Supabase.instance.client
          .from('food_product')
          .select()
          .eq("category", categoryName);
      print("Fetched product data: $response");
      return response.map((json) => FoodModel.fromJson(json)).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load products: $e');
      print("Error fetching food Product: $e");
      return [];
    }
  }

  //   Future<List<FoodModel>> fetchFoodProduct(String categoryName) async {
  //   try {
  //     final response = await Supabase.instance.client
  //         .from('food_product')
  //         .select()
  //         .eq("category", categoryName);

  //     final products = response.map((json) => FoodModel.fromJson(json)).toList();

  //     // 🧪 تست مقادیر imageCard
  //     for (var product in products) {
  //       print("📦 Product Name: ${product.name} | imageCard: ${product.imageCard}");
  //     }

  //     return products;
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to load products: $e');
  //     print("Error fetching food Product: $e");
  //     return [];
  //   }
  // }

  void fetchAndSetProducts(String categoryName) async {
    try {
      final fetchedProducts = await fetchFoodProduct(categoryName);
      products.assignAll(fetchedProducts);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load products: $e');
    }
  }
}
