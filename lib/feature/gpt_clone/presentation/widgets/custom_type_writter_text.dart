import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../../../core/core_barrel.dart';
import '../../models/login_bg_color_model.dart';

class CustomTypeWriterText extends StatelessWidget {
  const CustomTypeWriterText({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280.0,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: Sizes.p32,
          fontWeight: FontWeight.bold,
        ),
        child: Center(
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              ...loginDynamicColors.map(
                (values) => TyperAnimatedText(
                  values.textValue,
                  speed: const Duration(milliseconds: 80),
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    color: values.textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
