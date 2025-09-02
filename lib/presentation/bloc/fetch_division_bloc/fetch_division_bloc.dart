import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gyandarshan/data/division_model.dart';
import 'package:gyandarshan/domain/repositories/apprepo.dart';
import 'package:meta/meta.dart';

part 'fetch_division_event.dart';
part 'fetch_division_state.dart';

class FetchDivisionBloc extends Bloc<FetchDivisionEvent, FetchDivisionState> {
  final Apprepo repository;
  FetchDivisionBloc({required this.repository})
    : super(FetchDivisionInitial()) {
    on<FetchDivisionEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchdivisionInitialEvent>(fetchdivision);
  }

  FutureOr<void> fetchdivision(
    FetchdivisionInitialEvent event,
    Emitter<FetchDivisionState> emit,
  ) async {
    emit(FetchDivisionLoadingState());
    try {
      final response = await repository.fetchdivisions();
      if (!response.error && response.status == 200) {
        emit(FetchDivisionSuccessState(divisions: response.data!));
      } else {
        emit(FetchDivisionErrorState(message: response.message));
      }
    } catch (e) {
      emit(FetchDivisionErrorState(message: e.toString()));
    }
  }
}
