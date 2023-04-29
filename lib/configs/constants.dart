import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabaseにアクセスするためのクライアントインスタンス
final supabase = Supabase.instance.client;

/// シンプルなプリローダー
const preloader =
    Center(child: CircularProgressIndicator(color: Colors.orange));

/// ちょっとした隙間を作るのに便利なウィジェット
const formSpacer = SizedBox(width: 16, height: 16);

/// フォームのパディング
const formPadding = EdgeInsets.symmetric(vertical: 20, horizontal: 16);

/// エラーメッセージ
const unexpectedErrorMessage = '予期せぬエラーが起きました';

extension ShowSnackBar on BuildContext {
  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.white,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  void showErrorSnackBar({required String message}) {
    showSnackBar(
      message: message,
      backgroundColor: Theme.of(this).colorScheme.error,
    );
  }
}
