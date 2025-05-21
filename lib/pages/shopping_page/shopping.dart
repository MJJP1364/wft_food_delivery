import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wft_food_delivery_code/pages/shopping_page/shopping_controller.dart';

class ShoppingPage extends StatelessWidget {
  ShoppingPage({super.key});

  final ShoppingController shoppingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'سبد خرید',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        // Loading State
        // if (shoppingController.isLoading.value) {
        //   return const Center(child: CircularProgressIndicator());
        // }

        // Empty Cart State
        if (shoppingController.items.isEmpty) {
          return const Center(child: Text('سبد خرید شما خالی است.'));
        }

        // Main Content
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: shoppingController.items.length,
                itemBuilder: (context, index) {
                  final item = shoppingController.items[index];
                  final product = item.productData;
                  final name = product['name'] ?? 'ناشناس';
                  final price = product['price']?.toDouble() ?? 0.0;

                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Material(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(5.0),
                        leading: CachedNetworkImage(
                          imageUrl: product['imageCard'] ?? '',
                          placeholder:
                              (context, url) =>
                                  const CircularProgressIndicator(),
                          errorWidget:
                              (context, url, error) => const Icon(Icons.error),
                          width: 60,
                          height: 60,
                          fit: BoxFit.fill,
                        ),
                        title: Text(
                          maxLines: 1,
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          'قیمت: ${price.toStringAsFixed(0)} تومان',
                        ),
                        trailing: SizedBox(
                          width: 170,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed:
                                    () => shoppingController.decreaseQuantity(
                                      item,
                                    ),
                                icon: const Icon(Icons.remove_circle),
                              ),
                              Text(
                                '${item.quantity}',
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.blue,
                                ),
                              ),
                              IconButton(
                                onPressed:
                                    () => shoppingController.increaseQuantity(
                                      item,
                                    ),
                                icon: const Icon(Icons.add_circle),
                              ),
                              IconButton(
                                onPressed:
                                    () =>
                                        shoppingController.removeFromCart(item),
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: shoppingController.clearCart,
              icon: Icon(Icons.delete_forever),
              label: Text("پاک کردن کل سبد"),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'جمع کل: ',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    shoppingController.totalPrice.toStringAsFixed(0),
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const Text(
                    ' تومان',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      }),
    );
  }
}
