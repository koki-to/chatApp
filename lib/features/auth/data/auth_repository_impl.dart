import 'package:chat_app/features/auth/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

final authProvider = Provider<Supabase>((_) => Supabase.instance);

final authRepositoryImplProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.watch(authProvider)),
);

final authStateProvider = StreamProvider(
  (ref) => ref.watch(authRepositoryImplProvider).onAuthStateChange(),
);

final sessionProvider = FutureProvider<Session?>(
  (ref) => ref.watch(authRepositoryImplProvider).currentSession,
);

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._supabase);
  final Supabase _supabase;

  @override
  Session? get currentSession => _supabase.client.auth.currentSession;

  @override
  Stream<AuthState> onAuthStateChange() =>
      _supabase.client.auth.onAuthStateChange;

  @override
  Future<void> signIn({required String email, required String password}) async {
    await _supabase.client.auth
        .signInWithPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await _supabase.client.auth.signOut();
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    await _supabase.client.auth.signUp(
      password: password,
      email: email,
      data: {'username': username},
    );
  }
}
