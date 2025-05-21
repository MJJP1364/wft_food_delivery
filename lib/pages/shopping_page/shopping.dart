import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
          'Shopping Cart',
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
            AnimationLimiter(
              child: Expanded(
                child: ListView.builder(
                  itemCount: shoppingController.items.length,
                  itemBuilder: (context, index) {
                    final item = shoppingController.items[index];
                    final product = item.productData;
                    final name = product['name'] ?? 'ناشناس';
                    final price = product['price']?.toDouble() ?? 0.0;

                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 700),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              left: 8.0,
                              right: 8.0,
                            ),
                            child: SizedBox(
                              height: 100,
                              width: double.infinity,
                              child: Card(
                                elevation: 10,
                                // color: Colors.white54,
                                shadowColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white30,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(width: 5),
                                      CachedNetworkImage(
                                        imageUrl: product['imageCard'] ?? '',
                                        placeholder:
                                            (context, url) =>
                                                const CircularProgressIndicator(),
                                        errorWidget:
                                            (context, url, error) =>
                                                const Icon(Icons.error),
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.fill,
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            maxLines: 1,
                                            name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            'قیمت: ${price.toStringAsFixed(2)} تومان',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed:
                                                () => shoppingController
                                                    .decreaseQuantity(item),
                                            icon: const Icon(
                                              Icons.remove_circle,
                                            ),
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
                                                () => shoppingController
                                                    .increaseQuantity(item),
                                            icon: const Icon(Icons.add_circle),
                                          ),
                                          IconButton(
                                            onPressed:
                                                () => shoppingController
                                                    .removeFromCart(item),
                                            icon: const Icon(Icons.delete),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      const Text(
                        'Total: ',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
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
                        ' \$',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),

                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      backgroundColor: Colors.red,

                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    onPressed: shoppingController.clearCart,
                    icon: Icon(Icons.delete_forever, size: 35),
                    label: Text(
                      "پاک کردن کل سبد",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        );
      }),
    );
  }
}
