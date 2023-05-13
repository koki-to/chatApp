import 'package:chat_app/configs/constants.dart';
import 'package:chat_app/features/auth/data/auth_repository_impl.dart';
import 'package:chat_app/features/chat/presentation/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'register_page.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(sessionProvider).when(
          data: (session) {
            if (session == null) {
              return RegisterPage();
            } else {
              return const ChatPage();
            }
          },
          error: (e, s) {
            return const Text('エラー');
          },
          loading: () => preloader,
        );
  }
}
