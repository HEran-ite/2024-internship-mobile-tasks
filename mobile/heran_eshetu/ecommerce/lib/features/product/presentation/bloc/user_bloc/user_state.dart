import 'package:equatable/equatable.dart';

import '../../../domain/entitity/user.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserStateEmpty extends UserState {}

class UserStateLoading extends UserState {}

class UserStateLoaded extends UserState {
  final User user;
  const UserStateLoaded({required this.user});
  @override
  List<Object> get props => [user];
}

class UserLoadFailure extends UserState {
  final String message;
  const UserLoadFailure({required this.message});
  @override
  List<Object> get props => [message];
}
