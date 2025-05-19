class CartItem {
  final String id;
  final String productId;
  final Map<String, dynamic> productData;
  int quantity;
  final String userId;

  CartItem({
    required this.id,
    required this.productId,
    required this.productData,
    required this.userId,
    required this.quantity,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id']?.toString() ?? '',
      productId: map['product_id']?.toString() ?? '',
      productData:
          map['product_data'] is Map
              ? Map<String, dynamic>.from(map['product_data'])
              : {},
      userId: map['user_id']?.toString() ?? '',
      quantity: (map['quantity'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': productId,
      'product_data': productData,
      'user_id': userId,
      'quantity': quantity,
    };
  }

  // ✨ copyWith برای آپدیت غیرمستقیم (immutable)
  CartItem copyWith({
    String? id,
    String? productId,
    Map<String, dynamic>? productData,
    int? quantity,
    String? userId,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productData: productData ?? this.productData,
      quantity: quantity ?? this.quantity,

      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return 'CartItem(id: $id, productId: $productId, productData: $productData, quantity: $quantity, userId: $userId)';
  }
}
