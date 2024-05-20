import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt_clone/feature/gpt_clone/models/gpt_history_model.dart';

class HistorySearchCubit extends Cubit<List<GPTHistoryModel>> {
  HistorySearchCubit() : super([]);

  void search(String searchText, List<GPTHistoryModel> dataList) {
    log('Searched Text : $searchText');

    final List<GPTHistoryModel> searchedData = [];
    if (searchText.isNotEmpty) {
      for (var data in dataList) {
        for (var gptHistory in data.gptHistory) {
          if (gptHistory.toLowerCase().contains(searchText.toLowerCase())) {
            searchedData.add(data);
          }
        }
      }

      emit(searchedData.toSet().toList());
    }
  }
}
