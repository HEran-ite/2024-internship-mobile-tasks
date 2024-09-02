import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetMeEvent extends UserEvent {
  final String token;
  const GetMeEvent({required this.token});
  @override
  List<Object> get props => [token];
}
