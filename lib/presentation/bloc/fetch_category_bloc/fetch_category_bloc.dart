import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gyandarshan/data/category_model.dart';
import 'package:gyandarshan/domain/repositories/apprepo.dart';
import 'package:gyandarshan/presentation/bloc/fetch_division_bloc/fetch_division_bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_category_event.dart';
part 'fetch_category_state.dart';

class FetchCategoryBloc extends Bloc<FetchCategoryEvent, FetchCategoryState> {
  final Apprepo repository;
  FetchCategoryBloc({required this.repository}) : super(FetchCategoryInitial()) {
    on<FetchCategoryEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchCategoryIintialEvent>(fetchcategory);
  }

  FutureOr<void> fetchcategory(
    FetchCategoryIintialEvent event,
    Emitter<FetchCategoryState> emit,
  ) async {
    emit(FetchCategoryLoadingState());
    try {
      final response = await repository.fetchcategories(divisionId: event.divisionId);
      if (!response.error && response.status == 200) {
        emit(FetchCategorySuccessState(categories: response.data!));
      } else {
        emit(FetchCategoryErrorState(message: response.message));
      }
    } catch (e) {
       emit(FetchCategoryErrorState(message: e.toString()));
    }
  }
}
