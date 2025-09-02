part of 'fetch_category_bloc.dart';

@immutable
sealed class FetchCategoryState {}

final class FetchCategoryInitial extends FetchCategoryState {}

final class FetchCategoryLoadingState extends FetchCategoryState {}

final class FetchCategorySuccessState extends FetchCategoryState {
  final List<CategoryModel> categories;

  FetchCategorySuccessState({required this.categories});
}

final class FetchCategoryErrorState extends FetchCategoryState {
  final String message;

  FetchCategoryErrorState({required this.message});
}
