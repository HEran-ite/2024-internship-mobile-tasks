import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entitity/product.dart';
import '../model/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<Product> getProduct(int id);
  Future<List<Product>> getAllProduct();
  Future<Product> insertProduct(ProductModel product);
  Future<Product> updateProduct(ProductModel product);
  Future<Product> deleteProduct(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSourceImpl({required this.client});
  @override
  Future<Product> getProduct(int id) async {
    final response = await client.get(Uri.parse(Urls.getProductById(id)));
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> deleteProduct(int id) async {
    final response = await client.delete(Uri.parse(Urls.getProductById(id)));
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Product>> getAllProduct() async {
    final response = await client.get(Uri.parse(Urls.getAllProducts()));
    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(response.body);
      return list.map((product) => ProductModel.fromJson(product)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> insertProduct(ProductModel product) async {
    final response = await client.post(
      Uri.parse(Urls.getAllProducts()),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
    if (response.statusCode == 201) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> updateProduct(ProductModel product) async {
    final response = await client.put(
      Uri.parse(Urls.getProductById(product.id)),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
