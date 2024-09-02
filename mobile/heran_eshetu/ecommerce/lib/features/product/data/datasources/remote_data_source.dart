import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entitity/product.dart';
import '../../domain/entitity/user.dart';
import '../model/product_model.dart';
import '../model/user_model.dart';

abstract class ProductRemoteDataSource {
  Future<Product> getProduct(String id);
  Future<List<Product>> getAllProduct();
  Future<Product> insertProduct(Product product);
  Future<Product> updateProduct(Product product);
  Future<Product> deleteProduct(String id);
  Future<User> getMe(String token);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSourceImpl({required this.client});
  @override
  Future<Product> getProduct(String id) async {
    final response = await client.get(Uri.parse(Urls.getProductById(id)));
    if (response.statusCode == 200) {
      var check = ProductModel.fromJson(json.decode(response.body));
      return check;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> deleteProduct(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('tokenKey');
    final response = await client.delete(Uri.parse(Urls.getProductById(id)),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Product>> getAllProduct() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('tokenKey');

    final response = await client.get(
      Uri.parse(Urls.getAllProducts()),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      try {
        List<dynamic> list = json.decode(response.body)['data'];
        return list.map((product) => ProductModel.fromJson(product)).toList();
      } catch (e) {
        throw ServerException(); // Handle parsing errors
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> insertProduct(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('tokenKey');
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Urls.getAllProducts()),
    );

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    });

    // Add text fields
    request.fields['name'] = product.name;
    request.fields['price'] = product.price.toString();
    request.fields['description'] = product.description;

    // Add image file if available
    if (product.imageUrl.isNotEmpty && File(product.imageUrl).existsSync()) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        product.imageUrl,
        contentType: MediaType('image', 'jpeg'),
      ));
    }

    // Send the request
    var response = await request.send();
    if (response.statusCode == 201) {
      var responseBody = await response.stream.bytesToString();
      return ProductModel.fromJson(json.decode(responseBody)['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> updateProduct(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('tokenKey');
    final response = await client.put(
      Uri.parse(Urls.getProductById(product.id)),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(ProductModel.fromProduct(product).toJson()),
    );
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<User> getMe(String token) async {
    final response = await client.get(
      Uri.parse(Urls.getMe()),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }
}
