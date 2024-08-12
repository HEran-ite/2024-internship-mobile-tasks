import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entitity/product.dart';
import '../repositories/product_repository.dart';

class GetProductUsecase {
  final ProductRepository repository;

  GetProductUsecase(this.repository);

  Future<Either<Failure, Product>> execute({required int id}) async {
    return await repository.getProduct(id);
  }
}
