import 'package:dartz/dartz.dart';

import '../../../../core/base_usecase.dart';
import '../../../../core/error/failures.dart';
import '../entitity/user.dart';
import '../repositories/product_repository.dart';

class GetMeUsecase extends UseCase<User, String> {
  final ProductRepository repository;

  GetMeUsecase(this.repository);

  @override
  Future<Either<Failure, User>> execute(String token) async {
    return await repository.getMe(token);
  }
}
