import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../product/domain/entitity/product.dart';
import '../../../product/domain/repositories/product_repository.dart';

class UpdateProductUsecase {
  final ProductRepository repository;

  UpdateProductUsecase(this.repository);

  Future<Either<Failure, Product>> execute({required Product product}) async {
    return await repository.updateProduct(product);
  }
}
