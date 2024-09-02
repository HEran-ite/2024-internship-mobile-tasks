import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entity/chat_entity.dart';

abstract class ChatInitiateRepo{
  Future<Either<Failure,ChatRespientResponse>> initiateChat( String userId);
}