import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt_clone/feature/gpt_clone/services/google_auth_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/go_router.dart';

class ProfileSettingPage extends ConsumerWidget {
  const ProfileSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Setting'),
      ),
      // logout buttons and all profile
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.logout),
          label: const Text('Logout'),
          onPressed: () async {
            final goContext = GoRouter.of(context);

            final bool? isLogout = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Logout'),
                content: const Text('Are you sure you want to logout?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      goContext.pop(false);
                    },
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      goContext.pop(true);
                    },
                    child: const Text('Yes'),
                  ),
                ],
              ),
            );

            log('isLogout: $isLogout');
            if (isLogout == null || !isLogout) {
              return;
            }

            final ssoService = ref.read(googleAuthServiceProvider);
            await ssoService.signOut();
            // logout
            goContext.goNamed(ScreenPath.login.name);
          },
        ),
      ),
    );
  }
}
