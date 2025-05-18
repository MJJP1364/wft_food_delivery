class FavoriteModel {
  final String id;
  final String? userId;
  final String productId;

  FavoriteModel({
    required this.id,
    required this.userId,
    required this.productId,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      productId: json['product_id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'user_id': userId, 'product_id': productId};
  }
}
