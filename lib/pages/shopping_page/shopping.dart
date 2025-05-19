import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wft_food_delivery_code/Core/models/cart_model.dart';
import 'package:wft_food_delivery_code/pages/shopping_page/shopping_controller.dart';

class ShoppingPage extends StatelessWidget {
  ShoppingPage({super.key});

  final ShoppingController shoppingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shopping Cart',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Obx(() {
        if (shoppingController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (shoppingController.items.isEmpty) {
          return const Center(child: Text('سبد خرید شما خالی است.'));
        }

        return Obx(
          () => Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: shoppingController.items.length,
                  itemBuilder: (context, index) {
                    CartItem item = shoppingController.items[index];
                    final product = item.productData;
                    final name = product['name'] ?? 'Unowned';
                    final price = product['price']?.toDouble() ?? 0.0;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: product['imageCard'] ?? '',
                          placeholder:
                              (context, url) => CircularProgressIndicator(),
                          errorWidget:
                              (context, url, error) => Icon(Icons.error),
                          width: 60,
                          height: 60,
                          fit: BoxFit.fill,
                        ),
                        title: Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text('Price: ${price.toStringAsFixed(0)} \$'),
                        trailing: SizedBox(
                          width: 160,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed:
                                    () => shoppingController.decreaseQuantity(
                                      item,
                                    ),
                                icon: Icon(Icons.remove_circle),
                              ),
                              Text(
                                '${item.quantity}',
                                style: TextStyle(fontSize: 20),
                              ),
                              IconButton(
                                onPressed:
                                    () => shoppingController.increaseQuantity(
                                      item,
                                    ),
                                icon: Icon(Icons.add_circle),
                              ),
                              IconButton(
                                onPressed:
                                    () =>
                                        shoppingController.removeFromCart(item),
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total:  ',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          shoppingController.totalPrice.toStringAsFixed(0),
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' \$',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}
