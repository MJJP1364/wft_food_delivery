import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wft_food_delivery_code/Core/models/cart_model.dart';

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
      final product = item.productData;
      final price = product['price'] is num ? product['price'].toDouble() : 0.0;
      total += price * item.quantity;
    }
    return total;
  }

  Future<void> fetchCartItems() async {
    final userId = supabase.auth.currentUser?.id.toString();
    if (userId == null) {
      Get.snackbar('Error', 'User not logged in');
      return;
    }
    isLoading.value = true;

    try {
      final response = await supabase
          .from('cart')
          .select()
          .eq('user_id', userId);

      // ignore: unnecessary_type_check
      if (response is List &&
          // ignore: unnecessary_type_check
          response.every((e) => e is Map<String, dynamic>)) {
        items.assignAll(
          // ignore: unnecessary_cast
          (response as List<Map<String, dynamic>>)
              .map((json) => CartItem.fromMap(json))
              .toList(),
        );
        // print("items: $items");
        // Get.snackbar('Success', 'Cart items loaded successfully!');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load cart items: $e');
      print("Error fetching cart items: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addProductToCart(
    String productId,
    Map<String, dynamic> productData,
    int selectedQuantity,
  ) async {
    final userId = supabase.auth.currentUser?.id.toString();

    if (userId == null) {
      Get.snackbar('Error', 'User not logged in');
      return;
    }

    isLoading.value = true;

    try {
      final existingItem =
          await supabase
              .from('cart')
              .select()
              .eq('user_id', userId)
              .eq('product_id', productId)
              .maybeSingle();

      if (existingItem != null) {
        final newQuantity = existingItem['quantity'] + selectedQuantity;
        await supabase
            .from('cart')
            .update({'quantity': newQuantity})
            .eq('id', existingItem['id'])
            .eq('user_id', userId);

        final index = items.indexWhere(
          (item) => item.productId == productId && item.userId == userId,
        );

        if (index != -1) {
          items[index].quantity = newQuantity;

          items.refresh();
        }
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
    } catch (e) {
      Get.snackbar('Error', 'Failed to add product to cart: $e');
      print("Error adding product to cart: $e");
    } finally {
      fetchCartItems();
      isLoading.value = false;
    }
  }

  Future<void> removeFromCart(CartItem item) async {
    final userId = supabase.auth.currentUser?.id.toString();

    if (userId == null) {
      Get.snackbar('Error', 'User not logged in');
      return;
    }

    try {
      await supabase
          .from('cart')
          .delete()
          .eq('id', item.id)
          .eq('user_id', userId);

      items.remove(item);
      Get.snackbar('Success', 'Product removed from cart!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove product from cart: $e');
    }
  }

  Future<void> increaseQuantity(CartItem item) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    isLoading.value = true;

    try {
      await supabase
          .from('cart')
          .update({'quantity': item.quantity + 1})
          .eq('id', item.id)
          .eq('user_id', userId);

      item.quantity++;
      items.refresh();
    } catch (e) {
      Get.snackbar('خطا', 'خطا در افزایش تعداد: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> decreaseQuantity(CartItem item) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    if (item.quantity <= 1) {
      await removeFromCart(item);
      return;
    }

    isLoading.value = true;

    try {
      await supabase
          .from('cart')
          .update({'quantity': item.quantity - 1})
          .eq('id', item.id)
          .eq('user_id', userId);

      item.quantity--;
      items.refresh();
    } catch (e) {
      Get.snackbar('خطا', 'خطا در کاهش تعداد: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
