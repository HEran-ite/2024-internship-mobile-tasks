import '../../../product/data/model/user_model.dart';
import '../../domain/entity/chat_entity.dart';

class ChatInitiateModel extends ChatInitiate {
  const ChatInitiateModel({
    required super.userId,
  });

  factory ChatInitiateModel.fromJson(Map<String, dynamic> json) {
    return ChatInitiateModel(
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
    };
  }
}

class ChatRespientResponseModel extends ChatRespientResponse {
  const ChatRespientResponseModel({
    required super.user2,
    required super.chatId,
  });

  factory ChatRespientResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatRespientResponseModel(
      user2: UserModel.fromJson(json['user2']),
      chatId: json['chatId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user2': (user2 as UserModel).toJson(),
      'chatId': chatId,
    };
  }
}
