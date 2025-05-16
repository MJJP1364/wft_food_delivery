class CategoriesModel {
  String image, name;

  CategoriesModel({required this.image, required this.name});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      image: json['image'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
