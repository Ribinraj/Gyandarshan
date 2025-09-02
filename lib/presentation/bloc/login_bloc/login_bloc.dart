import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:gyandarshan/domain/repositories/apprepo.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Apprepo repository;
  LoginBloc({required this.repository}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoginbuttonClickevent>(login);
  }

  FutureOr<void> login(
    LoginbuttonClickevent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());
    try {
      final response = await repository.sendotp(
        divisionId: event.divisionId,
        keyId: event.loginKey,
      );
      if (!response.error && response.status == 200) {
        emit(LoginSuccessState());
      } else {
        log(response.message);
        emit(LoginErrorState(message: response.message));
      }
    } catch (e) {
      LoginErrorState(message: e.toString());
    }
  }
}
