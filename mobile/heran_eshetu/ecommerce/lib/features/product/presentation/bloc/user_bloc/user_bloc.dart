import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/get_me.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetMeUsecase getMeUsecase;

  UserBloc({required this.getMeUsecase}) : super(UserInitial()) {
    on<GetMeEvent>((event, emit) async {
      emit(UserStateLoading());
      final result = await getMeUsecase.execute(event.token);
      result.fold((failure) => emit(UserLoadFailure(message: failure.message)),
          (user) => emit(UserStateLoaded(user: user)));
    });
  }
}
