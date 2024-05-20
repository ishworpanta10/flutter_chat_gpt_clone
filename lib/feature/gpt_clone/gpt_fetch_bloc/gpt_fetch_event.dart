part of 'gpt_fetch_bloc.dart';

@immutable
sealed class GptFetchEvent {}

final class GptFetchStarted extends GptFetchEvent {
  final String message;
  final List<GptMessageModel>? previousMessages;

  GptFetchStarted({
    required this.message,
    this.previousMessages,
  });
}

final class GptFetchRefresh extends GptFetchEvent {}
