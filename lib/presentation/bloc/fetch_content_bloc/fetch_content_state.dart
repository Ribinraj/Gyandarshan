part of 'fetch_content_bloc.dart';

@immutable
sealed class FetchContentState {}

final class FetchContentInitial extends FetchContentState {}

final class FetchContentLoadingState extends FetchContentState {}

final class FetchContentSuccessState extends FetchContentState {
  final List<ContentDataModel> contents;

  FetchContentSuccessState({required this.contents});
}

final class FetchcontentErrorState extends FetchContentState {
  final String message;

  FetchcontentErrorState({required this.message});
}
