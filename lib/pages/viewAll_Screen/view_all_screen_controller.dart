import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wft_food_delivery_code/Core/models/product_model.dart';

class ViewAllScreenController extends GetxController {
  final supabase = Supabase.instance.client;

  RxList<FoodModel> products = <FoodModel>[].obs;
  RxBool isLoading = true.obs;
  RxInt quantity = 1.obs;
  var cart = <CartItem>[].obs;

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

  void addProductToCart(FoodModel product) {
    final index = cart.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      cart[index].quantity += quantity.value;
      cart.refresh();
    } else {
      cart.add(CartItem(product: product, quantity: quantity.value));
    }
    Get.snackbar('Success', 'Product added to cart!');
    quantity.value = 1;
  }
}

class CartItem {
  final FoodModel product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}
