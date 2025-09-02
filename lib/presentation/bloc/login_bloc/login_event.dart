part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginbuttonClickevent extends LoginEvent {
  final String divisionId;
  final String loginKey;

  LoginbuttonClickevent({required this.divisionId, required this.loginKey});
}
