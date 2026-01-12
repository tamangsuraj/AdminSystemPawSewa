import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Mock User class for testing without Supabase
class MockUser extends User {
  MockUser({
    required String id,
    required Map<String, dynamic> appMetadata,
    required Map<String, dynamic> userMetadata,
    required String aud,
    required String createdAt,
    String? email,
  }) : super(
          id: id,
          appMetadata: appMetadata,
          userMetadata: userMetadata,
          aud: aud,
          createdAt: createdAt,
          email: email,
        );
}

final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final authStateProvider = StreamProvider<User?>((ref) {
  final supabase = ref.watch(supabaseProvider);
  return supabase.auth.onAuthStateChange.map((data) => data.session?.user);
});

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  return AuthNotifier(ref.watch(supabaseProvider));
});

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final SupabaseClient _supabase;

  AuthNotifier(this._supabase) : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    final user = _supabase.auth.currentUser;
    state = AsyncValue.data(user);
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    
    try {
      // Hardcoded credentials for testing
      if (email.trim().toLowerCase() == 'admin@pawsewa.com' && password == '1Support') {
        // Simulate successful login with mock user
        final mockUser = MockUser(
          id: 'mock-admin-id',
          appMetadata: {},
          userMetadata: {'email': email},
          aud: 'authenticated',
          createdAt: DateTime.now().toIso8601String(),
          email: email,
        );
        
        // Simulate delay
        await Future.delayed(const Duration(milliseconds: 800));
        
        state = AsyncValue.data(mockUser);
        return;
      }
      
      // For real Supabase integration (commented out for now)
      /*
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      if (response.user != null) {
        state = AsyncValue.data(response.user);
      } else {
        state = const AsyncValue.error('Login failed', StackTrace.empty);
      }
      */
      
      // If credentials don't match, show error
      state = const AsyncValue.error('Invalid email or password', StackTrace.empty);
      
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}