import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/router/go_router.dart';

class MyGPTApp extends ConsumerWidget {
  const MyGPTApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) => 'Flutter GPT',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
    );
  }
}
