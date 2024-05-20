part of 'gpt_fetch_bloc.dart';

@immutable
sealed class GptFetchState {}

final class GptFetchInitial extends GptFetchState {}

final class GptFetchLoading extends GptFetchState {}

final class GptFetchSuccess extends GptFetchState {
  final List<GptMessageModel> messages;

  GptFetchSuccess(this.messages);
}

final class GptFetchFailure extends GptFetchState {
  final String error;

  GptFetchFailure(this.error);
}
