class Urls {
  static const String baseUrl = 'https://g5-flutter-learning-path-be.onrender.com/api/v1';
  static   String getProductById(int id) {
    return '$baseUrl/products/$id';
  }
  static   String getAllProducts() {
    return '$baseUrl/products';}
  
}
