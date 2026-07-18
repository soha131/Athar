import 'package:equatable/equatable.dart';
import '../../../../core/constants/app_constants.dart';

class UserEntity extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String role;
  final String? phone;
  final String? schoolId;
  final String? profileImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isActive;

  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    this.phone,
    this.schoolId,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
    this.isActive = true,
  });

  bool get isAdmin => role == AppConstants.roleAdmin;
  bool get isPrincipal => role == AppConstants.rolePrincipal;
  bool get isTeacher => role == AppConstants.roleTeacher;
  bool get isStudent => role == AppConstants.roleStudent;

  @override
  List<Object?> get props => [uid, name, email, phone, role, schoolId, profileImage, createdAt, updatedAt, isActive];
}
