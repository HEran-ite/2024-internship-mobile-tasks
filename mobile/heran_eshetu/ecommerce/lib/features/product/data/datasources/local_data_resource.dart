import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entitity/product.dart';
import '../model/product_model.dart';

abstract class ProductLocalDataSource {
  Future<Product> getLastProduct();
  Future<List<Product>> getLastProducts();
  Future<void> cacheProducts(List<Product> productsToCache);
  Future<void> cacheProduct(Product productToCache);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheProduct(Product product) async {
    final jsonString = json.encode(ProductModel.fromProduct(product).toJson());
    await sharedPreferences.setString('cachedProduct', jsonString);
  }

  @override
  Future<void> cacheProducts(List<Product> products) async {
    final jsonString = json.encode(products.map((product) => ProductModel.fromProduct(product).toJson()).toList());
    await sharedPreferences.setString('cachedProducts', jsonString);
  }

  @override
  Future<Product> getLastProduct() async {
    final jsonString = sharedPreferences.getString('cachedProduct');
    if (jsonString != null) {
      return ProductModel.fromJson(json.decode(jsonString));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<Product>> getLastProducts() async {
    final productsJson = sharedPreferences.getString('cachedProducts');
    if (productsJson != null) {
      final List<dynamic> productMap = json.decode(productsJson);
      return productMap
          .map((product) => ProductModel.fromJson(product))
          .toList();
    } else {
      throw CacheException();
    }
  }
}