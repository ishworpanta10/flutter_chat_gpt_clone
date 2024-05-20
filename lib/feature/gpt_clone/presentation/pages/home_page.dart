import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gpt_clone/core/core_barrel.dart';
import 'package:gpt_clone/feature/gpt_clone/models/gpt_message_model.dart';
import 'package:gpt_clone/feature/gpt_clone/models/gpt_recommendation_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../gpt_fetch_bloc/gpt_fetch_bloc.dart';
import '../widgets/widgets.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageController = useTextEditingController();

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset(
                ImagePaths.drawer,
                height: Sizes.p24,
                width: Sizes.p24,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        centerTitle: true,
        title: const Text(
          'Get Plus ',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppTheme.blue,
          ),
        ),
      ),
      body: BlocBuilder<GptFetchBloc, GptFetchState>(
        builder: (context, gptFetchBlocState) {
          return Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (gptFetchBlocState is GptFetchInitial) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(ImagePaths.gptBlack, height: Sizes.p48, width: Sizes.p48),
                            gapH16,
                            AnimatedTextKit(
                              animatedTexts: [
                                TyperAnimatedText(
                                  'Start Chatting with GPT',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            // const Text('Start Chatting with GPT'),
                          ],
                        ),
                      );
                    } else if (gptFetchBlocState is GptFetchLoading) {
                      return const CustomGptLoadingWidget();
                    } else if (gptFetchBlocState is GptFetchSuccess) {
                      final responseList = gptFetchBlocState.messages;
                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<GptFetchBloc>().add(GptFetchStarted(message: ''));
                        },
                        child: ListView.builder(
                          itemCount: responseList.length,
                          itemBuilder: (context, index) {
                            final message = responseList[index];

                            return IntrinsicWidth(
                              // padding: const EdgeInsets.all(8),
                              child: Container(
                                margin: message.role == 'user' ? const EdgeInsets.only(left: 160) : null,
                                decoration: message.role == 'user'
                                    ? BoxDecoration(
                                        color: AppTheme.grey.withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(Sizes.p16),
                                      )
                                    : null,
                                child: ListTile(
                                  titleAlignment: ListTileTitleAlignment.bottom,
                                  leading: message.role != 'user'
                                      ? Image.asset(
                                          ImagePaths.gptBlack,
                                          height: Sizes.p36,
                                          width: Sizes.p36,
                                        )
                                      : null,
                                  title: Text(
                                    message.content.replaceFirst("\n\n", '').toString(),
                                    style: TextStyle(
                                      color: message.role == 'error' ? AppTheme.red : null,
                                    ),
                                    textAlign: message.role == 'user' ? TextAlign.right : TextAlign.left,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (gptFetchBlocState is GptFetchFailure) {
                      return Center(
                        child: Text(gptFetchBlocState.error),
                      );
                    } else {
                      return const Center(
                        child: Text('Something went wrong'),
                      );
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: Sizes.p16, bottom: Sizes.p24),
                height: Sizes.p100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: recommendationList.map((recommendation) {
                    return GestureDetector(
                      onTap: () {
                        List<GptMessageModel> previousMessages = [];
                        if (gptFetchBlocState is GptFetchSuccess) {
                          previousMessages = gptFetchBlocState.messages;
                        }

                        final message = '${recommendation.title} ${recommendation.subTitle}';
                        messageController.text = message;
                        context.read<GptFetchBloc>().add(
                              GptFetchStarted(
                                message: message,
                                previousMessages: previousMessages,
                              ),
                            );
                        messageController.clear();
                      },
                      child: GptRecommendationTile(
                        title: recommendation.title,
                        subtitle: recommendation.subTitle,
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: Sizes.p16, bottom: Sizes.p24),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: messageController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                          hintText: 'Message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Sizes.p32),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        List<GptMessageModel> previousMessages = [];
                        if (gptFetchBlocState is GptFetchSuccess) {
                          previousMessages = gptFetchBlocState.messages;
                        }
                        if (messageController.text.isNotEmpty) {
                          context.read<GptFetchBloc>().add(
                                GptFetchStarted(
                                  message: messageController.text,
                                  previousMessages: previousMessages,
                                ),
                              );
                          messageController.clear();
                          FocusScope.of(context).unfocus();
                        }
                      },
                      icon: const Icon(Icons.send_rounded),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
