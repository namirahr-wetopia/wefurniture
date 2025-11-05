import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@injectable
class AuthService {
  final SupabaseClient _supabase;
  AuthService(this._supabase);

  Future<void> signIn(String email, String password) =>
      _supabase.auth.signInWithPassword(email: email, password: password);

  Future<void> signUp(String email, String password, String name) =>
      _supabase.auth.signUp(email: email, password: password, emailRedirectTo: 'myapp://login-callback', data: {name: name});

  User? get currentUser => _supabase.auth.currentUser;
  String? get email => currentUser?.email;
  String? get name => currentUser!.userMetadata?['username'];

  Session? get currentSession => _supabase.auth.currentSession;
  bool get isLoggedIn => _supabase.auth.currentSession != null;

  Future<void> signOut() => _supabase.auth.signOut();
}