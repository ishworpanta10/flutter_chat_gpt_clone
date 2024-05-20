import 'package:flutter/material.dart';

class LoginDynamicColor {
  final Color bgColor;
  final Color textColor;

  final String textValue;

  LoginDynamicColor({required this.textValue, required this.bgColor, required this.textColor});
}

List<LoginDynamicColor> loginDynamicColors = [
  LoginDynamicColor(
      textValue: 'Let\'s brainstorm',
      bgColor: const Color(0xFFF8BBD0),
      textColor: const Color(0xFF880E4F)), // Light Pink background with Dark Magenta text
  LoginDynamicColor(
      textValue: 'Let\'s go',
      bgColor: const Color(0xFFE1BEE7),
      textColor: const Color(0xFF4A148C)), // Light Purple background with Dark Purple text
  LoginDynamicColor(
      textValue: 'Chat GPT',
      bgColor: const Color(0xFFBBDEFB),
      textColor: const Color(0xFF0D47A1)), // Light Blue background with Dark Blue text
  LoginDynamicColor(
      textValue: 'Let\'s explore',
      bgColor: const Color(0xFFC8E6C9),
      textColor: const Color(0xFF1B5E20)), // Light Green background with Dark Green text
  LoginDynamicColor(
      textValue: 'Let\'s collaborate',
      bgColor: const Color(0xFFFFF9C4),
      textColor: const Color(0xFFF57F17)), // Light Yellow background with Dark Yellow text
  LoginDynamicColor(
      textValue: 'Let\'s invent',
      bgColor: const Color(0xFFFFCCBC),
      textColor: const Color(0xFFBF360C)), // Light Orange background with Dark Orange text
  LoginDynamicColor(
      textValue: 'Let\'s design',
      bgColor: const Color(0xFFD1C4E9),
      textColor: const Color(0xFF512DA8)), // Light Indigo background with Dark Indigo text
  LoginDynamicColor(
    textValue: 'Let\'s chit-chat',
    bgColor: const Color(0xFFDCEDC8),
    textColor: const Color(0xFF33691E),
  ), // Light Lime Green background with Dark Lime Green text
  LoginDynamicColor(
    textValue: 'Let\'s discover',
    bgColor: const Color(0xFFFFF176),
    textColor: const Color(0xFFF57F17),
  ), // Light Yellow background with Dark Amber text
  LoginDynamicColor(
    textValue: 'Let\'s innovate',
    bgColor: const Color(0xFFFFAB91),
    textColor: const Color(0xFFD84315),
  ), // Light Coral background with Dark Coral text
];
