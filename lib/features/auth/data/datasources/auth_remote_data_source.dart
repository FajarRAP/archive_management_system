import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponse> login(String email, String password);
  Future<void> logout();
  Future<List<Map<String, dynamic>>> getCurrentUser(String userId);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required this.supabase});

  final SupabaseClient supabase;

  @override
  Future<AuthResponse> login(String email, String password) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    return await supabase.auth.signOut();
  }

  @override
  Future<List<Map<String, dynamic>>> getCurrentUser(String userId) async {
    return await supabase.from('profiles').select().eq('user_id', userId);
  }
}
