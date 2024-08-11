import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entitity/product.dart';
import '../repositories/product_repository.dart';

class InsertProductUsecase {
  final ProductRepository repository;

  InsertProductUsecase(this.repository);

  Future<Either<Failure, Product>> execute({required int id}) async {
    return await repository.insertProduct(id);
  }
}
