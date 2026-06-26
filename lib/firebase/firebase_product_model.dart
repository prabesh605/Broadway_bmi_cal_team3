class FirebaseProductsModel {
  final String? id;
  final String title;
  final String? subtitle;
  final double price;
  final String? image;
  final double? rating;
  FirebaseProductsModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.image,
    required this.rating,
  });
  factory FirebaseProductsModel.fromJsom(Map<String, dynamic> json, String id) {
    return FirebaseProductsModel(
      id: id,
      title: json['title'] ?? "",
      subtitle: json['subtitle'] ?? "",
      price: json['price'] ?? 0.0,
      image: json['image'] ?? "",
      rating: json['rating'] ?? "",
    );
  }
  Map<String, dynamic> toJson() => {
    'title': title,
    'subtitle': subtitle,
    'price': price,
    'image': image,
    'rating': rating,
  };
}
