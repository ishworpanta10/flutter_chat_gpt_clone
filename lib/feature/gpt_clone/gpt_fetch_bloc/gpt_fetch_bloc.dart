import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../models/gpt_message_model.dart';
import '../services/gpt_service.dart';

part 'gpt_fetch_event.dart';
part 'gpt_fetch_state.dart';

class GptFetchBloc extends Bloc<GptFetchEvent, GptFetchState> {
  final GptService gptService;

  GptFetchBloc({
    required this.gptService,
  }) : super(GptFetchInitial()) {
    on<GptFetchStarted>((event, emit) async {
      emit(GptFetchLoading());

      await gptService.getChatGPTResponse(event.message).then((response) {
        if (event.previousMessages != null) {
          response.addAll(event.previousMessages!);
        }
        emit(GptFetchSuccess(response));
      }).catchError((error, st) {
        log('Stack Trace: $st');
        emit(GptFetchFailure(error));
      });
    });
  }
}
