import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String rating;
  final List<int> size;
  final String category;

  const Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl,
      required this.rating,
      required this.category,
      required this.size}):super();

  @override
  List<Object?> get props =>
      [id, name, description, price, imageUrl, rating, category, size];

}