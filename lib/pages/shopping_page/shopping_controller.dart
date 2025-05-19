import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wft_food_delivery_code/Core/models/cart_model.dart';
import 'package:wft_food_delivery_code/Core/models/product_model.dart';

class ShoppingController extends GetxController {
  @override
  void onInit() {
    fetchCartItems();
    super.onInit();
  }

  final supabase = Supabase.instance.client;

  final RxList<CartItem> _items = <CartItem>[].obs;
  RxList<CartItem> get items => _items;
  RxBool isLoading = true.obs;
  RxInt quantity = 1.obs;

  // to calculate the total price of the cart
  double get totalPrice {
    double total = 0.0;
    for (var item in items) {
      total += item.productData['price'] * item.quantity;
    }
    return total;
  }

  Future<void> fetchCartItems() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) {
      Get.snackbar('Error', 'User not logged in');
      return;
    }
    isLoading.value = true;

    try {
      final response = await supabase
          .from('cart')
          .select()
          .eq('user_id', userId); // Replace with actual user ID
      final List data = response;
      items.assignAll(data.map((json) => CartItem.fromMap(json)).toList());
    } catch (e) {
      Get.snackbar('Error', 'Failed to load cart items: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addProductToCart(
    String productId,
    Map<String, dynamic> productData,
    int selectedQuantity,
  ) async {
    final userId = supabase.auth.currentUser?.id;

    if (userId == null) {
      Get.snackbar('Error', 'User not logged in');
      return;
    }
    isLoading.value = true;
    try {
      // Check if the product is already in the cart
      final existingItem =
          await supabase
              .from('cart')
              .select()
              .eq('user_id', userId)
              .eq('product_id', productId)
              .maybeSingle();
      if (existingItem != null) {
        // Update the quantity if the product is already in the cart
        final newQuantity = existingItem['quantity'] + selectedQuantity;
        await supabase
            .from('cart')
            .update({'quantity': newQuantity})
            .eq('product_id', productId)
            .eq('user_id', userId);
        // Update the local list
        final index = items.indexWhere(
          (item) => item.productId == productId && item.userId == userId,
        );

        if (index != -1) {
          items[index].quantity = newQuantity;
          items.refresh();
        } else {
          final response =
              await supabase.from('cart').insert({
                'product_id': productId,
                'user_id': userId,
                'quantity': selectedQuantity,
                'product_data': productData,
              }).select();
          if (response.isNotEmpty) {
            items.add(
              CartItem(
                id: response.first['id'],
                productId: productId,
                productData: productData,
                userId: userId,
                quantity: selectedQuantity,
              ),
            );
          }
        }

        Get.snackbar('Success', 'Product quantity updated in cart!');
        // Get.snackbar('Success', 'Product added to cart!');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update product quantity: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removefromCartItem(FoodModel product) async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) {
        Get.snackbar('Error', 'User not logged in');
        return;
      }

      // Find the cart item to remove
      CartItem cartItem;
      try {
        cartItem = items.firstWhere((item) => item.productId == product.id);
      } catch (e) {
        Get.snackbar('Error', 'Product not found in cart');
        return;
      }

      isLoading.value = true;

      await supabase
          .from('cart')
          .delete()
          .eq('id', cartItem.id)
          .eq('user_id', userId);

      // Remove from local list if successful
      items.remove(cartItem);
      Get.snackbar('Success', 'Product removed from cart!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove product from cart: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

  // void addProductToCart(FoodModel product) {
  //   final index = items.indexWhere((item) => item.product.id == product.id);
  //   if (index >= 0) {
  //     items[index].quantity += quantity.value;
  //     items.refresh();
  //   } else {
  //     items.add(CartItem(product: product, quantity: quantity.value));
  //   }
  //   Get.snackbar('Success', 'Product added to cart!');
  //   quantity.value = 1;
  // }