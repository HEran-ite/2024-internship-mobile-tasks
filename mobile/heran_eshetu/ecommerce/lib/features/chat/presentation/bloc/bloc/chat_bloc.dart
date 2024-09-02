import 'package:bloc/bloc.dart';

import '../../../domain/entity/chat_entity.dart';
import '../../../domain/usecase/chat_usecase.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatInitiateUsecase chatInitiateUsecase;
  ChatBloc(this.chatInitiateUsecase) : super(ChatInitial()) {
    on<InitiateChatEvent>((event, emit) async {
      emit(ChatLoading());
      final res = await chatInitiateUsecase(ChatParams(event.userId));
      res.fold(
          (l) => {emit(ChatError(l.message))}, (r) => {emit(ChatLoaded(r))});
    });
  }
}
