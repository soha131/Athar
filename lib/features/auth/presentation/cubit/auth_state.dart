import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state — has not checked auth yet
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Checking current auth status (splash screen)
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// User is authenticated and loaded
class AuthAuthenticated extends AuthState {
  final UserEntity user;
  const AuthAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

/// User is not authenticated
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// Login / Register operation in progress
class AuthOperationLoading extends AuthState {
  const AuthOperationLoading();
}

/// Operation succeeded — carries the user
class AuthSuccess extends AuthState {
  final UserEntity user;
  const AuthSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

/// Any auth error
class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Logout completed
class AuthLoggedOut extends AuthState {
  const AuthLoggedOut();
}
