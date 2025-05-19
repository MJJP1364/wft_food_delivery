import 'package:get/get.dart';
import 'package:wft_food_delivery_code/Core/models/product_model.dart';

class ShoppingController extends GetxController {

   RxInt quantity = 1.obs;
  var cart = <CartItem>[].obs;



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
