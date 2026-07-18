import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_entity.dart';
import '../../../../core/constants/app_constants.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.name,
    required super.email,
    required super.role,
    super.phone,
    super.schoolId,
    super.profileImage,
    super.createdAt,
    super.updatedAt,
    super.isActive,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: data[AppConstants.fieldUid] as String? ?? doc.id,
      name: data[AppConstants.fieldName] as String? ?? '',
      email: data[AppConstants.fieldEmail] as String? ?? '',
      phone: data[AppConstants.fieldPhone] as String?,
      role: data[AppConstants.fieldRole] as String? ?? '',
      schoolId: data[AppConstants.fieldSchoolId] as String?,
      profileImage: data[AppConstants.fieldProfileImage] as String?,
      createdAt: (data[AppConstants.fieldCreatedAt] as Timestamp?)?.toDate(),
      updatedAt: (data[AppConstants.fieldUpdatedAt] as Timestamp?)?.toDate(),
      isActive: data[AppConstants.fieldIsActive] as bool? ?? true,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      uid: entity.uid,
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
      role: entity.role,
      schoolId: entity.schoolId,
      profileImage: entity.profileImage,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      isActive: entity.isActive,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      AppConstants.fieldUid: uid,
      AppConstants.fieldName: name,
      AppConstants.fieldEmail: email,
      AppConstants.fieldPhone: phone,
      AppConstants.fieldRole: role,
      AppConstants.fieldSchoolId: schoolId,
      AppConstants.fieldProfileImage: profileImage,
      AppConstants.fieldCreatedAt: createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
      AppConstants.fieldUpdatedAt: updatedAt != null
          ? Timestamp.fromDate(updatedAt!)
          : FieldValue.serverTimestamp(),
      AppConstants.fieldIsActive: isActive,
    };
  }
}
