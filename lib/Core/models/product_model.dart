class FoodModel {
  final String name;
  final String imageCard;
  final String imageDetail;
  final double price;
  final double rate;
  final String specialItems;
  final String category;
  final int kcal;
  final String time;
  final String id;

  FoodModel({
    required this.name,
    required this.imageCard,
    required this.imageDetail,
    required this.price,
    required this.rate,
    required this.specialItems,
    required this.category,
    required this.kcal,
    required this.time,
    required this.id,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'] ?? '',
      imageCard: json['imageCard'] ?? '',
      imageDetail: json['imageDetail'] ?? '',
      name: json['name'] ?? 'Unknown',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
      specialItems: json['specialItems'] ?? '',
      category: json['category'] ?? '',
      kcal: json['kcal'] ?? '',
      time: json['time'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'imageCard': imageCard,
      'imageDetail': imageDetail,
      'price': price,
      'rate': rate,
      'specialItems': specialItems,
      'category': category,
      'kcal': kcal,
      'time': time,
      'id': id,
    };
  }
}
