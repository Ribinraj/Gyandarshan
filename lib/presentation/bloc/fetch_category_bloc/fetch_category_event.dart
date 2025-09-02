part of 'fetch_category_bloc.dart';

@immutable
sealed class FetchCategoryEvent {}

final class FetchCategoryIintialEvent extends FetchCategoryEvent {
final  String divisionId;

  FetchCategoryIintialEvent({required this.divisionId});
}
