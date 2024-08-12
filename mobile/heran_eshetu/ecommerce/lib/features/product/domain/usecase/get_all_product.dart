import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entitity/product.dart';
import '../repositories/product_repository.dart';

class GetAllProductUsecase {
  final ProductRepository repository;

  GetAllProductUsecase(this.repository);

  Future<Either<Failure, Product>> execute() async {
    return await repository.getAllProduct();
  }
}
