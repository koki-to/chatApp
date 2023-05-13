import 'package:chat_app/configs/constants.dart';
import 'package:chat_app/features/auth/application/auth_service.dart';
import 'package:chat_app/features/chat/presentation/chat_page.dart';
import 'package:chat_app/features/load/application/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'login_page.dart';

class RegisterPage extends ConsumerWidget {
  RegisterPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => RegisterPage());
  }

  final bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登録'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: formPadding,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                label: Text('メールアドレス'),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return '必須';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            formSpacer,
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                label: Text('パスワード'),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return '必須';
                }
                if (val.length < 6) {
                  return '6文字以上';
                }
                return null;
              },
            ),
            formSpacer,
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                label: Text('ユーザー名'),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return '必須';
                }
                final isValid = RegExp(r'^[A-Za-z0-9_]{3,24}$').hasMatch(val);
                if (!isValid) {
                  return '3~24文字のアルファベットか文字で入力してください';
                }
                return null;
              },
            ),
            formSpacer,
            ElevatedButton(
              onPressed: () async {
                try {
                  await ref.read(authServiceProvider).signUp(
                        email: _emailController.text,
                        password: _passwordController.text,
                        username: _usernameController.text,
                      );
                  Navigator.of(context)
                      .pushAndRemoveUntil(ChatPage.route(), (route) => false);
                } on AuthException catch (error) {
                  ref
                      .read(scaffoldMessengerServiceProvider)
                      .showSnackBar(error.message);
                } catch (e) {
                  ref
                      .read(scaffoldMessengerServiceProvider)
                      .showSnackBar(unexpectedErrorMessage);
                }
              },
              child: const Text('登録'),
            ),
            formSpacer,
            TextButton(
              onPressed: () {
                Navigator.of(context).push(LoginPage.route());
              },
              child: const Text('すでにアカウントをお持ちの方はこちら'),
            )
          ],
        ),
      ),
    );
  }
}
