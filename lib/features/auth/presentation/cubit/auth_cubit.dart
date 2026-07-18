import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../../../core/errors/failures.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final RegisterUseCase registerUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
    required this.registerUseCase,
  }) : super(const AuthInitial());

  /// Called on splash screen — determine if user is already signed in
  Future<void> checkAuthStatus() async {
    emit(const AuthLoading());
    try {
      final user = await getCurrentUserUseCase();
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (_) {
      emit(const AuthUnauthenticated());
    }
  }

  /// Login with email, password and selected role
  Future<void> login({
    required String email,
    required String password,
    required String selectedRole,
  }) async {
    emit(const AuthOperationLoading());
    try {
      final user = await loginUseCase(
        email: email,
        password: password,
        selectedRole: selectedRole,
      );
      emit(AuthSuccess(user: user));
    } on AuthFailure catch (e) {
      emit(AuthError(message: e.message));
    } on NetworkFailure catch (e) {
      emit(AuthError(message: e.message));
    } on ServerFailure catch (e) {
      emit(AuthError(message: e.message));
    } catch (_) {
      emit(const AuthError(message: 'حدث خطأ غير متوقع'));
    }
  }

  /// Register new user
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    emit(const AuthOperationLoading());
    try {
      final user = await registerUseCase(
        name: name,
        email: email,
        password: password,
        role: role,
      );
      emit(AuthSuccess(user: user));
    } on AuthFailure catch (e) {
      emit(AuthError(message: e.message));
    } catch (_) {
      emit(const AuthError(message: 'حدث خطأ غير متوقع'));
    }
  }

  /// Logout current user
  Future<void> logout() async {
    emit(const AuthOperationLoading());
    try {
      await logoutUseCase();
      emit(const AuthLoggedOut());
    } catch (_) {
      emit(const AuthError(message: 'فشل تسجيل الخروج'));
    }
  }

  /// Clear error state (e.g., when user dismisses snackbar)
  void clearError() {
    if (state is AuthError) {
      emit(const AuthUnauthenticated());
    }
  }
}
