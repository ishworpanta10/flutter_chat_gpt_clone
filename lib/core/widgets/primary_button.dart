import 'package:flutter/material.dart';

import '../core_barrel.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    this.isLoading = false,
    this.onPressed,
    this.style,
  });
  final String text;
  final bool isLoading;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style ??
          ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              height: Sizes.p28,
              width: Sizes.p28,
              child: CircularProgressIndicator(),
            )
          : Text(
              text,
              textAlign: TextAlign.center,
              // style: Theme.of(context).textTheme.labelLarge,
            ),
    );
  }
}
