import 'package:chat_app/configs/constants.dart';
import 'package:chat_app/features/auth/application/auth_service.dart';
import 'package:chat_app/features/chat/presentation/chat_page.dart';
import 'package:chat_app/features/load/application/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => LoginPage());
  }

  // bool _isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('ログイン')),
      body: ListView(
        padding: formPadding,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'メールアドレス'),
            keyboardType: TextInputType.emailAddress,
          ),
          formSpacer,
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'パスワード'),
            obscureText: true,
          ),
          formSpacer,
          ElevatedButton(
            onPressed: () async {
              try {
                await ref.watch(authServiceProvider).signIn(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                await Navigator.of(context)
                    .pushAndRemoveUntil(ChatPage.route(), (route) => false);
              } on AuthException catch (e) {
                ref
                    .watch(scaffoldMessengerServiceProvider)
                    .showSnackBar('ログインに失敗しました。入力値をご確認ください。');
              } catch (e) {
                ref
                    .read(scaffoldMessengerServiceProvider)
                    .showSnackBar(unexpectedErrorMessage);
              }
            },
            child: const Text('ログイン'),
          ),
        ],
      ),
    );
  }
}
