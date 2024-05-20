import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../../../core/core_barrel.dart';

class CustomGptLoadingWidget extends StatelessWidget {
  const CustomGptLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Image.asset(
              ImagePaths.gptBlack,
              height: Sizes.p42,
              width: Sizes.p42,
            ),
          ),
          AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              TyperAnimatedText(
                '...',
                speed: const Duration(milliseconds: 100),
                textAlign: TextAlign.center,
                textStyle: const TextStyle(fontSize: 60),
              )
            ],
          )
        ],
      ),
    );
  }
}
