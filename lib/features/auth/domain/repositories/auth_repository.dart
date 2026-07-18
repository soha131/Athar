import '../entities/user_entity.dart';

abstract class AuthRepository {
  /// Login with email & password, validates role against Firestore
  Future<UserEntity> login({
    required String email,
    required String password,
    required String selectedRole,
  });

  /// Register a new user with Firestore user document
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
    required String role,
  });

  /// Logout the current user
  Future<void> logout();

  /// Get currently authenticated user with Firestore profile
  Future<UserEntity?> getCurrentUser();
}
