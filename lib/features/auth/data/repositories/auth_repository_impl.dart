import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
    required String selectedRole,
  }) async {
    try {
      return await remoteDataSource.login(
        email: email,
        password: password,
        selectedRole: selectedRole,
      );
    } on AuthException catch (e) {
      throw AuthFailure(message: e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(message: e.message);
    } catch (e) {
      throw const ServerFailure();
    }
  }

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      return await remoteDataSource.register(
        name: name,
        email: email,
        password: password,
        role: role,
      );
    } on AuthException catch (e) {
      throw AuthFailure(message: e.message);
    } catch (e) {
      throw const ServerFailure();
    }
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDataSource.logout();
    } catch (_) {
      throw const ServerFailure();
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      return await remoteDataSource.getCurrentUser();
    } catch (_) {
      return null;
    }
  }
}
