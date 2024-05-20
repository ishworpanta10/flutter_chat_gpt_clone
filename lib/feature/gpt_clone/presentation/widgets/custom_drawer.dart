import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gpt_clone/core/core_barrel.dart';
import 'package:gpt_clone/feature/gpt_clone/models/gpt_history_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/go_router.dart';
import '../../constants/constants.dart';
import '../../search_cubit/history_search_cubit.dart';
import '../../services/google_auth_service.dart';
import 'widgets.dart';

class CustomDrawer extends HookConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchTextEditingController = useTextEditingController();
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: TextFormField(
                controller: searchTextEditingController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    context.read<HistorySearchCubit>().search(
                          searchTextEditingController.text,
                          gptHistoryListModel,
                        );
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: Sizes.p16,
                    vertical: Sizes.p12,
                  ),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Sizes.p12),
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<HistorySearchCubit, List<GPTHistoryModel>>(
                builder: (context, searchedItems) {
                  log('searchTextEditingController.text :${searchTextEditingController.text}');

                  if (searchedItems.isNotEmpty && searchTextEditingController.text.length > 1) {
                    return ListView(
                      children: [
                        ...List.generate(
                          searchedItems.length,
                          (index) {
                            final historyData = searchedItems[index];
                            return DrawerGPTHistory(
                              titleDate: historyData.dateTitle,
                              gptHistory: historyData,
                            );
                          },
                        ),
                      ],
                    );
                  }
                  return ListView(
                    children: [
                      // Search bar

                      gapH16,
                      //chat gpt icon and text
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: Sizes.p16),
                        decoration: BoxDecoration(
                          color: AppTheme.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(Sizes.p16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(Sizes.p8),
                          child: Row(
                            children: [
                              Image.asset(ImagePaths.gptBlack, height: Sizes.p24, width: Sizes.p24),
                              gapW16,
                              const Text(
                                'Chat GPT',
                                style: TextStyle(
                                  fontSize: Sizes.p16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Explore GPT

                      ListTile(
                        leading: const Icon(Icons.grain_outlined),
                        title: const Text('Explore GPTs'),
                        onTap: () {},
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: Sizes.p16),
                        child: Divider(),
                      ),
                      gapH16,
                      ...List.generate(
                        gptHistoryListModel.length,
                        (index) {
                          final historyData = gptHistoryListModel[index];
                          return DrawerGPTHistory(
                            titleDate: historyData.dateTitle,
                            gptHistory: historyData,
                          );
                        },
                      ),

                      // gapH16,
                      // DrawerGPTHistory(titleDate: 'Last Week', gptHistory: gptHistoryList),
                      // gapH16,
                      // DrawerGPTHistory(titleDate: '2 weeks ago', gptHistory: gptHistoryList),
                      // gapH16,
                      // DrawerGPTHistory(titleDate: 'Last Month', gptHistory: gptHistoryList),
                    ],
                  );
                },
              ),
            ),
            // User Profile Row
            const UserTileProfileDrawer(),
          ],
        ),
      ),
    );
  }
}

class UserTileProfileDrawer extends StatelessWidget {
  const UserTileProfileDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final ssoService = ref.read(googleAuthServiceProvider);
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: ssoService.getCurrentUser().photoURL != null
                ? NetworkImage(
                    ssoService.getCurrentUser().photoURL ?? 'https://via.placeholder.com/150',
                  )
                : null,
            child: ssoService.getCurrentUser().photoURL == null
                ? Text(
                    ssoService.getCurrentUser().displayName![0].toUpperCase(),
                  )
                : null,
          ),
          title: Text(ssoService.getCurrentUser().displayName ?? '---'),
          onTap: () {
            context.pushNamed(ScreenPath.profileSetting.name);
          },
          trailing: const Icon(Icons.more_horiz, color: AppTheme.grey),
        );
      },
    );
  }
}
