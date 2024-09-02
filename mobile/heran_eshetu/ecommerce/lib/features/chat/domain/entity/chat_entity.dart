import 'package:equatable/equatable.dart';

import '../../../product/domain/entitity/user.dart';

class ChatInitiate extends Equatable {
  final String userId;
  const ChatInitiate({required this.userId});

  @override
  List<Object?> get props => [userId];
}



class ChatRespientResponse extends Equatable {
  final User user2;
  final String chatId;
  const ChatRespientResponse({
    required this.user2,
    required this.chatId,
  });

  @override
  List<Object?> get props => [user2, chatId];
}
