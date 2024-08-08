class Product {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String rating;
  final List<int> size;
  final String category;

  Product(
      {required this.name,
      required this.description,
      required this.price,
      required this.imageUrl,
      required this.rating,
      required this.category,
      required this.size});
}
