import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt_clone/app.dart';
import 'package:gpt_clone/feature/gpt_clone/gpt_fetch_bloc/gpt_fetch_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'feature/gpt_clone/search_cubit/history_search_cubit.dart';
import 'feature/gpt_clone/services/gpt_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // configure firebase
  await Firebase.initializeApp();

  final gptService = GptService();

  runApp(
    ProviderScope(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GptFetchBloc(gptService: gptService)),
          BlocProvider(create: (context) => HistorySearchCubit()),
        ],
        child: const MyGPTApp(),
      ),
    ),
  );
}
