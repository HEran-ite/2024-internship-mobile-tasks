// ignore_for_file: avoid_renaming_method_parameters

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entitity/product.dart';
import '../repositories/product_repository.dart';
import 'base_usecase.dart';

class GetProductUsecase extends UseCase<Product, int> {
  final ProductRepository repository;

  GetProductUsecase(this.repository);

  @override
  Future<Either<Failure, Product>> execute( int id) async {
    return await repository.getProduct(id);
  }
}
