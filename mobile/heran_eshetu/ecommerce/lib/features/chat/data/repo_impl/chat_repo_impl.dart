import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entity/chat_entity.dart';
import '../../domain/repository/chat_repo.dart';
import '../datasource/remote_datasource/chat_remote_datasource.dart';

class ChatInitiateRepoImpl extends ChatInitiateRepo {
  final ChatRemoteDataSource chatRemoteDataSource;
  final NetworkInfo networkInfo;

  ChatInitiateRepoImpl(this.chatRemoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, ChatRespientResponse>> initiateChat(
      String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await chatRemoteDataSource.initiateChat(userId);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure('Server Failure'));
      }
    } else {
      return Left(ServerFailure('No Internet Connection'));
    }
  }
}
