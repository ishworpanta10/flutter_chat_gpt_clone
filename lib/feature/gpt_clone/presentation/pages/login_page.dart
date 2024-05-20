import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/core_barrel.dart';
import '../../models/login_bg_color_model.dart';
import '../../services/google_auth_service.dart';
import '../widgets/widgets.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late Timer _timer;
  late LoginDynamicColor _currentColor;

  @override
  void initState() {
    super.initState();
    _currentColor = _getRandomColor();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _currentColor = _getRandomColor();
      });
    });
  }

  LoginDynamicColor _getRandomColor() {
    final random = Random();
    return loginDynamicColors[random.nextInt(loginDynamicColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _currentColor.bgColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          fit: StackFit.expand,
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: MediaQuery.sizeOf(context).height * 0.3,
              child: const CustomTypeWriterText(),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.3,
                width: MediaQuery.sizeOf(context).width,
                decoration: const BoxDecoration(
                  color: AppTheme.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: Sizes.p16),
                    CustomElevatedIcon(
                      onTap: () async {
                        final ssoService = ref.read(googleAuthServiceProvider);
                        await ssoService.signInWithGoogle();

                        // context.pushNamed(ScreenPath.home.name);
                      },
                      label: 'Continue With Google',
                      imagePath: ImagePaths.google,
                      backgroundColor: AppTheme.white,
                    ),
                    const SizedBox(height: Sizes.p16),
                    CustomElevatedIcon(
                      onTap: () => showAdaptiveDialog(
                        context: context,
                        builder: (context) => const CustomAlertDialog(),
                      ),
                      label: 'Sign up with email',
                      backgroundColor: AppTheme.grey.withOpacity(0.9),
                      iconPath: Icons.email_outlined,
                      textColor: AppTheme.white,
                    ),
                    const SizedBox(height: Sizes.p16),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: Sizes.p32), child: Divider()),
                    const SizedBox(height: Sizes.p16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(Sizes.p48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () async {
                          final ssoService = ref.read(googleAuthServiceProvider);
                          await ssoService.signInWithGoogle();
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(color: AppTheme.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
