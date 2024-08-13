class Urls {
  static const String baseUrl = 'https://fakestoreapi.com';
  static   String getProductById(int id) {
    return '$baseUrl/products/$id';
  }
  static   String getAllProducts() {
    return '$baseUrl/products';}
}
