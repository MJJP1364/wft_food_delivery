import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wft_food_delivery_code/Core/models/product_model.dart';

class ViewAllScreenController extends GetxController {
  final supabase = Supabase.instance.client;

  RxList<FoodModel> products = <FoodModel>[].obs;
  RxBool isLoading = true.obs;
 

  @override
  void onInit() {
    super.onInit();
    fetchFoodProduct();
  }

  Future<void> fetchFoodProduct() async {
    try {
      final response = await supabase.from('food_product').select();
      final List data = response;
      products.assignAll(data.map((json) => FoodModel.fromJson(json)).toList());
      isLoading.value = false;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load products: $e');
      print("Error fetching food Product: $e");
    } finally {
      isLoading.value = false;
    }
  }

  
}
