import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entitity/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/local_data_resource.dart';
import '../datasources/remote_data_source.dart';


class ProductRepositoryImpl implements ProductRepository{
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo
    
  });



  @override
  Future<Either<Failure, Product>> getProduct(int id) {
    // TODO: implement insertProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> insertProduct(Product product) {
    // TODO: implement insertProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> deleteProduct(int id) {
    // TODO: implement insertProduct
    throw UnimplementedError();
  } 

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) {
    // TODO: implement insertProduct
    throw UnimplementedError();
  } 
  
  @override
  Future<Either<Failure, List<Product>>> getAllProduct() {
    // TODO: implement insertProduct
    throw UnimplementedError();
  } 
}