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

// Simple auth state provider that tracks current user
final currentUserProvider = StateProvider<User?>((ref) => null);

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final Ref _ref;

  AuthNotifier(this._ref) : super(const AsyncValue.data(null));

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
        
        // Update both providers
        _ref.read(currentUserProvider.notifier).state = mockUser;
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
        _ref.read(currentUserProvider.notifier).state = response.user;
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
      // Clear user state
      _ref.read(currentUserProvider.notifier).state = null;
      state = const AsyncValue.data(null);
      
      // For real Supabase integration
      // await _supabase.auth.signOut();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  User? get currentUser => _ref.read(currentUserProvider);
  bool get isLoggedIn => currentUser != null;
}