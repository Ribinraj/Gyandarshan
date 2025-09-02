part of 'fetch_division_bloc.dart';

@immutable
sealed class FetchDivisionState {}

final class FetchDivisionInitial extends FetchDivisionState {}

final class FetchDivisionLoadingState extends FetchDivisionState {}

final class FetchDivisionSuccessState extends FetchDivisionState {
  final List<DivisionModel> divisions;

  FetchDivisionSuccessState({required this.divisions});
}

final class FetchDivisionErrorState extends FetchDivisionState {
  final String message;

  FetchDivisionErrorState({required this.message});
}
