part of 'fetch_subcategory_bloc.dart';

@immutable
sealed class FetchSubcategoryState {}

final class FetchSubcategoryInitial extends FetchSubcategoryState {}

final class FetchSubcategoryLoadingState extends FetchSubcategoryState {}

final class FetchSubcategorySuccessState extends FetchSubcategoryState {
  final List<SubCategoryModel> subcategories;

  FetchSubcategorySuccessState({required this.subcategories});
}

final class FetchSubcategoriesErrorState extends FetchSubcategoryState {
  final String message;

  FetchSubcategoriesErrorState({required this.message});
}
