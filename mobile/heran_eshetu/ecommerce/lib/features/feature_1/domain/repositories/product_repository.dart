import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entitity/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, Product>> getProduct(int id);
  Future<Either<Failure, Product>> insertProduct(int id);
  Future<Either<Failure, Product>> updateProduct(int id);
  Future<Either<Failure, Product>> deleteProduct(int id);
}
