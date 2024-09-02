import 'package:dartz/dartz.dart';

import '../../../../core/base_usecase.dart';
import '../../../../core/error/failures.dart';
import '../entity/chat_entity.dart';
import '../repository/chat_repo.dart';

class ChatInitiateUsecase extends UseCase<ChatRespientResponse, ChatParams> {
  final ChatInitiateRepo chatRepository;
  ChatInitiateUsecase(this.chatRepository);

  @override
  Future<Either<Failure, ChatRespientResponse>> call(ChatParams param) {
    return chatRepository.initiateChat(param.userId);
  }

  @override
  Future<Either<Failure, ChatRespientResponse>> execute(ChatParams params) {
    // TODO: implement execute
    throw UnimplementedError();
  }
}

class ChatParams {
  final String userId;
  ChatParams(this.userId);
}
