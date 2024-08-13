import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entitity/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/local_data_resource.dart';
import '../datasources/remote_data_source.dart';
import '../model/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  ProductRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, Product>> getProduct(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.getProduct(id);
        localDataSource.cacheProduct(ProductModel.fromProduct(remoteProduct));
        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try{
      final localProduct = await localDataSource.getLastProduct();
      return Right(localProduct);
    } on CacheException {
      return Left(CacheFailure());
    }}
  }

  @override
  Future<Either<Failure, Product>> insertProduct(Product product) async {
    try {
      final result = await remoteDataSource.insertProduct(ProductModel.fromProduct(product));
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  
 
  

  @override
  Future<Either<Failure, Product>> deleteProduct(int id) async {
    try {
      final result = await remoteDataSource.deleteProduct(id);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, Product>> updateProduct(Product product)async {
    try {
      final result = await remoteDataSource.updateProduct(ProductModel.fromProduct(product));
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProduct() async{
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getAllProduct();
        localDataSource.cacheProduct(remoteProducts); // Use a method that can handle a list of products
        return Right(remoteProducts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProducts = await localDataSource.getAllProducts(); // Use a method that returns a list of products
        return Right(localProducts);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
  }

