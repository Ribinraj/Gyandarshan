part of 'fetch_content_bloc.dart';

@immutable
sealed class FetchContentEvent {}

final class FetchContentInitialEvent extends FetchContentEvent {
  final String divisionId;
  final String categoryId;
  final String subcategoryId;

  FetchContentInitialEvent({required this.divisionId, required this.categoryId, required this.subcategoryId});
}
