class Urls {
  static const String baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v3';
  static String getProductById(String id) {
    return '$baseUrl/products/$id';
  }

  static String getAllProducts() {
    return '$baseUrl/products';}
  
  static String signUp() {
    return '$baseUrl/auth/register';
  }
  static String login() {
    return '$baseUrl/auth/login';
  }
  static String getMe() {
    return '$baseUrl/users/me';
  }
}

