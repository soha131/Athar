class AppConstants {
  AppConstants._();

  // User Roles
  static const String roleAdmin = 'admin';
  static const String rolePrincipal = 'principal';
  static const String roleTeacher = 'teacher';
  static const String roleStudent = 'student';

  static const List<String> allRoles = [
    roleAdmin,
    rolePrincipal,
    roleTeacher,
    roleStudent,
  ];

  // Firestore Collections
  static const String usersCollection = 'users';
  static const String schoolsCollection = 'schools';
  static const String gradesCollection = 'grades';
  static const String classesCollection = 'classes';
  static const String subjectsCollection = 'subjects';
  static const String teacherAssignmentsCollection = 'teacherAssignments';
  static const String studentProfilesCollection = 'studentProfiles';

  // Firestore Fields
  static const String fieldUid = 'uid';
  static const String fieldName = 'name';
  static const String fieldEmail = 'email';
  static const String fieldPhone = 'phone';
  static const String fieldRole = 'role';
  static const String fieldProfileImage = 'profileImage';
  static const String fieldSchoolId = 'schoolId';
  static const String fieldCreatedAt = 'createdAt';
  static const String fieldUpdatedAt = 'updatedAt';
  static const String fieldIsActive = 'isActive';
  
  // Structure Fields
  static const String fieldGradeId = 'gradeId';
  static const String fieldClassId = 'classId';
  static const String fieldSubjectId = 'subjectId';
  static const String fieldTeacherId = 'teacherId';
  static const String fieldStudentId = 'studentId';
  static const String fieldAssignmentId = 'assignmentId';

  // Animation Durations
  static const Duration animFast = Duration(milliseconds: 200);
  static const Duration animNormal = Duration(milliseconds: 350);
  static const Duration animSlow = Duration(milliseconds: 500);
  static const Duration splashDuration = Duration(seconds: 3);

  // UI Constants
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusFull = 100.0;

  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXL = 32.0;

  static const double elevationCard = 4.0;
  static const double elevationModal = 8.0;

  // SharedPreferences Keys
  static const String prefOnboarding = 'onboarding_done';
  static const String prefUserId = 'user_id';
  static const String prefUserRole = 'user_role';
}
