import '../../domain/entitity/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required int id,
    required String name,
    required double price,
    required String description,
    required String category,
    required List<int> size,
    required String rating,
    required String imageUrl,
  }) : super(
          id: id,
          name: name,
          price: price,
          description: description,
          category: category,
          imageUrl: imageUrl,
          rating: rating,
          size: size,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
      imageUrl: json['imageUrl'],
      rating: json['rating'],
      size: List<int>.from(json['size'].map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'category': category,
      'imageUrl': imageUrl,
      'rating': rating,
      'size': size,
    };
  }
}
