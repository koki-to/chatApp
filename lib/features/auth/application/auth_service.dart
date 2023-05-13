import 'package:chat_app/features/auth/data/auth_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider((ref) {
  return AuthService(ref);
});

class AuthService {
  AuthService(this.ref);
  final Ref ref;

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      return;
    }
    await ref
        .watch(authRepositoryImplProvider)
        .signUp(email: email, password: password, username: username);
  }

  Future<void> signIn({required String email, required String password}) async {
    await ref
        .watch(authRepositoryImplProvider)
        .signIn(email: email, password: password);
  }
}
