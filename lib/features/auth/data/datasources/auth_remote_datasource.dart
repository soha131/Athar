import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/errors/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
    required String selectedRole,
  });

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String role,
  });

  Future<void> logout();

  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  CollectionReference get _usersCollection =>
      firestore.collection(AppConstants.usersCollection);

  @override
  Future<UserModel> login({
    required String email,
    required String password,
    required String selectedRole,
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final uid = credential.user!.uid;
      final doc = await _usersCollection.doc(uid).get();

      if (!doc.exists) {
        await firebaseAuth.signOut();
        throw const AuthException(message: AppStrings.errorUserNotFound);
      }

      final userModel = UserModel.fromFirestore(doc);

      // Validate role matches the selected role
      if (userModel.role != selectedRole) {
        await firebaseAuth.signOut();
        throw const AuthException(message: AppStrings.errorRoleMismatch);
      }

      return userModel;
    } on FirebaseAuthException catch (e) {
      await firebaseAuth.signOut();
      throw AuthException(message: _mapFirebaseAuthError(e.code));
    } on AuthException {
      rethrow;
    } catch (e) {
      throw const AuthException(message: AppStrings.errorUnknown);
    }
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final uid = credential.user!.uid;
      final userModel = UserModel(
        uid: uid,
        name: name.trim(),
        email: email.trim(),
        role: role,
        createdAt: DateTime.now(),
      );

      await _usersCollection.doc(uid).set(userModel.toFirestore());

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: _mapFirebaseAuthError(e.code));
    } catch (e) {
      throw const AuthException(message: AppStrings.errorUnknown);
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final firebaseUser = firebaseAuth.currentUser;
      if (firebaseUser == null) return null;

      final doc = await _usersCollection.doc(firebaseUser.uid).get();
      if (!doc.exists) return null;

      return UserModel.fromFirestore(doc);
    } catch (_) {
      return null;
    }
  }

  String _mapFirebaseAuthError(String code) {
    switch (code) {
      case 'user-not-found':
        return AppStrings.errorUserNotFound;
      case 'wrong-password':
      case 'invalid-credential':
        return AppStrings.errorWrongPassword;
      case 'email-already-in-use':
        return AppStrings.errorEmailAlreadyInUse;
      case 'weak-password':
        return AppStrings.errorWeakPassword;
      case 'invalid-email':
        return AppStrings.errorEmailInvalid;
      case 'network-request-failed':
        return AppStrings.errorNetworkError;
      default:
        return AppStrings.errorUnknown;
    }
  }
}
