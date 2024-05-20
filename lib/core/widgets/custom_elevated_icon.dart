import 'package:flutter/material.dart';

import '../core_barrel.dart';

class CustomElevatedIcon extends StatelessWidget {
  const CustomElevatedIcon({
    super.key,
    required this.onTap,
    required this.label,
    this.iconPath,
    this.backgroundColor = AppTheme.grey,
    this.textColor = AppTheme.black,
    this.imagePath,
  });
  final VoidCallback onTap;

  final String label;

  final IconData? iconPath;
  final String? imagePath;

  final Color backgroundColor;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
      child: ElevatedButton.icon(
        icon: imagePath == null
            ? Icon(
                iconPath,
                color: textColor,
                size: Sizes.p28,
              )
            : Image.asset(
                imagePath!,
                width: Sizes.p32,
                height: Sizes.p24,
              ),
        label: Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: textColor,
                fontSize: 17,
              ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          minimumSize: const Size.fromHeight(Sizes.p48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.p16),
          ),
        ),
        onPressed: onTap,
      ),
    );
  }
}
