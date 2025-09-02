import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gyandarshan/data/subcategory_model.dart';
import 'package:gyandarshan/domain/repositories/apprepo.dart';
import 'package:meta/meta.dart';

part 'fetch_subcategory_event.dart';
part 'fetch_subcategory_state.dart';

class FetchSubcategoryBloc
    extends Bloc<FetchSubcategoryEvent, FetchSubcategoryState> {
  final Apprepo repository;
  FetchSubcategoryBloc({required this.repository})
    : super(FetchSubcategoryInitial()) {
    on<FetchSubcategoryEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchSubcategoryIntialEvent>(fetchsubcategory);
  }

  FutureOr<void> fetchsubcategory(
    FetchSubcategoryIntialEvent event,
    Emitter<FetchSubcategoryState> emit,
  ) async {
    emit(FetchSubcategoryLoadingState());
    try {
      final response = await repository.fetchsubcategories(
        divisionId: event.divisionId,
        categoryId: event.categoryId,
      );
      if (!response.error && response.status == 200) {
        emit(FetchSubcategorySuccessState(subcategories: response.data!));
      } else {
        emit(FetchSubcategoriesErrorState(message: response.message));
      }
    } catch (e) {
      emit(FetchSubcategoriesErrorState(message:e.toString()));
    }
  }
}
