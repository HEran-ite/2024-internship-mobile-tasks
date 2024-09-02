import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../product/domain/entitity/user.dart';
import '../../../product/domain/usecase/get_all_product.dart';
import '../../../product/domain/usecase/get_me.dart';
import '../../domain/entities/log_in_entity.dart';
import '../../domain/entities/sign_up_entity.dart';
import '../../domain/usecase/log_out_usecase.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../domain/usecase/signUp_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final LogInUseCase logInUseCase;
  final LogoutUsecase loguoutUsecase;
  final GetMeUsecase getMeUsecase;

  AuthBloc(
    this.signUpUseCase,
    this.logInUseCase,
    this.loguoutUsecase,
    this.getMeUsecase,
  ) : super(AuthInitial()) {
    on<SingUpEvent>((event, emit) async {
      emit(AuthLoadingState());

      final res = await signUpUseCase(UseCaseParams(event.signUpEntity));

      res.fold(
        (l) => emit(AuthErrorState(message: l.message)),
        (r) => emit(AuthSuccessState(
            message: '',
            user: User(id: '', name: '', email: ''))), // Placeholder
      );
    });

on<LogInEvent>((event, emit) async {
  emit(AuthLoadingState());
  print('Started login process');

  final res = await logInUseCase(LogInParams(event.logInEntity));

  print('Login use case executed, result: $res');

  await res.fold(
    (failure) async {
      print('Login failed with message: ${failure.message}');
      emit(AuthErrorState(message: failure.message));
    },
    (token) async {
      print('Login succeeded, token: $token');
      final userResult = await getMeUsecase.execute(token);

      print('GetMe use case executed, result: $userResult');

      await userResult.fold(
        (failure) async {
          print('GetMe failed with message: ${failure.message}');
          emit(AuthErrorState(message: failure.message));
        },
        (user) async {
          print('User retrieved: ${user.name}');
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('user_id', user.id);
          await prefs.setString('user_name', user.name);
          await prefs.setString('user_email', user.email);
          

          if (!emit.isDone) {
            emit(AuthSuccessState(message: token, user: user));
            print('AuthSuccessState emitted');
          }
        },
      );
    },
  );
});

    on<LogOutEvent>((event, emit) async {
      emit(AuthLoadingState());

      final result = await loguoutUsecase(NoParams());

      await result.fold(
        (failure) async {
          if (!emit.isDone) {
            emit(UserLogoutState(
              message: "Failed to logout, please try again",
              status: AuthStatus.error,
            ));
          }
        },
        (response) async {
          // Clear user data from SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.clear();

          if (!emit.isDone) {
            emit(UserLogoutState(
              message: "Logged out successfully",
              status: AuthStatus.loaded,
            ));
          }
        },
      );
    });
  }
}
