part of 'fetch_subcategory_bloc.dart';

@immutable
sealed class FetchSubcategoryEvent {}

final class FetchSubcategoryIntialEvent extends FetchSubcategoryEvent {
  final String divisionId;
  final String categoryId;

  FetchSubcategoryIntialEvent({required this.divisionId, required this.categoryId});
}
