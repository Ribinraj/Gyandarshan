import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gyandarshan/data/content_model.dart';
import 'package:gyandarshan/domain/repositories/apprepo.dart';
import 'package:meta/meta.dart';

part 'fetch_content_event.dart';
part 'fetch_content_state.dart';

class FetchContentBloc extends Bloc<FetchContentEvent, FetchContentState> {
  final Apprepo repository;
  FetchContentBloc({required this.repository}) : super(FetchContentInitial()) {
    on<FetchContentEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchContentInitialEvent>(fetchcontent);
  }

  FutureOr<void> fetchcontent(
    FetchContentInitialEvent event,
    Emitter<FetchContentState> emit,
  ) async {
    emit(FetchContentLoadingState());
    try {
      final response = await repository.fetchcontents(
        divisionId: event.divisionId,
        categoryId: event.categoryId,
        subcategoryId: event.subcategoryId,
      );
      if (!response.error && response.status == 200) {
        emit(FetchContentSuccessState(contents: response.data!));
      } else {
        emit(FetchcontentErrorState(message: response.message));
      }
    } catch (e) {
      emit(FetchcontentErrorState(message: e.toString()));
    }
  }
}
