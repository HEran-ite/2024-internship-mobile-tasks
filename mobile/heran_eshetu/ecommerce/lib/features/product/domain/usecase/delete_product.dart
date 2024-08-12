import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../product/domain/entitity/product.dart';
import '../../../product/domain/repositories/product_repository.dart';

class DeleteProductUsecase {
  final ProductRepository repository;

  DeleteProductUsecase(this.repository);

  Future<Either<Failure, Product>> execute({required int id}) async {
    return await repository.deleteProduct(id);
  }
}
