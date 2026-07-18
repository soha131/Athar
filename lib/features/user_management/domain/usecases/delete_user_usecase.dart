import '../repositories/user_management_repository.dart';

class DeleteUserUseCase {
  final UserManagementRepository repository;

  DeleteUserUseCase(this.repository);

  Future<void> call(String uid) {
    return repository.deleteUser(uid);
  }
}
